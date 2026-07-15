# Data with a Plot — site guide for coding sessions

Quarto website (datawithaplot.org), published by `.github/workflows/publish.yml`
on every push to `main` (renders with R + Quarto, deploys to `gh-pages`).
There is no PR-level CI: nothing builds until a PR merges.

Voice rule (site-wide, July 2026): plain voice, **no em dashes** (use colons or
commas), no ten-dollar words. Callout titles use colons ("Teaching Prompt:
Construct Validity"). Headings are title case sitewide ("How I Teach", "The
Eight Styles"); statistical n and vs. stay lowercase. Hero and section intros
run short and punchy (the homepage hero is fragments plus two sentences; the
How I Teach section is two sentences). "Clarity is kindness" is the site's
working premise (codebook intro). When drafting copy, offer the maintainer 2-3
options and let her pick and tune: never present drafted copy as her quote,
and never attribute words to a publication without reading it.

Maintainer workflow (learned 2026-07): PRs merge within minutes of opening.
One PR per batch of work. Immediately before every push, check whether the
branch's PR just merged; if it did, restart the branch from origin/main (same
name, force-with-lease) and open a new PR rather than stacking. This also
protects the unmergeable binary xlsx.

The shared build blocks need the same care. Every interactive adds a line to
the same three lists: `pre-render` and `resources` in `_quarto.yml`, and the
generated-page block in `.gitignore`. A branch cut before another interactive
landed conflicts there, and resolving by keeping one side drops the other
without erroring: the page just stops being built and published. #45 did this
to howold and gut, and the #46 fix caught only the `.gitignore` half, so both
pages sat unbuilt until #47. Before pushing, check that all three lists name
every interactive.

The same merge damaged `index.qmd` the opposite way, by keeping **both** sides:
the homepage carried two "Featured Projects" sections, two `id="featured"`
anchors, two `id="divider-line-3"` gradients and the periodic table twice, live
from #45 until 2026-07-15. So the thing to distrust is any wholesale
resolution, either side of it. When a conflict covers something the branch
changed and main also touched, read both parents (`git show <sha>:<file>`) and
rebuild the intended result instead of picking. History is the arbiter and the
obvious guess loses: main had deliberately moved Featured Projects ahead of
"How I Do It" (2722879) while the branch only swapped a card (14e5a48), so the
correct merge was main's position with the branch's cards. Deleting the "extra"
section, the natural fix, would have silently undone main's move.

