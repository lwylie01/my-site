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

Brand kit (adopted 2026-07-19): the site runs the "Data with a Plot" brand.
The sheet is `pics/brand/BRAND.md`; the assets (logo/mark SVGs, favicon,
og-image, and its regeneration source) live in `pics/brand/`. Six palette
tokens: **Ink Plum #2E1A47** (primary dark: headings, body on light), **Cream
#F7F2EC** (page background), **Paper #FDFBF7** (cards, navbar, panels), **Coral
#F4715C** (accent ON DARK only, 5.1:1 on ink; decorative anywhere), **Deep Coral
#B23A28** (text/links ON LIGHT, 5.4:1 on cream), **Mauve #A98BB8** (decorative
only, never body text). One derived neutral, **muted-ink #6A5F72** (~5.3:1 on
cream), carries muted text. The operating rule for every new colour choice: coral
is Coral on dark and Deep Coral on light (coral-on-cream is 2.7:1 and fails);
mauve never carries text. Fonts: **Spectral** (headings 600, body 400, italic for
emphasis and the wordmark's "with a"; fallback Georgia, serif) and **JetBrains
Mono** for eyebrows/labels/captions/data labels (11-13px, letter-spacing
0.08-0.12em; fallback monospace), both from Google Fonts, imported in
`site-theme.scss` + `custom.scss` and linked in the standalone templates.
Motif: one rise-and-fall **arc** (stroke 3-5px, round caps, no axes) through a
**scatter** of 4-7 mauve dots plus **exactly one coral dot** (the outlier the
line misses); a line-art pen at 45deg touches the arc end (omit below ~40px).
The section dividers (`index.qmd`, `selected-work/index.qmd`) are one canonical
block carrying **no `<defs>` and no ids** (arc + inline-fill scatter): keep it
id-free, because the old gradient dividers were the source of the
`divider-line-3` duplicate-id merge bug. The hero wordmark is inlined as SVG (an
`<img>`-referenced SVG can't load Spectral and falls back to Georgia); the navbar
uses the text-free `mark-on-light.svg`. Section headings carry a numbered
mono-caps eyebrow via a `data-eyebrow` attribute rendered by a CSS `::before`
(source strings stay sentence case, CSS uppercases them), so title-case headings
and mono-caps eyebrows coexist. og-image is regenerated from
`pics/brand/og-image-source.html` (headless Chrome, 1200x630) so its tagline
obeys the no-em-dash rule; `_quarto.yml` wires it via `website: image`.
Deliberately NOT brand chrome (these are data, keep their own colours): the
hip-hop `STYLE_COLORS`/`SCORE_HUES`/`CONF_COLOR` and every dashboard `*_pal`
(CVD-validated encodings), the Counted Wrong chart constants
(plum_dark/plum/plum_series/coral_dark/gray_ctx), and the `publications.xlsx`
Areas colours.

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
| `hiphop/data/hiphop_artists.xlsx` | Source of truth. Sheets: **Artist Database** (the data), **Confidence Guide** (H/M/L rubric + method notes), **Data Dictionary** (four blocks: variable definitions, SAMPLING FRAME & SCOPE RULES, STYLE TAXONOMY with an anchor act per style, SCORING LADDERS with per-dimension rungs at 8/6/4 naming in-table acts whose stored score equals the rung, so rescoring a rung act means re-picking that rung; must stay in sync with the columns) |
| `hiphop/build_table.R` | Quarto pre-render step. Serializes the Artist Database sheet to JSON and injects it at `__RAW_DATA__` in `hiphop/table/_template.html`, producing `hiphop/hiphop_periodic_table.html` (gitignored; built in CI; never edit the output directly) |
| `hiphop/table/_template.html` | The interactive table's look and behavior: filters, legend, tiles, modal, plus the header nav linking Home / Teaching / Dashboard / Codebook. Serializes **all** workbook columns, so new columns flow through automatically. `STYLE_COLORS` is a four-family palette (hue = lane, shade = style within it: corals = street, jades = message, purples = left field, golds = crowd; CVD-validated) shared with the dashboard's style palette |
| `hiphop/hiphop_dashboard.qmd` | 8-page teaching dashboard (Elements only). Pages: 1 measurement, 2 sampling/bias, 3 dimensions vs composite, 4 uncertainty, 5 viz design, 6 one-more-variable (encoding-channel ladder + canon map + style fingerprints), 7 careers & longevity, 8 full data table |
| `hiphop/data_dictionary.qmd` | Public codebook; renders the Data Dictionary sheet directly (auto-updates when the sheet changes). Also carries the how-anchors-create-scores method prose and the **Contested Calls** log (12 split rulings as of 2026-07); add to that log when a coding call is genuinely arguable |
| `hiphop/_metadata.yml` | `freeze: false` so data-only Excel edits still re-render the dashboard/codebook in CI. Do not remove |
| `hiphop/data/_accuracy_worklist.md` | Internal changelog + counts. Update its header counts, style table, and Done list with every data change |
| `projects/index.qmd` | Project card hardcodes the act counts ("187 hip-hop acts (143 solo artists and 44 groups)"). Update when counts change: nothing recomputes it. It read 130/43 from #45 to #47, but not from neglect: main had already corrected it and the #45 merge reverted the fix (see the merge hazard above). `teaching/index.qmd`'s session card hardcodes the total too ("a dataset of 187 hip-hop acts") |

### Artist Database schema (columns A–Y, one row per act)

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
`Birth Year` (Elements only; Compounds blank),
`Member Of` (Elements only: the Compound(s) the act belongs to when the group
also has a row, semicolon-separated exact Compound names; in-table pairs only,
so blank = no bond, not no group history. Stored once, on the Element side;
the table modal derives each Compound's member list and cross-links both
directions).

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

Current state (2026-07): 187 acts = 143 Elements + 44 Compounds; 32 female
Elements (22%); median age at signature work 25; 15 bonds. (Every figure in
this section re-verified against the workbook and rendered pages 2026-07-19.)

### Update checklist: what to touch for each kind of change

**Adding or editing acts (rows):**
1. Workbook row with every column filled per the schema above (composite must
   equal the recomputed mean; Era must equal the signature-year bracket;
   sanity: debut ≤ signature year ≤ Active Through; ages 13–45).
2. `_accuracy_worklist.md`: header counts, style-distribution table, Done item.
3. `projects/index.qmd`: the act counts in the project card; the total is also
   hardcoded on the `teaching/index.qmd` session card.
4. Dashboard bias-table gender line (currently "~22% female") if the share moves.
5. Everything else (sidebar counts, charts, table page) recomputes from data.

**Adding a column (schema change):**
1. Append the column and add a matching Data Dictionary sheet row (dictionary
   rows follow column order).
2. `build_table.R` needs nothing (generic). Template modal / dashboard rename
   block only if the new field should be displayed or charted.

**Changing category values (Era/Region/Style):**
Template filter dropdowns + legend + `REGION_SHAPE`/`STYLE_COLORS` maps;
dashboard factor levels + palettes; Data Dictionary allowed-values text;
worklist shapes section. A new Style also needs a STYLE TAXONOMY row in the
dictionary sheet (definition + anchor act) and a shade inside one of the four
palette lanes, not a new hue. Era is not edited directly: it follows the
Signature Work year's bracket, so era "changes" happen by re-picking the
signature work.

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
prerequisite or TMF machinery. It shipped in a distinct **orchard palette**
(sage green, gold, apple red) drawn from the source graphic, but the 2026-07-19
rebrand pulled it into the shared brand family with its siblings (maintainer's
call): `--primary` Ink Plum, `--secondary` Coral on dark / Deep Coral on light,
`--accent` Mauve, on Cream/Paper. The reason-sentence `plabel()` machinery and
the length / illustration-to-text card chips are unchanged; only the chrome
palette and fonts moved. History: the old apple-red `--secondary` (#BC4634) had
been AA-tuned on the orchard `--light-bg` (#F7F5EF) as both a light eyebrow and a
dark-header `<h1>` span; Deep Coral now serves the on-light role and Coral the
on-dark one, the same split as every other page.

Built from **Figure 2** (the delivery-formats tree: circle size = length, colour
= illustration-to-text ratio, branch position = external reach) and **Figure 3**
(audience subgroups, novice through funder) of Lindsey Wylie's "Cultivating a
Court's Data STORY," NCSC Trends in State Courts (2025). The source figures live
under the private working folder, not in this repo.

### The pieces

| File | Role |
|---|---|
| `formatpicker/data/delivery_formats.xlsx` | Source of truth. Sheets: **Rules** (3, one per question), **Levels** (13), **Formats** (17), **Copy** (41: UI strings plus one `reason_`/`short_` per rule). Editable in Excel |
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

Three formats were added from practice 2026-07-20 (maintainer's call, from a
crosswalk against her real deliverables): `INTERACT` Interactive Report
(Digital & interactive), `VIDEO` Video or Documentary (Outreach & media),
`GUIDE` How-To Guide (Written report). They are not in the Trends Fig. 2 tree
and never claim to be: their `source` cells read "Added from practice (2026)",
and both places that promised tree-only were reworded the same day (the
`intro_note` Copy string now says "plus three from practice"; the template
footer says "plus three added from practice"). All three use existing families,
so `GROUP_COLORS` needed nothing. Open content call, offered and not yet
decided: `BRIEF` lacks Expert in `audience_ok`, though a technical brief for
an expert reader is a real thing the practice ships.

## The Plot So Far (`selected-work/`)

The publications page. Renamed from "Selected Work" July 2026 once it showed
the complete record (title plays on the site name; the navbar entry and the
homepage link say "The Plot So Far" too). **The folder and URL stay
`selected-work/`** so nothing external breaks; only displayed names changed.

Section names follow the same register as the Counted Wrong headings (short,
concrete, a little literary): **The Four Threads** (was "Research Areas"; the
figures say "by thread" to match), **The Applied Side** (was "Program
Evaluations and Applied Research"), **The Paper Trail** (was "Citation
Impact"). **Curriculum Vitae keeps its proper name**, maintainer's choice, as
did "Writing" and "Projects": a second plot pun in the nav ("Plot Points") or
renaming Projects to "Exhibits" was judged one step too cute. Keep new names
in this register and stop before kitsch.

The same naming pass reached the other pages (all July 2026, maintainer-picked
from offered options): homepage sections are **The Premise** (was "What I Do",
over the bio), **Start Here** (was "Featured Projects"), and **The Method**
(was "How I Do It"); the html anchor ids (#about, #featured, #whatIdo) kept
their old names on purpose, so links do not break. Teaching's topics section
is **The Usual Subjects** (was "Topics I Teach and Write About"; a rejected
candidate was "On the Syllabus"). "How I Teach" and "Teaching Materials" stay:
already in voice.

Rebuilt July 2026 from hand-coded JS arrays to a single data source. Before the
rebuild, the timeline (`PUBS`), the citations chart (`CITES`), and the curated
lists were three separately hand-written copies, and nine publications had
drifted to contradictory titles, years, or venues between them.

Layout notes from the same pass: the timeline keeps its **area labels in a
left gutter** (wrapped, vertically centered per lane) with the years axis
starting after it, because drawing labels inside the plot let dots collide
with text. Dot stacks grow upward from a baseline that centers the deepest
stack, so single dots sit level with their label. Each research area shows a
curated list plus a **"N more publications in this area" expander that holds
only what the curated list does not already show**; do not change it back to
an all-inclusive list, repeats were the complaint that prompted it. The
Writing page's coming-soon essay cards carry **no `href`** (they were
`href="#"` dead links); give a card its real link when the essay ships.

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
  No coming-soon project card remains: "A Right That Exists on Paper"
  (`compassionaterelease/`, bullet below) shipped 2026-07-19 (#74) and retired
  the last one, so `projects/index.qmd` has four live cards.
- **A Right That Exists on Paper (`compassionaterelease/`; shipped 2026-07-19
  in #74, review pass 2026-07-19).** Chart-forward data story on compassionate
  release, the qualitative-data sibling of Maturity Gap on the same machinery:
  `index.qmd` with `ggplotly_titled()`, `legend_below()`, `stopifnot` guards
  over every CSV, `_metadata.yml` freeze: false, `_freeze/compassionaterelease/`
  gitignored. Public documents only (USSC Compassionate Release Data Report
  FY2025 Q3 tables 1/10/11; Holland et al. 2020 *OMEGA* and 2021 *Mortality*;
  Wisconsin's own statutes, rule, forms, and policy); every CSV row carries
  `source` + `source_detail` and the guard refuses to render without them.
  Nine exhibits, one form each: lollipop, icon array, span, nested-bar funnel,
  stat tiles, part-in-whole monthly bars, faceted bars, codebook table,
  vertical timeline. The review pass (maintainer: "too many dumb bells") cut
  the dot-on-a-stick forms from three to two, requirements became the icon
  array, and the Wisconsin timeline went vertical because its labels are
  phrases and phrases need horizontal room; keep one lollipop and one span,
  no more. **`anchor_text()` exists because ggplotly drops a constant `hjust`
  on `geom_text`** (textposition comes back null, so plotly centers every
  label on its anchor; that was the timeline's label collision and it also
  put the funnel's dark-bar label on the bar). Pipe any chart whose geom_text
  sets hjust through it; the same drop hits `annotate("text", hjust = ...)`.
  Facet tick labels that must survive 280px phone panels are bare numbers
  with the unit in the axis title (the reasons chart). The reason themes are
  the maintainer's own coding over the Commission's codes and the codebook
  table is the contract: change one, change both. Quarterly USSC update =
  extend `federal_motions_monthly.csv` and `federal_reasons.csv`, then the
  stopifnot sums and the totals in the notes prose. The state layer is
  Holland's 2016 coding, a decade old, and the page says so; re-coding from
  current statutes is the named next piece of work.
- The standalone templates carry their own CSS and had no inline prose link
  until #51, so there is no generic `a` rule to inherit and a bare `<a>` in body
  copy renders browser-default blue. Style it, and measure against the rendered
  page rather than against white: the background is `--light-bg` (#F7F2EC after
  the 2026-07-19 rebrand, #F8F7F4 before), which is exactly what sinks the
  obvious choice. Links take `--link` (**Deep Coral #B23A28**) at 5.4:1;
  underline them, because `--link` and `--muted` alone do not differ enough to
  mark a link by colour. Hover darkens to `--dark` (Ink Plum #2E1A47); the
  on-dark Coral #F4715C must never be the on-light link, because coral on cream
  is 2.7:1, which is the whole reason on-light text is Deep Coral, not Coral.
  (Before the rebrand the link was the old deeper plum #6b4f6c at 6.6:1; the
  lesson carries, not the hex.)
  Resolved 2026-07-19: the project card links on `index.qmd` and
  `projects/index.qmd` that used #E98973 on white at about 2.4:1 are now Deep
  Coral #B23A28, clearing AA. The rebrand closed that gap.
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
  A theme rebrand goes stale here: every `thumb-*.jpg` is a screenshot of a
  page's own header, so after any chrome change regenerate all four from the
  published pages (a follow-up PR, because the new header must deploy first).
  The homepage "Start Here" grid (headed "Featured Projects" until the July
  2026 naming pass) features the periodic table, both pickers (evaluation
  and format), and Maturity Gap (card added 2026-07-18); it is a curated
  highlight, so it keeps the pickers even though they now live on Teaching. Barnum belongs to Teaching too (14e5a48).
- **Maturity Gap (`countedwrong/`; shipped 2026-07 as the essay
  "Counted Wrong", rebuilt 2026-07-18 as a chart-forward data story).** The
  folder and URL stay `countedwrong/` so nothing external breaks; only
  displayed names changed (same rule as selected-work). The title carries
  **no "The"** anywhere on the site (maintainer, 2026-07-18): "The Maturity
  Gap: The Line at 18" doubled the article and wrapped the projects card to
  two lines on her laptop, so the page is "Maturity Gap" and the card is
  "Maturity Gap: A Line at 18" ("A", not "The", in the subtitle too). The
  page subtitle is "Young adults, the legal system, and the data between
  them" (maintainer-picked 2026-07-18; "one chart at a time" was judged to
  verge on snarky and the Writing card changed with it). Each chart
  section's setup prose lives INSIDE its chart card as a
  `chart-card-lede` (styled in `site-theme.scss` next to the other
  chart-card classes), and a page-scoped style block steps
  `section.level2 > p` down to 0.95rem: the maintainer found the page
  text-heavy, so sections read as self-contained exhibits. New chart
  sections should follow the lede-in-card pattern, not a paragraph above
  the card. The page's two
  objectives, maintainer-stated: teach about young adults and the
  developmental framework in the criminal legal system implicitly through
  the figures, and demonstrate chart diversity, viz best practices, and
  chart selection in data storytelling. So each section is one question,
  one chart form, and a `chart-card-note` beginning "**Why this chart:**"
  (two sentences: why this form, one best-practice point). Twelve forms:
  the maintainer's diagram, emphasized-line-with-gray-context, dot plot,
  dumbbell, stat tiles, line+band, small multiples, free-scale slope
  multiples, sequential heatmap, two-line sex comparison (Same Climb,
  Both Sexes; from `psmi_by_age_sex`, added 2026-07-18; its 18-line is
  dotted gray, not coral, because coral is the Female series there, the
  same precedent the stacked area set), stacked area, and a two-panel
  shared-x centerpiece (the dual-axis refusal). Teaching Prompt callouts, the
  reactable table, and the CSV download links were removed deliberately
  (maintainer: no teaching-activity framing, no public table links); do
  not reintroduce them. Multi-series colors are the validated pair
  `#774379`/`#c96b52` (CVD dE 52.6 on white); context lines are `#8a8a8a`
  and always direct-labeled; plum_dark stays for single series. Machinery
  unchanged: `index.qmd` format html + toc, its own `ggplotly_titled()`
  copy, `stopifnot` guards extended to every CSV, `_metadata.yml`
  (`freeze: false`; `_freeze/countedwrong/` gitignored). Any chart with a
  legend must also pipe through `legend_below()` (setup chunk): ggplotly
  parks horizontal legends on top of the x-axis title, which is exactly
  what hit the dumbbell and stacked-area charts on first render. Voice of
  the craft notes, maintainer-calibrated 2026-07-18: "measured with one
  twist", field-literate for court professionals and evaluators (the
  "maturation is not a threat to validity" line is a deliberate
  Campbell-and-Stanley wink, as is "only legal here"); nothing cheesy, no
  costume metaphors. The close cites Brooks et al. 2022 and Joubert,
  Davis, and Metcalfe 2019 (storytelling as knowledge translation), both
  verified against the PDFs before citing. The narrative prose follows
  the maintainer's own register (she supplied the intro herself,
  2026-07-18): full sentences joined with conjunctions or semicolons
  rather than staccato fragments (she rewrote "The line is exact. The
  people crossing it are not." to "...exact, but..."). Her intro history
  paragraph was lightly corrected before publishing and must stay
  correct: the 26th Amendment lowered the VOTING age (proposed March
  1971, ratified July 1971, the fastest ratification ever), it did not
  define an age of majority; the age-21 default came from English common
  law, echoed in the Fourteenth Amendment's voting text; states, not the
  Constitution, set the age of majority and most lowered it to 18 after
  1971. Do not revert to "signed into law" or "the Constitution defined
  the age of majority".
  Data is two kinds with different rules. (1) **Pathways aggregates** from
  the private `lwylie01/EAs` repo (nine tables now: the original seven
  plus `offending_by_age` and `capacities_by_age`, added 2026-07-18;
  every cell n ≥ 10, suppressed at source; EAs `validate.yml` re-checks
  every push). Update flow unchanged: regenerate in EAs, commit there,
  re-copy here, push; freeze off so CI re-renders. `offending_by_age`
  uses follow-up waves only (baseline SRO recall is not comparable and
  enrollment guarantees an offense); the recall window lengthens at month
  48, which biases the decline conservative, and the page says so. (2)
  **Public benchmarks** in `data/public_age_benchmarks.csv`: every row
  carries its own source citation (BJS NCJ 239423 robbery age-arrest
  curves 1990/2000/2010 from the report's figure-12 data file; BJS NCJ
  236096 appendix table 13; BJS NCJ 250975 tables 1 and 3; Census
  Statistical Abstract 2012 table 7). Numbers were transcribed from the
  named tables, never from memory; peak single-year age of all-offense
  arrests in 2010 is 19 (641,342, NCJ 239423 table 3), which is what the
  intro diagram's "~age 19" caption leans on. Never source from NCSC
  products (employer COI). No CSV is publicly linked; the files exist for
  the render.
  Hard rules unchanged: person-level Pathways data is NEVER committed to
  any GitHub repo, public or private, and Git LFS is never the answer; the
  public site gets aggregates only. EAs remote verified clean 2026-07-14.
  Study facts verified 2026-07-18 against the published record: 1,354
  youth, ages 14-17 at offense, enrolled Nov 2000 to Jan 2003 in
  Philadelphia County PA and Maricopa County AZ, baseline plus follow-ups
  to 84 months. Wording rule from the same audit: 14,894 person-wave
  records is NOT an interview count (the EAs import imputes age for missed
  waves, and all of wave 11), so the page says "followed 1,354 people
  across 11 interview waves" and credits only the 12,000+ scored
  interviews as completed; do not "correct" it back to "gave 14,894
  interviews". The intro figure
  (`countedwrong/pics/age_crime_curve_overlay.png`) is the maintainer's
  own graphic (navy version; source pptx in her NCSC Young Adult
  Deliverables folder, outside the repo). Cross-links renamed with the
  page: the projects card ("Maturity Gap: A Line at 18"), the
  Writing card (stays, described as a data story, maintainer's choice),
  and howold's reveal link. Since 2026-07-18 the page is also a homepage
  Start Here card (`pics/thumb-maturitygap.jpg`, 1150x430 header
  screenshot, JPEG q85, 87 KB). The close still links How Old Is Old? and the
  phrase "count some people wrong" stays as the echo of the old name.
- `CV/Wylie_Capacity_Dashboard.qmd` is private: gitignored and excluded from
  rendering. Keep it and `_freeze/CV/` out of the public site.
- `_freeze/` is tracked except `_freeze/hiphop/` and `_freeze/countedwrong/`
  (both ignored; freeze disabled for both).
