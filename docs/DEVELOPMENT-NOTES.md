# Development notes

The author's own scratch file from 2019, kept for context (`META DATA.txt`, renamed and formatted). These are live reminders, not finished documentation — several items were never resolved.

## Outstanding work noted at the time

- `footer.php` — image placement and social/contact links.
- `nav.php` — menu links.
- **`DATABASE`** — left as a bare heading; no notes were written.

## Reference material

Ripple effect on button click, from two CSS tutorials:

- <https://www.skptricks.com/2018/01/ripple-effect-animation-on-button-click-with-css3.html>
- <https://codepen.io/finnhvman/pen/jLXKJw?editors=0100>

## Session work

- "Set session shit for the `news_ud.php`." — session handling for the news editor was still open. In the committed code, `news_ud.php` and `news_insert.php` both hardcode `$username="sreyas"` instead of reading `$_SESSION['username']`.

## Session variable convention

> `$_SESSION["QueryStatus"] == 0;` — see whether the query fired successfully. Works differently on each page (e.g. `cpu_insert.php`).

In practice this convention is inconsistent. `cpu_insert.php` and `gpu_insert.php` use a numeric `$_SESSION["QueryStatus"]`; `assets/feedback.php` uses the string flag `$_SESSION["queryStatusFeedback"]` with values `"Inserted"` / `"Not Inserted"`. `news_ud.php` was never converted to either.