The third shape is the quietest, because it looks like nobody's fault. The
merge **reverted a fix main had already made**: the hip-hop act counts on the
projects card were corrected to 129/44 in 404d287, the same commit that
reclassified Jedi Mind Tricks, exactly as the checklist below requires. #45 put
the branch's older 130/43 back. That reads exactly like a card someone forgot
to hand-edit, and #47 fixed it as though it were, which was wrong about the
cause: the checklist was followed and the merge ate the result. So when
content looks merely stale, check whether main ever had it right
(`git log -G'<text>' -- <file>`) before calling it neglect: same symptom,
different lesson, and the neglect story hides a merge that is still eating
fixes. Audit method that found all of this, worth repeating after any messy
merge: `git diff <merge>^2 <merge> --name-only`, then for each file count the
dropped main-side lines (`git diff <merge>^2 <merge> -- <file> | grep -c
'^-[^-]'`) and read them. Every file #45 touched has been through this now, and
the casualties were `.gitignore` (#46), `_quarto.yml` (#47), the counts (#47)
and `index.qmd` (#48).

## Hip-Hop Periodic Table (`hiphop/`)

The flagship teaching module. **The Excel workbook is the single source of
truth**; everything else derives from it.

### The pieces

| File | Role |
|---|---|
| `hiphop/data/hiphop_artists.xlsx` | Source of truth. Sheets: **Artist Database** (the data), **Confidence Guide** (H/M/L rubric + method notes), **Data Dictionary** (variable definitions + sampling frame; must stay in sync with the columns) |
| `hiphop/build_table.R` | Quarto pre-render step. Serializes the Artist Database sheet to JSON and injects it at `__RAW_DATA__` in `hiphop/table/_template.html`, producing `hiphop/hiphop_periodic_table.html` (gitignored; built in CI; never edit the output directly) |
| `hiphop/table/_template.html` | The interactive table's look and behavior: filters, legend, tiles, modal. Serializes **all** workbook columns, so new columns flow through automatically |
| `hiphop/hiphop_dashboard.qmd` | 8-page teaching dashboard (Elements only). Pages: 1 measurement, 2 sampling/bias, 3 dimensions vs composite, 4 uncertainty, 5 viz design, 6 one-more-variable (encoding-channel ladder + canon map + style fingerprints), 7 careers & longevity, 8 full data table |
| `hiphop/data_dictionary.qmd` | Public codebook; renders the Data Dictionary sheet directly (auto-updates when the sheet changes) |
| `hiphop/_metadata.yml` | `freeze: false` so data-only Excel edits still re-render the dashboard/codebook in CI. Do not remove |
| `hiphop/data/_accuracy_worklist.md` | Internal changelog + counts. Update its header counts, style table, and Done list with every data change |
| `projects/index.qmd` | Project card hardcodes the act counts ("173 hip-hop acts (129 solo artists and 44 groups)"). Update when counts change: nothing recomputes it. It read 130/43 from #45 to #47, but not from neglect: main had already corrected it and the #45 merge reverted the fix (see the merge hazard above) |

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
story=10, Lil Wayne metaphor=10, Kendrick concept=10. US-scene acts only
(sampling frame).

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

## Evaluation Picker (`evalpicker/`)

Shipped 2026-07-15 (#45). A decision tool: you describe the evaluation you face
on seven axes, and every approach lands in one of three piles (fits, ruled out,
close with the gap named and the work to close it spelled out). Same shape as
barnum, Excel to R to one self-contained HTML page, vanilla JS, no CDN, no
server, no new CI packages (readxl plus base R). Unlike hiphop it has no `.qmd`
and no `_metadata.yml`: nothing renders from it, the page is a listed resource,
so freeze never enters into it.

### The pieces

| File | Role |
|---|---|
| `evalpicker/data/evaluation_approaches.xlsx` | Source of truth. Sheets: **Rules** (one row per rule, 8 rows over 7 axes), **Levels** (allowed values per axis, 35 rows), **Approaches** (7), **TMFs** (2; theories, models and frameworks), **Prerequisites** (what must come first, 5), **Copy** (UI strings + one `reason_*` per rule, 38) |
| `evalpicker/build_eval.R` | Quarto pre-render step. Validates the workbook (see below), then serializes all six sheets to JSON and injects them at `__RULES_DATA__`, `__LEVELS_DATA__`, `__APPROACHES_DATA__`, `__TMFS_DATA__`, `__PREREQS_DATA__` and `__COPY_DATA__` in the template, producing `evalpicker/eval_picker.html` (gitignored; built in CI; never edit the output directly) |
| `evalpicker/app/_template.html` | The picker's look and matching logic |
| `index.qmd`, `projects/index.qmd` | Both link `evalpicker/eval_picker.html`. The homepage card also needs `pics/thumb-evalpicker.jpg` |

### The rules live in the workbook, not the code

Seven axes: `audience`, `purpose`, `question`, `maturity`, `data_capacity`,
`comparison`, `fidelity`. Each Rules row names the `rule_column` it reads on
Approaches and TMFs, a `rule_kind` (`in-list`, `at-least`, `at-most`, `gate`),
and a `fail_class`. A blank rule cell means "this does not constrain me", so
blank always passes.

`fail_class` carries the central idea, so get it right when adding a rule.
**Capacity** means the answer could change if you went and got more (no
comparison group, thin data, a program too new), so failing it makes an
approach unlockable. **Intent** means more resources will not help, because it
is the wrong tool (cost-benefit for the wrong audience), so failing it rules
the approach out. Any Intent failure beats any Capacity failure. `maturity` is
the axis with two rules for this reason: too new is Capacity (wait), too mature
is Intent (wrong tool).

Prerequisites can be Required, Recommended or Conditional. Conditional is what
makes process evaluation required before outcome or impact only when fidelity
is Adapted, Local or Not sure: if you do not know what was delivered, the
numbers are uninterpretable.

### The validator (`build_eval.R`)

Read the header comment before touching this file. The whole design bets on
rules authored in a spreadsheet, so a trailing space or a near-miss value would
otherwise produce a silently wrong verdict, and this tool tells a court which
evaluation to run. Every check `stop()`s the CI render, and the messages point
at the offending row and list the values that would have been valid. The eight:

1. ids unique and non-blank across Approaches + TMFs.
2. Every rule cell resolves to a Levels value for its axis (gates take
   Required / Recommended / Not needed instead).
3. Levels has a numeric `order` on every row (a blank becomes JSON null and the
   ordered comparisons then misbehave silently).
4. `axis_label` agrees across rows sharing an axis (maturity has two).
5. Copy has a `reason_<rule_column>` key for every rule.
6. Prerequisites resolve to real ids, and `strength` is known.
7. Conditional rows carry a real condition and the other strengths carry none
   (a condition on a Required row would silently do nothing).
8. The prerequisite graph is acyclic, counting conditional edges, or the page
   hangs.

A failed render here is the validator working. Fix the spreadsheet, not the
check, and do not downgrade a `stop()` to a warning.

### Update checklist: what to touch for each kind of change

**Adding or editing an approach or framework (rows):**
1. Workbook row in Approaches or TMFs: unique id, and every rule cell either
   blank or a Levels value for that axis.
2. Prerequisites rows if it needs something first (Conditional needs both
   `condition_axis` and `condition_value`; the others need neither).
3. Nothing else. The page rebuilds from the workbook.

**Adding an axis (a new question):**
1. Rules row: `axis`, `axis_label`, `rule_column`, `rule_kind`, `fail_class`.
2. Levels rows for its values, each with an `order`.
3. Copy row keyed `reason_<rule_column>`, or check 5 fails the build.
4. The matching `rule_column` on **both** Approaches and TMFs, or check 2 fails.
5. Template only if the axis needs a control that breaks the existing pattern.

**Changing allowed values:**
Levels rows first, then every Approaches / TMFs cell using the old value, then
any Prerequisites `condition_value`. The validator catches what you miss.

## Other site areas

- `barnum/` mirrors the hiphop pattern (Excel → `build_barnum.R` → HTML) and is
  the template for self-contained interactives: `howold/` ("How Old Is Old?"),
  `gut/` ("Trust Your Gut?") and `evalpicker/` (above) all follow it. Each is a
  `build_*.R` pre-render step plus `app/_template.html` plus `data/*.xlsx`,
  with a gitignored HTML output: edit the xlsx, CI rebuilds. howold and gut
  shipped July 2026 (reveal punch lines maintainer-approved 2026-07), and the
  Teaching page links both under "Two Shorter Exercises" (2026-07-15; they sat
  there unlinked as "in development" until then). The Counted Wrong essay also
  links How Old Is Old?, and howold's template names Counted Wrong in prose
  without linking it: the maintainer deferred that link (2026-07), so only the
  tense was corrected when the essay shipped.
  The only coming-soon project card left: "A Right That Exists on Paper"
  (compassionate release, 50-state review) still needs the maintainer's
  dataset. Re-checked 2026-07-15: `projects/index.qmd` has four cards, with the
  picker, the periodic table and Counted Wrong live and that one still pending.
- Homepage project cards (`index.qmd`) each carry a thumbnail at
  `pics/thumb-<name>.jpg`: 1150x430, a screenshot of that page's own header.
  That size is the aspect `.project-card-thumb img` crops to
  (`site-theme.scss:298`), so the whole shot shows in the card. Nothing checks
  the file exists: #45 added the picker card pointing at `thumb-evalpicker.jpg`
  and never committed one, so the featured card 404ed on the live homepage
  until 2026-07-15. Regenerate with headless Chrome (the browser pane cannot
  load `file://`, so point it at the published page), then convert to JPEG at
  quality 88, which lands in the 42-95 KB band the others sit in:
  `chrome --headless=new --hide-scrollbars --window-size=1150,430 --screenshot=out.png <url>`.
  The homepage features the periodic table and the picker; Barnum belongs to
  Teaching now (14e5a48).
- **Counted Wrong (`countedwrong/`, shipped 2026-07).** The site's first
  long-form analysis essay, on **Pathways to Desistance** (ICPSR 29961:
  1,354 youth, 11 waves over seven years after a serious offense, ages
  14-26 observed, PSMI maturity measures through age 24). Pieces:
  `index.qmd` (format html + toc; its own `ggplotly_titled()` copy;
  `stopifnot` guards in the setup chunk so a bad CSV fails the CI render
  instead of publishing wrong charts), `_metadata.yml` (`freeze: false`;
  `_freeze/countedwrong/` gitignored), and `data/*.csv`: byte-identical
  copies of the seven aggregate tables from the private `lwylie01/EAs`
  repo (written there by `make_aggregates.R`; every cell n ≥ 10, smaller
  cells suppressed at source; EAs has its own CI guard re-validating every
  push). Update flow: regenerate aggregates in EAs, commit there, re-copy
  here, verify byte-identity, push; freeze is off so CI re-renders. The
  projects card ("Counted Wrong: The Line at 18") and the Writing page
  essay card link to the page; howold's template still says "coming to
  this site" (maintainer deferred that link, 2026-07). Hard rules
  unchanged: person-level Pathways data is NEVER committed to any GitHub
  repo, public or private, and Git LFS is never the answer; the public
  site gets aggregates only. EAs remote verified clean 2026-07-14 (API
  tree walk + full-history blob scan; the two 312 MB CSVs never landed).
  One essay detail is from general study knowledge, not repo docs, and is
  flagged for the maintainer: the "Philadelphia and Phoenix, early 2000s"
  enrollment sentence.
- `CV/Wylie_Capacity_Dashboard.qmd` is private: gitignored and excluded from
  rendering. Keep it and `_freeze/CV/` out of the public site.
- `_freeze/` is tracked except `_freeze/hiphop/` and `_freeze/countedwrong/`
  (both ignored; freeze disabled for both).
