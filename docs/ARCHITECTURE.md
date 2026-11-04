# Architecture

A map of the application for anyone reading it cold. Everything here describes the code **as it is in this repository** — where it is inconsistent, that is documented rather than smoothed over.

## Runtime shape

No framework, no autoloader, no Composer, no routing layer. Every URL is a physical `.php` file, and almost every file is three things stapled together: a PHP/`include` block at the top, an HTML document in the middle, and a POST/GET handler at the bottom.

```text
index.php ──► home.php ──► nav.php ──► page body ──► footer.php
     │            │
     │            └── connection.php ──► mysqli ──► "project" database
     └── INSERT INTO index_page_visits
```

### Includes and the duplicate nav/footer

`include("nav.php")` resolves relative to the including script's own directory. That is why there are two copies of each shared partial:

| Partial | Used by | Notes |
| --- | --- | --- |
| `nav.php` | root-level pages | Calls `session_start()` and seeds `$_SESSION["login"]` |
| `assets/nav.php` | `assets/*.php` pages | Same, but `../style/nav.css` and `../` URLs |
| `footer.php` / `assets/footer.php` | respective levels | Social links + Contact/Feedback |

Because both navs seed `$_SESSION["login"]` and `assets/nav.php` *also* seeds it, a logged-out visit to any page leaves `$_SESSION["login"] = "RandomValue"` rather than unset. `accountDisplay.php` and `assets/feedback.php` only test `if($_SESSION["login"])`, so that placeholder string is truthy and the pages load; `nav.php` specifically tests `=== true` before showing the "Welcome" link, which is why the menu correctly shows "Login".

### Sessions

| Key | Set in | Meaning |
| --- | --- | --- |
| `login` | `login.php` (true), nav includes ("RandomValue") | Client login state |
| `FirstName`, `username` | `login.php`, `admin/login.php` | Welcome text + account/news authoring |
| `admin` | `admin/login.php` (true), `admin/a.php` / `admin/af.php` (manual toggle) | Admin gate |
| `WrongUsername`, `WrongPassword`, `NotAdmin` | login pages | One-shot error flags, reset after render |
| `queryStatusFeedback` | `assets/feedback.php` | One-shot insert success/failure flag |
| `UsernameTaken` | `register.php` | One-shot duplicate-username flag |

There is no session regeneration, no expiry handling and no CSRF token.

## Access control

Two independent gates, both implemented as a wrapper check:

- **Client pages**: `accountDisplay.php` and `assets/feedback.php` start with `if($_SESSION["login"]) { ... } else header("Location: login.php")`.
- **Admin pages**: every `admin/*.php` file includes `adminNav.php` and then runs `if($_SESSION["admin"]) { ... } else header("Location: login.php")`.

`admin/login.php` is the only place that authenticates: it first matches username+password, then *re-queries* with `and admin=1` and sets `$_SESSION["admin"]=true` only if a row survives. `admin/a.php` and `admin/af.php` force the flag on and off respectively, for manual testing.

The HTML body of gated pages is emitted *after* the check but the POST handler sits *below* the closing `</html>` — so a redirect can happen after output has started (fine here only because output buffering happens to be on).

## Page map

| Route | Gate | Database work |
| --- | --- | --- |
| `index.php` | none | `INSERT index_page_visits`, then redirect to `home.php` |
| `home.php` | none | `SELECT * FROM cpu/gpu ORDER BY no DESC LIMIT 1` |
| `games.php`, `contactUs.php` | none | none |
| `register.php` | none | `SELECT login` (dupe check) then `INSERT login` |
| `login.php` | none | `SELECT login` for username, password, `admin` |
| `accountDisplay.php` | `login` | `SELECT login` for the session username |
| `logout.php` | none | `session_destroy()`, redirect to `index.php` |
| `dis.php` | none | echoes `$_SESSION["login"]` (debug) |
| `assets/processor_select.php`, `assets/gpu_select.php` | none | none (static marketing) |
| `assets/cpu_display.php`, `assets/gpu_display.php` | none | `SELECT * FROM cpu/gpu WHERE type='$_GET[type]'` |
| `assets/cpuDetailedDisplay.php`, `assets/gpuDetailedDisplay.php` | none | `SELECT ... WHERE no='$_GET[id]'` |
| `assets/newsDisplay.php` | none | `SELECT * FROM news ORDER BY id DESC` |
| `assets/feedback.php` | `login` | `SELECT login` (prefill), `INSERT feedback` |
| `admin/login.php` | none | `SELECT login` ×3 |
| `admin/index.php` | `admin` | none |
| `admin/cpu_insert.php`, `admin/gpu_insert.php` | `admin` | `INSERT cpu/gpu`, moves the uploaded file |
| `admin/cpu_ud.php`, `admin/gpu_ud.php` | `admin` | `SELECT`, `UPDATE`, `DELETE` on cpu/gpu |
| `admin/news_insert.php` | `admin` | `INSERT news` |
| `admin/news_ud.php` | `admin` | `SELECT`, `UPDATE`, `DELETE` on news |
| `admin/feedback.php` | `admin` | `SELECT feedback`, `DELETE` by `?id=` |
| `admin/users.php` | `admin` | `SELECT login`, `UPDATE login.admin`, `DELETE login` |

