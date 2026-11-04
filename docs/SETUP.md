# Setup

Local install of a 2019 PHP 7 / MySQL application. Nothing here changes the code; it only gets the existing code running.

## Requirements

| | |
| --- | --- |
| PHP | 7.0–7.4 (written against 7.3; `mysqli` extension required). PHP 8 mostly works but throws deprecation notices on unquoted array keys. |
| Database | MySQL 5.7+ or MariaDB 10.3+ |
| Web server | Apache with `mod_php` — the simplest route is XAMPP, which ships Apache, PHP and MySQL together |
| Base path | **The folder must be named `project`** and sit inside the document root |

The base-path rule is not optional: `nav.php`, `assets/nav.php`, `footer.php` and `admin/adminNav.php` hardcode `http://localhost/project/...`, and the upload handlers build paths against `DOCUMENT_ROOT . "/project/upload/..."`.

## 1. Install a stack

**XAMPP** (Windows / macOS / Linux): download from apachefriends.org, install, and start **Apache** and **MySQL** from the XAMPP control panel.

Distro-package alternative (Debian/Ubuntu):

```bash
sudo apt install apache2 mariadb-server php php-mysql libapache2-mod-php
sudo systemctl start apache2 mariadb
```

## 2. Place the code

Clone into the document root under the exact name `project`:

```bash
# XAMPP on Linux
git clone git@github.com:ezyway/amd-semiconductors-website.git /opt/lampp/htdocs/project

# XAMPP on macOS
git clone git@github.com:ezyway/amd-semiconductors-website.git /Applications/XAMPP/htdocs/project

# XAMPP on Windows (Git Bash)
git clone git@github.com:ezyway/amd-semiconductors-website.git /c/xampp/htdocs/project
```

Confirm the tree looks like `.../htdocs/project/home.php` — not `.../htdocs/project/amd-semiconductors-website/home.php`.

## 3. Create the database

The dump creates the `project` database itself, all six tables and the 2019 seed rows.

```bash
mysql -u root -p < database/schema.sql
```

Under XAMPP the `root` account has no password by default, so `mysql -u root < database/schema.sql` is enough. Import it through phpMyAdmin (Import → choose `database/schema.sql`) if you prefer a GUI.

## 4. Point the app at your database

Open `connection.php`. The defaults are:

```php
public $host     = "localhost";
public $username = "root";
public $password = "";
public $database = "project";
```

If your MySQL user or password differs, edit those four lines. This is the only configuration the project has.

## 5. Create the upload directory

Product images are written to `upload/cpu/` and `upload/gpu/` relative to the document root, and that folder is not tracked in this snapshot. Create it and make it writable by Apache:

```bash
mkdir -p upload/cpu upload/gpu
chmod -R 775 upload        # Linux/macOS
```

Without it, saving a product from the admin panel reports a failed insert. Seeded products point at `upload/cpu/Ryzen9_3900X.jpg` and similar, so their thumbnails stay broken until you drop matching files in or re-upload each product.

## 6. Run it

1. Open <http://localhost/project/home.php>.
2. Admin panel: <http://localhost/project/admin/login.php>.
3. Seed admin account: **`sreyas` / `12`**.
4. Client account (optional): register through the UI, or use the seeded non-admin **`q` / `q`**.

Registration enforces a strict client-side rule — 8+ characters with an upper-case letter, a lower-case letter and a digit — so `q` cannot be re-created through the form even though it seeded fine.

## Expected gaps

These are properties of the snapshot, not setup mistakes:

| Symptom | Cause | Fix |
| --- | --- | --- |
| "About Us" 404s | `aboutUS.php` is missing (linked from both navs) | Add the page, or ignore |
| Blank `<video>` boxes on Processors / Graphics / Login / Register | `assets/videos/` is missing | Supply `amdTrailer_login.mp4`, `trailer_register.mp4`, `RDNA.mp4`, `gameCache.mp4`, `precisionBoost2.mp4`, `oneClickOverclockin.mp4` |
| Broken product thumbnails | `upload/` is missing (see step 5) | Add images or re-upload products |
| Empty listings | `cpu` / `gpu` seed rows use `type` values `server` / `consumer`; a product saved without picking one is invisible | Always choose a grade on the insert form |

## Troubleshooting

**"Connection to the Database was Failed"** — MySQL is not running, or the credentials in `connection.php` are wrong. Start MySQL and re-check step 4.

**Redirect loop / "headers already sent"** — output began before `header()` ran. This code relies on output buffering. Keep `output_buffering=4096` (the PHP default) in `php.ini`, or add `ob_start()` — but note that adding it is a code change.

**Undefined index warnings for `$_SESSION["Admin"]`, `$_SESSION["login"]`** — the navs initialise most session keys, but pages reached directly can warn. Warnings do not stop rendering; raise `error_reporting` to `E_ALL & ~E_NOTICE` to quieten them.

**Nav links jump to the wrong place** — you cloned under a different folder name; rename it to `project`.

**Everything renders unstyled** — a 404 on `style/*.css` usually means the base path is wrong, not a missing stylesheet; every stylesheet in `style/` exists.

**CRLF diffs on every file** — the 2019 sources used CRLF. `.gitattributes` now normalises to LF, so a diff after a fresh clone is normal.

## Deploying anywhere else

Apache alone is fine, but the hardcoded `localhost/project` means a real host breaks `nav.php`, `footer.php`, `admin/adminNav.php` and the upload paths. Options, in order of effort:

1. Serve it at `http://<host>/project` and leave the code alone.
2. Add a `/project` alias (`Alias /project "/srv/amd-semiconductors-website"`).
3. Grep for `localhost/project` and `"/project/upload/"` and replace the base path — the only real code edit required.
