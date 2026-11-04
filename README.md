<div align="center">

<img src="assets/images/background/cpuSelect.jpg" alt="AMD Ryzen banner" width="100%">

# AMD Semiconductors — Product Showcase & Admin CMS

**A PHP + MySQL website built in 2019 as a 5th-semester BCA project: an AMD-branded storefront for Ryzen CPUs and Radeon GPUs, with a full admin panel behind it.**

[![PHP](https://img.shields.io/badge/PHP-7.x-777BB4?logo=php&logoColor=white)](#tech-stack)
[![MySQL](https://img.shields.io/badge/MySQL-MariaDB%2010.3-4479A1?logo=mysql&logoColor=white)](#tech-stack)
[![jQuery](https://img.shields.io/badge/jQuery-3.4.1-0769AD?logo=jquery&logoColor=white)](#tech-stack)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[Project report](docs/project-report.pdf) · [Architecture](docs/ARCHITECTURE.md) · [Setup](docs/SETUP.md) · [Known limitations](#known-limitations)

</div>

---

## What this is

This is a **student-era, server-rendered PHP application** — the kind of project you write once to prove you can wire forms, sessions, file uploads and a database together end to end. It is an AMD-themed marketing site (an unaffiliated college recreation): product catalogue, news desk, feedback inbox, user accounts, and an admin panel that manages all of it.

It was built for **BCA, V.J. Modha College, Porbandar (BKNMU)**, October 2019, and is preserved here as a portfolio piece. The full [project report](docs/project-report.pdf) (SRS, DFDs, ER diagrams, use cases) is included.

> **Note on this snapshot:** the code is kept byte-for-byte as it was written in 2019 — no refactors, no framework migration. Where it was rough, it is still rough, and that is deliberate. See [known limitations](#known-limitations) for exactly where.

Previously published as `UGProject`; the folder was renamed in 2026 so the repository says what it contains.

## Features

### Public site

| Area | What it does |
| --- | --- |
| **Home** | Parallax landing page that also pulls the two most recently added products from the database. |
| **Processors** | Marketing page for 3rd-gen Ryzen, then a Server-Grade / Consumer-Grade picker and a filterable CPU listing. |
| **Graphics cards** | Same shape for Radeon, including before/after image-comparison sliders for Radeon Image Sharpening, FidelityFX and FreeSync. |
| **Product detail** | Full spec sheet (cores/threads, clocks, cache, TDP, VRAM, compute units) plus an external "buy" link. |
| **News** | Admin-written articles rendered newest-first. |
| **Games** | Radeon game-promo gallery. |
| **Feedback** | Logged-in users submit feedback; it is timestamped with IP, date and time. |
| **Accounts** | Register (with jQuery regex validation), log in, view your own account page, log out. |
| **Contact** | Static contact/address page. |

### Admin panel (`/admin`)

| Area | What it does |
| --- | --- |
| **Admin login** | Separate login gate that additionally requires `login.admin = 1`. |
| **CPU / GPU CRUD** | Insert products (with image upload), or pick an existing one to update or delete. |
| **News CRUD** | Insert, update and delete news posts. |
| **Feedback inbox** | Read every feedback entry, reply by `mailto:`, delete. |
| **Users** | List every account, toggle the admin flag, delete accounts. |
| **Visit log** | `index.php` records every landing hit (IP, date, time) into `index_page_visits`. |

## Tech stack

| Layer | Choice |
| --- | --- |
| Server | PHP 7.3 (procedural, `mysqli`) — no framework, no Composer |
| Database | MariaDB 10.3 / MySQL (`project` schema) |
| Client | HTML5, CSS3, jQuery 3.4.1 (vendored at `jquery-3.4.1.js`) |
| Media | Custom CSS parallax, `<video>` backgrounds, drag-to-compare image sliders |
| Hosting target | Apache under XAMPP, served from `htdocs/project` |

## Repository layout

```text
.
├── index.php                  # Landing hit logger, redirects to home.php
├── home.php                   # Home page + "newest CPU/GPU" blocks
├── games.php  contactUs.php   # Static promo / contact pages
├── login.php  register.php  logout.php  accountDisplay.php
├── nav.php  footer.php        # Shared header + footer includes
├── connection.php             # mysqli wrapper class (`connect`)
├── database/
│   └── schema.sql            # Full schema + 2019 seed data
├── assets/                    # Public-facing pages and images
│   ├── processor_select.php  gpu_select.php       # Category marketing
│   ├── cpu_display.php  gpu_display.php           # Listings (?type=server|consumer)
│   ├── cpuDetailedDisplay.php  gpuDetailedDisplay.php
│   ├── newsDisplay.php  feedback.php
│   ├── nav.php  footer.php  login.php             # Sub-directory includes
│   └── images/                                    # 80+ banners, logos, product art
├── admin/                     # Admin panel (login, CRUD, inbox, users)
├── style/                     # 33 per-page stylesheets
├── docs/                      # Project report + contributor notes
└── test/                      # Abandoned CSS/PHP experiments
```

Two things in this tree explain most of the odd-looking code:

1. **Pages are deployed as the web root folder `project`.** Navigation links are absolute (`http://localhost/project/...`), so the folder must be named exactly `project` under `htdocs`.
2. **There are two `nav.php` / `footer.php` pairs** — one for the root pages, one for `assets/` pages — because `include()` resolves relative to the including script's directory.

## Getting started

Full instructions, including XAMPP configuration and troubleshooting, are in **[docs/SETUP.md](docs/SETUP.md)**. Short version:

```bash
# 1. Place the code so Apache sees it as /project
git clone git@github.com:ezyway/amd-semiconductors-website.git /path/to/xampp/htdocs/project

# 2. Start Apache + MySQL, then import the schema
mysql -u root -p < database/schema.sql

# 3. Check credentials in connection.php (defaults: root / no password / db "project")
# 4. Browse to http://localhost/project/home.php
```

**Seed admin account:** `sreyas` / `12` — then open `http://localhost/project/admin/login.php`. Passwords in the seed dump are stored in plain text, so the short one works as-is.

**Expected gaps in this snapshot:**

- `upload/` is not committed, so product thumbnails (`upload/cpu/...`, `upload/gpu/...`) 404 until you add images or upload new products through the admin panel.
- `assets/videos/` is not committed, so the `<video>` elements stay blank.
- `aboutUS.php` is linked from both nav bars but missing from the snapshot, so "About Us" 404s.

## How the pieces fit together

```text
Browser → index.php ──(logs hit)──► home.php
                                     │
                     nav.php (session bootstrap + menu)
                                     │
        ┌────────────────────────────┼────────────────────────────┐
        ▼                            ▼                            ▼
   assets/*.php                 login.php                    admin/login.php
   (public catalogue)      (session["login"])          (session["admin"] = 1)
        │                            │                            │
        └────────────► connection.php ◄──────────────────────────┘
                    (query_s / query_idu → mysqli)
                                     │
                                database "project"
```

Sessions are the whole of the access control: `admin/*.php` starts with `if($_SESSION["admin"])` and bounces to `login.php` otherwise; `accountDisplay.php` and `feedback.php` check `$_SESSION["login"]`. There is no CSRF token, no password hash and no prepared statement anywhere — see below.

## Data model

`schema.sql` creates six tables:

| Table | Purpose |
| --- | --- |
| `cpu` | CPU spec sheet: series, name, cores/threads, clocks, transistor size, caches, cooler, TDP, price, buy URL, type, image |
| `gpu` | GPU spec sheet: series, name, compute/texture units, stream processors, clocks, transistor size and count, outputs, memory type, VRAM, price, buy URL, type, image |
| `news` | Article title (`about`), `content`, author, timestamp, IP |
| `login` | Accounts: name, username, plain-text password, `admin` flag, mobile, e-mail, DOB |
| `feedback` | Submitted feedback with contact details, timestamp and IP |
| `index_page_visits` | Landing-page hit log (IP, date, time) — no read UI, logging only |

Details, including the column-level map the pages rely on, are in [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## Known limitations

Documented rather than fixed, so the code stays a faithful 2019 artefact:

- **SQL injection everywhere.** Query strings are built by interpolation (`... where username='$username'`), never with `mysqli_prepare`.
- **Plain-text passwords.** `login.password` is `varchar(30)` and compared literally.
- **No CSRF protection** on any POST form, and destructive actions (`users.php?deleteId=`, `feedback.php?id=`) are plain GET links.
- **Hardcoded `http://localhost/project/`** in `nav.php`, `assets/nav.php`, `footer.php` and `admin/adminNav.php`; the site breaks under any other base path.
- **Upload paths assume a `/project` document root** (`$root."/project/upload/cpu/"`), so uploads silently fail elsewhere.
- **Column access is positional** (`$temp[17]`, `$temp[12]`), so any schema reordering breaks rendering.
- **Only one page reads `discount`.** Most CPU/GPU columns are write-only through the admin forms.
- **Mixed line endings** — files are CRLF; `.gitattributes` has been added so clones normalise to LF.
- **`test/` is dead code** — duplicate, earlier versions of `admin/*_ud.php`, kept for reference.

## Documentation

| Document | Contents |
| --- | --- |
| [docs/project-report.pdf](docs/project-report.pdf) | Full academic report: SRS, DFDs, ER diagram, use cases, layouts, limitations (PDF) |
| [docs/project-report.docx](docs/project-report.docx) | Same report, editable |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Page map, request/session flow, table and column reference |
| [docs/SETUP.md](docs/SETUP.md) | Local installation, configuration, troubleshooting |
| [docs/DEVELOPMENT-NOTES.md](docs/DEVELOPMENT-NOTES.md) | Original author's scratch notes (session flags, ripple-effect links) |

## License & credit

Released under the [MIT License](LICENSE). Written by **C. V. Sreyas DeviPrasad** for the BCA programme at Shri V.J. Modha College, Porbandar, guided by Mr. Thakrar Zalak.

AMD, Ryzen, Radeon, Wraith and related marks belong to Advanced Micro Devices, Inc. Product imagery is used here for academic, non-commercial purposes.