`test/admin/ud/*` are earlier duplicates of the `admin/*_ud.php` editors with a hardcoded `$username="sreyas"` and stylesheet paths that no longer resolve. Nothing includes them.

## Database

`connection.php` defines class `connect` with hardcoded `localhost` / `root` / empty password / database `project`, instantiates `$con_obj`, and exposes two helpers:

```php
$con_obj->query_s($sql);   // returns the mysqli_result, or 0 on failure
$con_obj->query_idu($sql); // returns 1 on success, 0 on failure
```

Neither prepares statements; both are called with interpolated strings.

### Tables

| Table | Key | Rows read by |
| --- | --- | --- |
| `cpu` | `no` PK | `home.php`, `assets/cpu_display.php`, `assets/cpuDetailedDisplay.php`, `admin/*_ud.php` |
| `gpu` | `no` PK | `home.php`, `assets/gpu_display.php`, `assets/gpuDetailedDisplay.php`, `admin/*_ud.php` |
| `news` | `id` PK | `assets/newsDisplay.php`, `admin/news_ud.php` |
| `login` | `no` PK | all auth pages, `accountDisplay.php`, `admin/users.php` |
| `feedback` | `no` PK | `admin/feedback.php` |
| `index_page_visits` | `sr` PK | none (write-only) |

### Positional column contract

Templates read columns by **numeric index** from `mysqli_fetch_array()` (no `MYSQLI_ASSOC`), so the SELECT order and the schema order are load-bearing:

| Index | `cpu` | `gpu` |
| --- | --- | --- |
| 0 | `no` | `no` |
| 1 | `series` | `series` |
| 2 | `name` | `name` |
| 3 | `cores_threads` | `compute_units` |
| 4 | `stock_freq` | `stream_processors` |
| 5 | `boost_freq` | `texture_units` |
| 6 | `transistor_size` | `stock_freq` |
| 7 | `total_cache` | `boost_freq` |
| 8 | `l1` | `game_freq` |
| 9 | `l2` | `transistor_size` |
| 10 | `l3` | `transistor_count` |
| 11 | `cooler` | `output` |
| 12 | `TDP` | `memory_type` |
| 13 | `prize` | `VRAM` |
| 14 | `discount` | `prize` |
| 15 | `url` | `discount` |
| 16 | `type` | `url` |
| 17 | `img` | `type` |
| 18 | — | `img` |

`login` maps 0 `no`, 1 `first_name`, 2 `last_name`, 3 `username`, 4 `password`, 5 `admin`, 6 `mobile_number`, 7 `email`, 8 `dob`; `news` maps 0 `id`, 1 `name`, 2 `about`, 3 `content`, 4 `date`, 5 `time`, 6 `ip`; `feedback` maps 0 `no`, 1 `name`, 2 `email`, 3 `phone`, 4 `date`, 5 `time`, 6 `ip`, 7 `feedback`.

`cpu.discount` and `gpu.discount` are written by the UI but never rendered. `cpu.type` / `gpu.type` are the only filterable columns (`server` or `consumer`) and drive the category links.

## Uploads

`admin/cpu_insert.php` and `admin/gpu_insert.php` accept `multipart/form-data`, copy the file to a path built as `$root."/project/upload/cpu/".$pic_name` and store the *relative* path `upload/cpu/<name>` in `img`. `$root` is `$_SERVER["DOCUMENT_ROOT"]`, so the literal `/project` segment is baked in; the `upload/` tree must exist and be writable. The update pages repeat the same logic.

Product images are then rendered as `../<?php echo $temp[17]; ?>` from inside `assets/`, which resolves to `/project/upload/...`. `upload/` is not present in this snapshot, so seeded products render broken images until files are added or a product is re-uploaded.

## Front-end conventions

- Each page has its own stylesheet in `style/`, linked with `</link>` closing tags (legal in HTML5, odd-looking).
- `jquery-3.4.1.js` is vendored at the repository root and re-included per page; AJAX is never actually used, jQuery is used for `$(document).ready` and validation only.
- `index.php` and `assets/feedback.php` build a date/time stamp client-side in JS and post it in hidden/`.date_textbox` fields. Server time is therefore whatever the browser claims.
- `register.php` validates names, username/password complexity, mobile and e-mail with inline regex `alert()`s — client-side only.
- `assets/gpu_select.php` embeds a hand-rolled image-comparison slider (`initComparisons`) with `mousedown`/`touchstart` handlers.
- `assets/footer.php` and `footer.php` hardcode absolute `http://localhost/project/` links and AMD's real social accounts.
