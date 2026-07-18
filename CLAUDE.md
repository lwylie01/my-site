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

Content/style pass July 2026. It shipped as a filter dashboard (seven dropdowns
defaulted to "Any", results pre-sorted before you said anything) while both site
cards promised an interview, and its palette was copied from the periodic table
rather than from its actual siblings. It is now **two screens**: an `#intro`
on-ramp (howold's `.screen`/`@keyframes fade` pattern) then `#screen-tool`.
Results stay hidden until at least one of the seven is answered: `render()`
returns early and shows `#zero`, because sorting nine cards into "these fit what
you have" before you have said what you have is a claim the page cannot make.
This does not cost the footer's credited premise: the tool never *removes* an
approach, it sorts them, so the whole field still appears at once. The seven
axis labels are the questions and are set as questions, with `help_text` visible
under each rather than in a `title=` tooltip that touch and keyboard users never
saw. One verb sitewide for the act of answering: **"said"** (it was three, "set"
/ "said" / "picked", across eleven strings).

Two things not to re-break. **Chips carry no text on a coloured fill**: six of
the nine old chip colours failed AA with white text, worst the `Economic` family
chip at 1.99:1 on three of seven cards, so family identity moved to a dot (the
`.project-card-accent` device from `index.qmd`) and data burden to a filled-dot
meter. Colour is never the only channel, and the burden ramp is not a traffic
light. **Cards are opened by a real `<button>` inside the `<h3>`**, not by
`role="button"` on the `<article>`: the article's reasons are the product, and
`role="button"` would hide them from a screen reader. The article keeps its
click handler for mice and the button's click bubbles up to it. `.chip` must not
use `white-space: nowrap` (some `typical_timeline` values are sentences and a
nowrap pill punches out of a narrow viewport), and both grids use
`minmax(min(Npx, 100%), 1fr)` because an auto-fit track cannot shrink below a
bare floor.

### The pieces

| File | Role |
|---|---|
| `evalpicker/data/evaluation_approaches.xlsx` | Source of truth. Sheets: **Rules** (one row per rule, 8 rows over 7 axes), **Levels** (allowed values per axis, 35 rows), **Approaches** (7), **TMFs** (2; theories, models and frameworks), **Prerequisites** (what must come first, 5), **Copy** (UI strings + one `reason_*` per rule, 62). Copy went 38 to 62 in the July 2026 pass: ~15 strings were welded into the template (both empty states, the tab labels, `Any` / `Clear` / `Already done`, the stats words, the gap leads, the chain annotations) so the "words live in Excel" premise was only half true. Check 5b now enforces it. Text is HTML-escaped on every path, so no markup or links can live in a Copy string. The `<h1>` stays hardcoded like barnum's and howold's: its `<span>` cannot survive escaping, which is why `page_title` was deleted rather than wired |
| `evalpicker/build_eval.R` | Quarto pre-render step. Validates the workbook (see below), then serializes all six sheets to JSON and injects them at `__RULES_DATA__`, `__LEVELS_DATA__`, `__APPROACHES_DATA__`, `__TMFS_DATA__`, `__PREREQS_DATA__` and `__COPY_DATA__` in the template, producing `evalpicker/eval_picker.html` (gitignored; built in CI; never edit the output directly) |
| `evalpicker/app/_template.html` | The picker's look and matching logic |
| `index.qmd`, `teaching/index.qmd` | Both link `evalpicker/eval_picker.html` (the homepage as a featured card with `pics/thumb-evalpicker.jpg`, Teaching as a tool card). Moved off `projects/index.qmd` in the July 2026 section reshuffle: the pickers are teaching tools, so Projects now holds only the research work |

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

**Known gap, live on the site (as of July 2026): two dead options.**
`Participants` (audience) and `For whom` (question) appear in no `audience_ok`
or `question_ok` cell on any of the nine items, so picking either fails all nine
on an Intent rule: 0 fit, 0 close, 9 ruled out. Verified on the built page, not
inferred. The tool offers a choice and answers it with a wall of refusals. This
is a content gap, not a rules bug: there is no realist evaluation row (Pawson &
Tilley own "what works, for whom, in what circumstances") and nothing is written
for a participant audience. The fix is agreed and is the next PR: add `REALIST`
and `EMPOWER` (empowerment evaluation, Fetterman) plus widen `audience_ok` on
the existing rows that genuinely serve that audience (`PROCESS` and `REAIM` are
the candidates; maintainer decides). It is held, not abandoned, because no
validator check touches a prose cell: a row with blank prose renders as a thin
card rather than failing, and TODO placeholder text would publish on push. So
the rows land only when the prose and sources exist. A worthwhile assertion for
any future audit: **every Levels value should appear in at least one item's rule
cell.** Nothing checks that today.

The `note_*` overrides look neglected and are not. 42 failure cells can actually
fire; 5 are bespoke and 37 use the generic `reason_*` template. But every rule
that fires rarely is 100% bespoke (maturity_max 1/1, comparison_required 2/2,
fidelity_ok 2/2) and every rule that fires constantly is generic (audience,
purpose, question: 9 items each). The overrides were written exactly where the
generic was weak ("does not suit this program" says nothing, so both its users
override it) and skipped where it interpolates well. Do not "fix" this with a
bulk pass: the generic carries `{have}` and `{needed}`, so it is specific in
content though templated in form. Note `reason_fidelity_ok` and
`reason_comparison_required` can never render today (every row that constrains
on them has an override); they stay as the fallback for the next row that does
not, and check 5 requires them anyway.

### The validator (`build_eval.R`)

Read the header comment before touching this file. The whole design bets on
rules authored in a spreadsheet, so a trailing space or a near-miss value would
otherwise produce a silently wrong verdict, and this tool tells a court which
evaluation to run. Every check `stop()`s the CI render, and the messages point
at the offending row and list the values that would have been valid. The nine:

1. ids unique and non-blank across Approaches + TMFs.
2. Every rule cell resolves to a Levels value for its axis (gates take
   Required / Recommended / Not needed instead).
3. Levels has a numeric `order` on every row (a blank becomes JSON null and the
   ordered comparisons then misbehave silently).
4. `axis_label` agrees across rows sharing an axis (maturity has two).
5. Copy has a `reason_<rule_column>` key for every rule.
5b. Every *other* Copy key the template names resolves too. `t()` falls back to a
   literal `[key_name]` instead of throwing, so before this only `reason_*` was
   protected and any other typo shipped `[heading_fits]` to the page silently.
   The check scans the template for the three shapes that reach `t()`:
   `t('key')`, the `setText('id', 'key')` init pairs, and the `say('Soft', 'key')`
   caveats that pass a key through indirectly. A new way of naming a key needs a
   new pattern there. Whole-line `//` comments are stripped first, so comments
   can quote the shapes without inventing a key. Unused keys only `message()`:
   a stray row is clutter, a missing one is a broken page.
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

## Format Picker (`formatpicker/`)

Shipped 2026-07. A sibling of the evaluation picker for a different question:
you say who you are trying to reach, how far the work must travel, and what you
want it to do, and every delivery format sorts into three piles (fits / could
work with a tweak / not the tool here). Same Excel-to-R-to-one-HTML shape, no
prerequisite or TMF machinery. It wears the **orchard palette** from the source
graphic (sage green, gold, slate blue, warm brown, apple red) so it reads as a
distinct page, not a recolour of the plum/coral picker. Every text/border pair
was checked against AA on `--light-bg` (#F7F5EF); the apple red `--secondary`
(#BC4634) was tuned to clear 4.5:1 as the eyebrow on light **and** 3.0:1 as the
`<h1>` span on the dark header at once.

Built from **Figure 2** (the delivery-formats tree: circle size = length, colour
= illustration-to-text ratio, branch position = external reach) and **Figure 3**
(audience subgroups, novice through funder) of Lindsey Wylie's "Cultivating a
Court's Data STORY," NCSC Trends in State Courts (2025). The source figures live
under the private working folder, not in this repo.

### The pieces

| File | Role |
|---|---|
| `formatpicker/data/delivery_formats.xlsx` | Source of truth. Sheets: **Rules** (3, one per question), **Levels** (13), **Formats** (14), **Copy** (41: UI strings plus one `reason_`/`short_` per rule). Editable in Excel |
| `formatpicker/build_format.R` | Pre-render step. Validates the workbook (checks 1-5b from `build_eval.R`, minus the prerequisite checks 6-8), serializes the four sheets to JSON and injects them at `__RULES_DATA__`, `__LEVELS_DATA__`, `__FORMATS_DATA__`, `__COPY_DATA__`, producing `formatpicker/format_picker.html` (gitignored; built in CI; never edit the output) |
| `formatpicker/app/_template.html` | The picker's look + matching logic |
| `index.qmd`, `teaching/index.qmd` | Both link `formatpicker/format_picker.html` (homepage featured card with `pics/thumb-formatpicker.jpg` at 1150x430; Teaching as a tool card). Like the evaluation picker, it moved off `projects/index.qmd` in the July 2026 reshuffle |

### The model

Three axes, all `in-list`: `audience` and `objective` fail as **Intent** (wrong
tool, ruled out); `reach` fails as **Capacity** (pitched for a different reach,
so it lands in the middle pile with an "Adapt for reach" tag). Any Intent
failure beats a Capacity one. Length and illustration-to-text are **not**
questions: they ride along as card chips (a filled-dot length meter and a
labelled illustration dot, colour never the only channel). Reason sentences use
`plabel()`, the dropdown label with its "(general public)" gloss stripped, so
they read as prose.

**The mapping is the maintainer's to argue with.** Which format serves which
audience, reach, and objective (the `*_ok` cells) is a drafted starting point,
not settled fact. No validator check touches that judgment: a wrong `audience_ok`
value still passes every check, it just sorts a format into the wrong pile. So
review the `Formats` sheet as content, not code. The reach-as-soft choice is
also a call, not a law: if a format that only reaches one way should be ruled
out rather than softened, move its rule's `fail_class` to `Intent`.

## Selected Work (`selected-work/`)

Rebuilt July 2026 from hand-coded JS arrays to a single data source. Before the
rebuild, the timeline (`PUBS`), the citations chart (`CITES`), and the curated
lists were three separately hand-written copies, and nine publications had
drifted to contradictory titles, years, or venues between them.

### The pieces

| File | Role |
|---|---|
| `selected-work/data/publications.xlsx` | Source of truth for publication metadata. Sheets: **Publications** (36 rows: id, year, area, type, title, venue, authors, url, short_label, featured, featured_order), **Areas** (4: key, label, legend_key, color, description, order), **Reports** (21 project reports for the Program Evaluations section), **Meta** (citations_source, citations_asof, scholar_url, tail_count, tail_total, ncsc_url, jji_url) |
| `selected-work/data/citations.csv` | Citation counts, text format on purpose (a bot edits it; a binary xlsx cannot merge). `citations` is the DISPLAYED count (Google Scholar, maintainer-curated); `openalex_id` / `openalex_cited` / `openalex_fetched` are reference columns the monthly workflow refreshes and the page never shows |
| `selected-work/index.qmd` | One validating R chunk (stopifnot, fail-loud like countedwrong) reads both files and emits `window.SW` JSON for the two chart IIFEs, the research-area sections (curated list + collapsible "All N publications"), the reports section, and the computed citation figure title and footnote. Both figures and every list render from one dataset, so they cannot contradict each other |
| `selected-work/_metadata.yml` | `freeze: false`; `_freeze/selected-work/` is gitignored |
| `selected-work/refresh_citations.R` | Updates the OpenAlex reference columns from the API. Never touches `citations` |
| `.github/workflows/refresh-citations.yml` | Cron, 06:00 UTC on the 1st monthly, plus `workflow_dispatch`. Runs the refresh script and opens a PR (`bot/citation-refresh`) when counts moved; never pushes to main. The PR body lists movers as a prompt to hand-refresh the Scholar numbers and `citations_asof` |

### Two authority rules learned the hard way

**Titles follow the publisher-registered record (Crossref/OpenAlex), not the
CV.** The July 2026 audit found the CV carries informal or pre-publication
titles for at least seven works. Verified examples where the published title
differs from the CV: "Extraordinary and Compelling: The Use of Compassionate
Release Laws in the United States" (CV says "A review of federal and state
compassionate release laws"), "Assessing School and Student Predictors of
Weapons Reporting" (CV: "Individual-Level Predictors"), "Four Decades of the
Journal Law and Human Behavior" (CV: "Forty years"), "Assuming Elder Care
Responsibility: Am I a Caregiver?" (CV: "Assuming responsibility"), "End-of-Life
Planning: Normalizing the Process" (CV carries a completely different working
title; author list confirms it is the same article), "The Application of
Risk–Needs Programming in a Juvenile Diversion Program", and "Absenteeism
Interventions: An Approach for Common Definitions" (CV: "Common Measurement").
Also the voice-identification law review is 2013, *Law & Psychology Review*
vol. 37 (CV says 2012, "Psychology and Law Review"). When adding a publication,
check Crossref (`api.crossref.org/works/DOI`) before trusting any list,
including the CV.

Resolved 2026-07-17: the CV itself was corrected to the published titles (16
edits, including the #Deadly title and its venue's official name, *Journal of
Qualitative Criminal Justice & Criminology*). The corrected source is
`Wylie CV 7.2026.docx` in the maintainer's Professional Devel folder
(5.2026 kept untouched as history), and the site serves the matching
`CV/Wylie CV 7.2026.pdf` (Word-exported). The paragraph above stays as the
method note: publisher record first, every list second.

**Displayed citation counts are Google Scholar's and only Google Scholar's.**
Scholar blocks automated fetching, and OpenAlex undercounts law-heavy work
badly (Duke arbitration July 2026: OpenAlex 56 vs Scholar 159; the
misinformation chapter, Scholar 100, is not indexed at all). Mixing sources in
one ranked chart would be incoherent, so OpenAlex is reference-only, in the
CSV, feeding the monthly PR. Do not "simplify" by switching the displayed
numbers to OpenAlex.

### Update checklist

**Citation refresh (monthly PR or by hand):** edit the `citations` column in
`citations.csv` from the Scholar profile, update `citations_asof` (Meta sheet),
merge. The chart order, title, and totals recompute.

**New publication:** row in Publications (id, year, area, type, publisher-record
title, venue, CV-style authors, url, short_label) + a row in `citations.csv`
(blank citations until it is cited; openalex_id if OpenAlex has it). Set
`featured` + `featured_order` if it belongs in the curated list. Nothing else:
the timeline, lists, and counts recompute.

**New report:** row in the Reports sheet. Link only URLs verified live; every
report link in the Aug 2025 CV was already dead (NCSC `__data` paths and the
whole JJI squarespace host 404), which is why rows ship unlinked with the org
links (Meta) carrying the section's only hyperlinks.

**Area labels use "and", never "&"** (sitewide decision, July 2026); official
journal names keep their own styling (*Crime & Delinquency* stays).

## Other site areas

- `barnum/` mirrors the hiphop pattern (Excel → `build_barnum.R` → HTML) and is
  the template for self-contained interactives: `howold/` ("How Old Is Old?"),
  `gut/` ("Trust Your Gut?"), `evalpicker/` and `formatpicker/` (both above) all
  follow it. Each is a
  `build_*.R` pre-render step plus `app/_template.html` plus `data/*.xlsx`,
  with a gitignored HTML output: edit the xlsx, CI rebuilds. howold and gut
  shipped July 2026 (reveal punch lines maintainer-approved 2026-07). The July
  2026 reshuffle turned the Teaching page from prose into a card grid (matching
  Projects/Writing): it keeps the "How I Teach" intro and concept pills, then a
  `.project-grid` of six tool cards (the Hip-Hop module cross-listed from
  Projects, Barnum, howold, gut, and both pickers), then "Topics I Teach". The
  per-tool session-design callouts were condensed into one after the grid.
  Before that, howold and gut sat under a prose "Two Shorter Exercises" heading.
  How Old Is Old? and Counted
  Wrong now link to each other: the howold link was deferred while the essay
  was still coming, so #48 corrected only its tense and #51 added the link once
  the essay was live. The link sits in howold's reveal (`#screen-2`), which is
  `display:none` until the exercise is done, so drive the sliders and both
  buttons to see it.
  The only coming-soon project card left: "A Right That Exists on Paper"
  (compassionate release, 50-state review) still needs the maintainer's
  dataset. Re-checked 2026-07-15: `projects/index.qmd` has four cards, with the
  picker, the periodic table and Counted Wrong live and that one still pending.
- The standalone templates carry their own CSS and had no inline prose link
  until #51, so there is no generic `a` rule to inherit and a bare `<a>` in body
  copy renders browser-default blue. Style it, and measure against the rendered
  page rather than against white: the background is `--light-bg` (#F8F7F4),
  which is exactly what sinks the obvious choice. `--primary` reaches only
  4.3:1 there and misses AA at body size, so links take `--link` (#6b4f6c, the
  site's deeper plum, `plum_dark` in the Counted Wrong palette) at 6.6:1.
  Underline them: `--link` and `--muted` differ by 1.4:1, so color alone does
  not mark a link. Hover darkens to `--dark` (14.8:1); brightening to
  `--secondary` would fail at 2.4:1, and a hover state has to clear AA too.
  Known and unfixed, flagged 2026-07-16: the project card links on `index.qmd`
  and `projects/index.qmd` use #E98973 on white at about 2.4:1, under AA for
  their size. That is a design call, not a bug fix.
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
  The homepage "Featured Projects" grid features the periodic table and both
  pickers (evaluation and format); it is a curated highlight, so it keeps the
  pickers even though they now live on Teaching. Barnum belongs to Teaching too
  (14e5a48).
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
  essay card link to the page, and howold's reveal links it too (#51); the
  essay links back, so that pair closes both ways. The Writing card keeps
  the essay's own title and subtitle rather than the projects card's "The
  Line at 18", which is deliberate: fcacd43 edited that card and left the
  title. Hard rules
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
