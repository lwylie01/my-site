# Data with a Plot — site guide for coding sessions

Quarto website (datawithaplot.org), published by `.github/workflows/publish.yml`
on every push to `main` (renders with R + Quarto, deploys to `gh-pages`).
There is no PR-level CI: nothing builds until a PR merges.

Voice rule (site-wide, July 2026): plain voice, **no em dashes** (use colons or
commas), no ten-dollar words. Callout titles use colons ("Teaching Prompt:
Construct Validity").

## Hip-Hop Periodic Table (`hiphop/`)

The flagship teaching module. **The Excel workbook is the single source of
truth**; everything else derives from it.

### The pieces

| File | Role |
|---|---|
| `hiphop/data/hiphop_artists.xlsx` | Source of truth. Sheets: **Artist Database** (the data), **Confidence Guide** (H/M/L rubric + method notes), **Data Dictionary** (variable definitions + sampling frame; must stay in sync with the columns) |
| `hiphop/build_table.R` | Quarto pre-render step. Serializes the Artist Database sheet to JSON and injects it at `__RAW_DATA__` in `hiphop/table/_template.html`, producing `hiphop/hiphop_periodic_table.html` (gitignored; built in CI; never edit the output directly) |
| `hiphop/table/_template.html` | The interactive table's look and behavior: filters, legend, tiles, modal. Serializes **all** workbook columns, so new columns flow through automatically |
| `hiphop/hiphop_dashboard.qmd` | 7-page teaching dashboard (Elements only). Pages: 1 measurement, 2 sampling/bias, 3 dimensions vs composite, 4 uncertainty, 5 viz design, 6 careers & longevity, 7 full data table |
| `hiphop/data_dictionary.qmd` | Public codebook; renders the Data Dictionary sheet directly (auto-updates when the sheet changes) |
| `hiphop/_metadata.yml` | `freeze: false` so data-only Excel edits still re-render the dashboard/codebook in CI. Do not remove |
| `hiphop/data/_accuracy_worklist.md` | Internal changelog + counts. Update its header counts, style table, and Done list with every data change |
| `projects/index.qmd` | Project card hardcodes the act counts ("173 hip-hop acts, 129 solo artists and 44 groups"). Update when counts change |

### Artist Database schema (columns A–X, one row per act)

`#` (next integer), `Symbol` (unique, ≤4 chars), `Artist Name` (unique),
`Region`, `Era`, `Style`, `Production Style`, `Label`, `Debut Year`,
`Rhyme Density`, `Vocab Breadth`, `Storytelling`, `Metaphor/Imagery`,
`Conceptual Depth` (1–10 integers), `Composite Score`
(= round(mean(5 dims), 1), stored to 1 dp), `Confidence` (H/M/L),
`Confidence Note` (required for M/L), `Description`, `Type`
(Element = solo, Compound = group; duos/trios are Compounds), `Gender`
(Male/Female/Mixed), `Scene` (NYC/Philly/LA/Bay Area/South/Midwest),
`Signature Work` ("Title (Year)"; blank only if none exists),
`Active Through` (final active year; blank = still active),
`Birth Year` (Elements only; Compounds blank).

Fixed vocabularies: Era = Old School / Golden Age / Late 90s / 2000s / 2010s /
2020s, and it is derived, not judged: Era = the bracket holding the Signature
Work year (Debut Year only when signature is blank, i.e. Kool Herc). Brackets:
Old School through 1985, Golden Age 1986-1994, Late 90s 1995-1999, then
calendar decades. Region = East Coast / West Coast / South / Midwest, and it must equal
the Scene rollup (NYC+Philly → East Coast, LA+Bay Area → West Coast). Style =
Party/Pop, Political, Conscious/Lyrical, Gangsta/Street, Abstract, Jazz-Rap,
Experimental, Trap/Drill. Scores follow the documented critical-consensus
method (no NLP); anchors: Rakim rhyme=10, Aesop Rock vocab=10, Scarface
story=10, Kendrick concept=10. US-scene acts only (sampling frame).

Current state (2026-07): 173 acts = 129 Elements + 44 Compounds; 24 female
Elements (19%); median age at signature work 25.

### Update checklist: what to touch for each kind of change

**Adding or editing acts (rows):**
1. Workbook row with every column filled per the schema above (composite must
   equal the recomputed mean; Era must equal the signature-year bracket;
   sanity: debut ≤ signature year ≤ Active Through; ages 13–45).
2. `_accuracy_worklist.md`: header counts, style-distribution table, Done item.
3. `projects/index.qmd`: the act counts in the project card.
4. Dashboard bias-table gender line (currently "~19% female") if the share moves.
5. Everything else (sidebar counts, charts, table page) recomputes from data.

**Adding a column (schema change):**
1. Append the column and add a matching Data Dictionary sheet row (dictionary
   rows follow column order).
2. `build_table.R` needs nothing (generic). Template modal / dashboard rename
   block only if the new field should be displayed or charted.

**Changing category values (Era/Region/Style):**
Template filter dropdowns + legend + `REGION_SHAPE`/`STYLE_COLORS` maps;
dashboard factor levels + palettes; Data Dictionary allowed-values text;
worklist shapes section.

### Workbook editing and gotchas

- The xlsx has been saved from real Excel: mixed inline strings + a few shared
  strings, no formulas, degenerate `<dimension>` tags. Past sessions edited it
  by scripting the sheet XML directly (no openpyxl/R in the CCR sandbox);
  parse with a sharedStrings-aware reader and append cells as `inlineStr`.
- **Binary merge conflicts:** the xlsx cannot be merged by git. If `main`
  moves while a workbook branch is open (this has happened), rebuild the
  change on top of current main rather than resolving.
- Verification ritual before pushing: (1) parse the workbook and assert
  uniqueness/composites/category validity, (2) rebuild the table by
  replicating `build_table.R`'s injection in Python, (3) drive the page in
  headless Chromium (`/opt/pw-browsers/chromium`, global playwright at
  `/opt/node22/lib/node_modules`) checking tile counts, filters, and modals.
  The dashboard renders only in CI, so read its R chunks carefully.
- Known quirk: `ggplotly()` silently drops ggplot `subtitle`s (titles
  survive). The dashboard's `ggplotly_titled()` helper (setup chunk) works
  around it by folding each subtitle into the plotly title as a `<br><sup>`
  second line. Pipe new ggplot charts through the helper, not bare
  `ggplotly()`, or the subtitle vanishes.

## Other site areas

- `barnum/` mirrors the hiphop pattern (Excel → `build_barnum.R` → HTML).
- `CV/Wylie_Capacity_Dashboard.qmd` is private: gitignored and excluded from
  rendering. Keep it and `_freeze/CV/` out of the public site.
- `_freeze/` is tracked except `_freeze/hiphop/` (ignored; freeze disabled).
