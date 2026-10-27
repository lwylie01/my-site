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
working premise (codebook intro). The narrative register, maintainer-stated
2026-07-21: **academic practical with subtle one-liners**. In narrative prose
that means full sentences joined with conjunctions or semicolons, not staccato
fragments (the homepage hero keeps its fragments) and not oracular
pronouncements; method detail belongs in the prose ("which is what the FBI
data gives"); dry lines are rationed per page, not per section: a few per
page, spaced out, each at the end of a note, because one after every section
reads robotic (maintainer, 2026-08-15, tightening the old one-per-section
cap; "spaghetti has no protagonist" is the benchmark, and why-this-chart
craft notes may keep their flourishes); first person wherever the
maintainer made the call; field-literate winks welcome. Maturity Gap's
narration is the calibration standard; the compassionate release page was
swept to this register 2026-07-21 and audited to the tightened ration
2026-08-15 (its dry closers are now exhibits 01 and 06 plus the craft-note
flourishes). **Humor never at a legal system's expense** (maintainer,
2026-10-21): she has a sense of humor, but no line may read as negative or
derogatory toward any court, legal system, legal process, or the people who
work in them. Dry lines aim at the method, the data, or the reader's own
assumptions, never at the institutions the site serves. When auditing copy,
also watch for lines that read as condescending to the visitor ("which parts
you have not thought through"). Quotation marks that mark a term as too
general ("the public", "policymakers") are the maintainer's deliberate usage
and are fine when the sentence says why, as the worksheet's Target Audience
intro does ("rather than with 'the public' or 'policymakers,' so name who you
are speaking to"); the risk is bare quotes in a short label with no reason
beside them, where they can read as sarcasm (the STORY band's old 'not "the
public."' gloss). Do not flag the worksheet sentence. The first audit under the rule (2026-10-21, every
replacement maintainer-picked, option B throughout) changed five lines: the
Trust Your Gut? card ("compare your calls with a simple two-factor checklist
and see where each one does better", replacing "scored against a checklist
that uses exactly two facts", which could read as professional judgment
losing to two facts), the STORY band's Target Audience and Yield glosses, the
worksheet card ("which parts still need planning"), and the evaluation
picker's `intro_title` ("Not every evaluation fits every program.", was "Most
of the field is wrong for you."). The worksheet's own Target Audience intro
keeps its quotation marks on purpose (maintainer, 2026-10-21; see above).
The Writing page's In the Works titles were audited the next day (option A,
maintainer-picked): "How Old Is Old? The Age the Law Pretends to Know" became
"...Where the Law Draws the Line on Age" ("pretends" called the law dishonest)
and "Trust the Checklist: Why Expert Judgment Keeps Losing" became "...What
Simple Rules Get Right" (the Gut card's trap again). The STORY chapter card's
"Most court data is buried in reports that go unread" was kept on purpose: it
names the problem the chapter solves without blaming anyone.
When drafting copy, offer the maintainer
2-3 options and let her pick and tune, and get her pick before the copy ships,
not after: PRs merge within minutes, so any user-facing string flagged "tune
later" goes live unreviewed (the picker intro headline did exactly that in
July 2026 and had to be redone). This applies to every user-facing string, not
just the marquee headline. Never present drafted copy as her quote, and never
attribute words to a publication without reading it.

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
mauve never carries text. Links inside running text are underlined (1px, 2px offset,
maintainer's pick 2026-10-01 from three mocked options): Deep Coral is 2.6:1
against body ink and about 1.0:1 against muted ink, so colour alone never
marked a link. The rule is `:where(main p, main li) a:where(:not([class]))`
in `site-theme.scss`, held at bare-`a` specificity so component rules win;
any link with a class is skipped. A new standalone "→" link inside a `<p>`
needs a class (the homepage's `.bio-cta`) or it gets underlined too. Fonts: **Spectral** (headings 600, body 400, italic for
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
One PR per batch of work. Open PRs **ready for review, never as drafts**
(maintainer, 2026-09-27): if a tool creates one as a draft, mark it ready
straight away. A PR that must not merge yet (copy still awaiting her pick)
says so in its title instead of hiding behind draft status. Immediately before every push, check whether the
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
- Since 2026-10-27 the helper ends in `fit_card()`, and the four native
  `plot_ly()` charts (radar, confidence donut, both violins) pipe through it
  too: every new chart must. It is the data stories' toolbar-off and
  title-wrapping fix adapted to dashboard cards, with two differences. A card
  has a fixed height, so `fit()` grows only the top margin (the plot gives up
  the room) instead of growing the chart past the card's bottom. And charts on
  a page tab that is not showing draw at plotly's 700px fallback; when the tab
  opens, plotly's own responsive handler resizes them before a ResizeObserver
  sees a change, so `fit()` re-runs on every `plotly_afterplot` instead (it
  relayouts only when the title or margin moves, so it settles). Before this,
  19 of the charts ran their titles off the card on a phone and 15 did on a
  laptop. Chart C on page 5 is native, so its title is hand-built in the same
  `<b>…</b><br><sup>…</sup>` shape and font (sans, 18.6px, theme_hiphop's
  14pt) as A, B and D, which is what lets `fit()` treat all four alike.
- `fit_card()` carries a second hook since 2026-10-27 (maintainer's picks A
  on legends, era labels and phone height) that lays out what sits under the
  plot after every draw. A horizontal legend anchors to the chart's bottom
  edge (`legend.yref: 'container'`, plotly 2.25 has it) with `margin.b` sized
  to the measured axis band plus the legend: ggplotly sets it a fraction of
  the plot's height below, which landed on the axis title of six charts. An
  x axis title wider than the plot wraps; a y axis title drawn past the
  chart's left edge (the paneled charts' "Vocab Breadth") gets `margin.l`.
  Era names on an x axis are two-line via `two_line()` (chart C by hand), and
  where the widest line still exceeds its share of the plot (2000s, 2010s,
  2020s under about 200px) the hook tilts them -45 on one line; the old fixed
  30-degree tilts are gone. ggplotly writes a label break as `<br />`, so the
  hook matches `<br\s*\/?>`. The tilt rule covers any word labels on an x
  axis, so the heatmaps' one-word dimension names tilt too; numeric axes
  never do.
- Layout below 992px (2026-10-28, maintainer's defaults): a front-matter
  `include-in-header` style extends bslib's and Quarto's phone rules (one
  column, rows sized to content) from below 576px up to 991px, because at
  768px the desktop grid gave page 5's four charts 111px columns; and every
  stacked chart gets `min-height: 520px` (the widget default is 400px, and a
  wrapped title plus a legend left some plots under 100px). It is
  `min-height`, not `height`: #162 shipped `height: 520px !important`, which
  also cut page 3's deliberate 900px heatmap down on phones. Below 576px a
  colour scale is hidden (`marker.showscale`, in the second hook): it took
  most of a phone's width and left the canon map and fingerprints 64px
  plots; each of the three charts' subtitles says what the colour encodes
  and a tap on any mark gives its value. Laying it flat below did not work
  in plotly 2.25 (`colorbar.yref: 'container'` drew it mid-chart over a
  338px background box and kept the right margin; paper units ran the
  margin away against plotly's own colourbar autoexpand).
- Open (2026-10-28): page 3's score heatmap on a phone, where its era strip
  labels are cut at the right edge and the 2010s rows (the most artists)
  overprint, which is density rather than layout.
- The dashboard's `nav-buttons` merge into the site navbar (2026-10-28,
  maintainer's pick A): only "Periodic Table" and "Codebook" stay, because
  the home and GitHub buttons repeated the site navbar's own Home and GitHub.
  They render as `.quarto-dashboard-link`, which was underlined, unspaced
  ("Periodic TableCodebook") and a dim mauve at about 3:1 on ink, so
  `custom.scss` (loaded only by the dashboard) styles them like the site's
  nav links: 85% white, 500 weight, 0.9rem, padded, no underline.

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
returns early and shows `#zero`, because sorting the cards into "these fit what
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

Phone pass 2026-10-23 (maintainer's picks A and A): the sticky `#results-bar`
(tabs plus stats) was five rows and 196px at 390px, against the siblings' 91px,
because each tab label wrapped and the hint and print button took a row each.
Below 640px the tabs lose their gap and take 0.6rem side padding and the stats
bar gap is `0.3rem 0.75rem`, so at 390px it is 112px (158px at 320-360px, where
the tabs still wrap). The header `<h1>` carries `text-wrap: balance`, so phones
read "Which Evaluation / Should We Do?" instead of stranding "Do?".

### The pieces

| File | Role |
|---|---|
| `evalpicker/data/evaluation_approaches.xlsx` | Source of truth. Sheets: **Rules** (one row per rule, 8 rows over 7 axes), **Levels** (allowed values per axis, 37 rows), **Approaches** (17), **TMFs** (2; theories, models and frameworks), **Prerequisites** (what must come first, 8), **Copy** (UI strings + one `reason_*` per rule, 68). Counts re-verified against the built page 2026-08-19. Copy went 38 to 62 in the July 2026 pass: ~15 strings were welded into the template (both empty states, the tab labels, `Any` / `Clear` / `Already done`, the stats words, the gap leads, the chain annotations) so the "words live in Excel" premise was only half true. Check 5b now enforces it. Text is HTML-escaped on every path, so no markup or links can live in a Copy string. The `<h1>` stays hardcoded like barnum's and howold's: its `<span>` cannot survive escaping, which is why `page_title` was deleted rather than wired |
| `evalpicker/build_eval.R` | Quarto pre-render step. Validates the workbook (see below), then serializes all six sheets to JSON and injects them at `__RULES_DATA__`, `__LEVELS_DATA__`, `__APPROACHES_DATA__`, `__TMFS_DATA__`, `__PREREQS_DATA__` and `__COPY_DATA__` in the template, producing `evalpicker/eval_picker.html` (gitignored; built in CI; never edit the output directly) |
| `evalpicker/app/_template.html` | The picker's look and matching logic |
| `story/index.qmd` (was `teaching/index.qmd` until 2026-10-20) | Links `evalpicker/eval_picker.html` as a tool card, now its only link: it was a homepage featured card (`pics/thumb-evalpicker.jpg`) until the 2026-07-21 homepage declutter dropped both picker cards. Moved off `projects/index.qmd` in the July 2026 section reshuffle: the pickers are teaching tools, so Projects holds only the research work |

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

**Resolved (bf15b6e, 2026-07-15): the two dead options are dead no more.**
The picker originally shipped with nine items, and `Participants` (audience)
and `For whom` (question) appeared in no `audience_ok` or `question_ok` cell,
so picking either failed everything on an Intent rule: 0 fit, 0 close, 9 ruled
out. The agreed fix landed in the ten-approach batch: `REALIST` (Pawson &
Tilley own "what works, for whom, in what circumstances") and `EMPOWER`
(empowerment evaluation, Fetterman) exist, `audience_ok` carries Participants
on EMPOWER and UFE, and `question_ok` carries For whom on REALIST.
Re-verified on the live page 2026-08-19: picking Participants now returns 2
fits. The reason the fix waited is still worth knowing: no validator check
touches a prose cell, so a row with blank prose renders as a thin card rather
than failing, and TODO placeholder text would publish on push; rows land only
when the prose and sources exist. A worthwhile assertion for any future audit:
**every Levels value should appear in at least one item's rule cell.** Nothing
checks that today.

The `note_*` overrides look neglected and are not (the counts here are from the
original nine-item page; the pattern is the point, re-count before leaning on
the numbers). 42 failure cells could actually
fire; 5 were bespoke and 37 used the generic `reason_*` template. But every rule
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
| `formatpicker/data/delivery_formats.xlsx` | Source of truth. Sheets: **Rules** (3, one per question), **Levels** (13), **Formats** (21), **Copy** (46: UI strings plus one `reason_`/`short_` per rule, and the five `reach_built_*` / `reach_use_*` phrases). Editable in Excel |
| `formatpicker/build_format.R` | Pre-render step. Validates the workbook (checks 1-5b from `build_eval.R`, minus the prerequisite checks 6-8), serializes the four sheets to JSON and injects them at `__RULES_DATA__`, `__LEVELS_DATA__`, `__FORMATS_DATA__`, `__COPY_DATA__`, producing `formatpicker/format_picker.html` (gitignored; built in CI; never edit the output) |
| `formatpicker/app/_template.html` | The picker's look + matching logic |
| `story/index.qmd` (was `teaching/index.qmd` until 2026-10-20) | Since 2026-09-27 the picker has no card of its own: it is the companion link on the Data STORY Worksheet card (maintainer's call, structure C below), and the worksheet's "Select the Format" step links to it too. Before that it had its own Teaching card, and before the 2026-07-21 homepage declutter a homepage featured card (`pics/thumb-formatpicker.jpg`, 1150x430). Like the evaluation picker, it moved off `projects/index.qmd` in the July 2026 reshuffle |

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
(Digital and interactive), `VIDEO` Video or Documentary (Outreach and media),
`GUIDE` How-To Guide (Written report). Four more followed 2026-07-21, from a
methods-and-references review (the page read as if it all came from the
maintainer's own Trends chapter): `WORKSHOP` Workshop and `WEBINAR` Webinar
(kept separate at her request: Workshop is internal and decision-facilitating,
Webinar reaches outward to raise awareness), `POSTER` Research Poster (those
three Presentation), and `OPED` Op-ed or Commentary (Outreach and media). None
are in the Trends Fig. 2 tree and never claim to be: every `source` cell reads
"Added from practice (2026)", and the footer names them collectively ("seven
formats added from practice"; the intro screen's note carried the provenance
too until the 2026-07-21 voice pass moved it to the footer alone). All seven
use existing families, so `GROUP_COLORS` needed nothing. A same-day follow-up
(2026-07-20) added Expert to `BRIEF`'s `audience_ok` (a technical brief for an
expert reader is a real thing the practice ships), closing the crosswalk's last
gap.

The same 2026-07-21 review reworked the footer from a figure-only credit into a
knowledge-translation framing (maintainer picked it from three offered options),
naming the scholarship the picker's three axes actually rest on: audience
subgroups from Tabak, Khoong, Chambers and Brownson (2013); objectives from
COSCA (2024); method from Duarte, Nussbaumer Knaflic, and Segel and Heer (2010),
framed by Lavis and colleagues' (2003) knowledge-translation questions. All are
already footnoted in the maintainer's own chapter, so the fix surfaced the
chapter's pedigree rather than inventing sources. Do not revert the footer to
the figure-only credit.

Voice pass 2026-07-21 (maintainer-approved from offered options): the page was
renamed from "Which Format Fits Best?" to **"Which Deliverable Fits?"** ("Best"
over-promised a single winner the tool refuses to name, and "deliverable" is the
maintainer's own word from the RSD handout). The hardcoded `<h1>` plus the
`page_sub`, `intro_title`, and `intro_note` Copy strings all moved. The top-bar
h1 and the intro-screen headline are deliberately different so the landing view
does not repeat one phrase twice; keep them distinct. `intro_note` dropped its
provenance clause (the footer already carries the sourcing), and the RSD
handout's footer link text was reprinted to match the new name.

Phone pass 2026-10-23 (maintainer's picks A, A and A): the sitewide "and, never &"
rule reached this picker's labels. The `family` values are "Brief and summary",
"Digital and interactive" and "Outreach and media" (`GROUP_COLORS` is keyed by
family name, so renaming a family means renaming its key, or its dot falls back
to the default brown), and `reachPhrase()` says "Internal and external".
`typical_length` takes one style: ranges with "to" ("2 to 4 pages", "20 or more
pages"), matching the siblings' "6 to 12 months" and "1 to 9 cases", and no
closing period. The modal's "Reach and objectives it serves" line lowercases
every objective after the first, since mid-list they read as prose. The reason
sentences followed the same day (maintainer's pick A): `plabel()` now lowers the
first letter as well as stripping the gloss, the same as qualpicker's, and
`plabels()` joins with a final ", or" ("inform or explain, support a decision,
or document or archive"), using a bare "or" only for two items that carry no
"or" of their own, because the objective labels do ("persuade or advocate, or
support a decision"). Audience names lowercase too in those sentences ("the
novice audience you named").

The reach reason no longer lists reach labels, which strung together badly
("built for both internal and external or external reach"); it says what the
format is for (maintainer's pick A, same day): "Annual Report is built to reach
outside your court, so using it inside your court means adapting how it is
polished and shared." `reachVars()` picks `reach_built_outside` for any format
whose `reach_ok` includes External, else `reach_built_inside`, and one of
`reach_use_internal` / `_external` / `_both` for the answer. All five phrases
are Copy rows named by literal `t()` calls, so check 5b covers them. Only six
format and answer combinations can fail this rule (15 sentences); re-read them
after any `reach_ok` change.

The intro prose was re-registered the same day: the maintainer found the first
cut ("No format is best for everything." plus clipped fragments) too
slogan-like, so `intro_title`, `intro_lead`, and `intro_note` were rewritten to
her academic-practical "measured, one dry twist" voice, the register
countedwrong is calibrated to (measured, field-literate, full sentences joined
with conjunctions or semicolons, one subtle dry turn, no punchy fragments). The
current headline is "There is no single best format, and that is the point." The
homepage and Teaching card descriptions mirror the lead's premise sentence, so
revise them together. This page is deliberately quieter than the site's hero
voice; do not "punch it up."

## Seeing Qualitative Data (`qualpicker/`)

Built 2026-10-17 (maintainer's picks that day: six axes, keep the weak forms,
the name, a Teaching card plus the worksheet link, cite now and she checks the
sources; every user-facing string was offered with options and she picked
option A throughout on 2026-10-19, so the shipped copy is reviewed, not "tune
later"). Once live she found the intro unclear and not her voice ("evidence
with a shape", "thresholds inside the text", "ties" were the abstractions),
so the same day the headline, lead and header subtitle were re-offered in
her register (the lindsey-voice skill: concrete members unpacked inline,
mechanism over adjective, one long compound sentence) and she picked:
headline "Once interviews, statutes, or case files have been coded, they can
be charted, and the chart depends on what the coding produced."; lead "The
same coded interviews can become a ranked bar chart, a matrix of cases by
themes, a timeline, or a page of quotations, and which one is honest depends
on..."; subtitle "Match the figure to what your coding produced and how many
cases you have." The Teaching card mirrors the lead's premise sentence, as
the format picker's does. The intro note stays identical to the format
picker's on purpose. The thumbnail is a header screenshot that includes the
headline, so it was retaken with the new copy. A third picker, for the question the compassionate release page
answers by example: coded documents and interviews have a shape, and which
figure suits it. Same Excel to R to one-HTML shape as the format picker, which
it is cloned from (no prerequisites, no TMFs). Answer up to six questions and
37 displays in seven families sort into fits / could fit with more / not the
tool here. It hangs off the Data STORY Worksheet's R4 step, "Create an
Illustration" (`link_label` + `link_url` on that Steps row, the same device as
S2's format-picker link), and has a Teaching card under The STORY Framework,
which now holds three cards in the pairs grid, so the third sits alone on its
row; the maintainer accepted a card knowing structure C would have made it a
companion link only.

### The pieces

| File | Role |
|---|---|
| `qualpicker/data/qualitative_displays.xlsx` | Source of truth. Sheets: **Rules** (7 rows over 6 axes: `units` has two), **Levels** (30), **Displays** (39), **Copy** (56). Generated by openpyxl, so it is a plain workbook, not an Excel save |
| `qualpicker/build_qual.R` | Pre-render step. The format picker's validator (checks 1-5b) plus: 5c the `shows_*` / `scale_*` Copy keys the template names indirectly (`scale_one`, `scale_range`, `scale_open`, `scale_over`), 5d unique Copy keys, 6 `shows` in {Passages, Phrases, Pattern} and a family on every row, 7 `units_min` never above `units_max`, 8 `example_label`/`example_url` come as a pair and the URL is `../`-relative or https (it reaches an href), 9 **every Levels value on an in-list axis is accepted by at least one display** (the dead-option assertion the evalpicker notes wished for). Injects `__RULES_DATA__`, `__LEVELS_DATA__`, `__DISPLAYS_DATA__`, `__COPY_DATA__` into the template, producing `qualpicker/qual_picker.html` (gitignored; built in CI; never edit the output) |
| `qualpicker/app/_template.html` | The format picker's template with the chips, sort, modal and footer swapped. Family dot (eight colours, decorative), a three-dot **shows** meter (Pattern / Phrases / Passages, word beside it), and a **cases** chip from `units_min`/`units_max`, in numbers that match the units question's own ranges ("1 to 9 cases", "2 to 50 cases", "10 or more cases", "more than 50 cases"; 2026-10-23, maintainer's pick B, replacing words like "a few to dozens cases" that did not read as English; `scale_over` is the Copy key for a Many minimum). Fits sort by family order then name. The modal carries a "See it in use" link built from the example pair |
| `story/index.qmd` | Card on the Data STORYtelling page since 2026-10-20 (it was under Teaching's The STORY Framework; `pics/thumb-qualpicker.jpg`, 1150x430 header shot, JPEG q88). The card description was trimmed to one sentence the same day, so it no longer mirrors the lead's premise sentence |

### The model

Six axes. `shape` (what your coding produced: counts, attributes, a number in
the text, sequence, process, relationships, nested, the words) and `question`
(what to show) fail as **Intent**. `units` is the maturity trick: too few
cases fails `units_min` as **Capacity** (wait, or get more), too many fails
`units_max` as **Intent** (wrong tool at this scale). `counting` ("Could you
defend a count?": every case / a designed sample / the cases I could reach) is
the axis that makes it a qualitative picker rather than a chart chooser; count-
reading forms accept only the first two, and failing it lands in the middle
pile tagged "Count would overreach". `words` (does the reader need the words)
fails as **Capacity** with "Pair with the text", a call, not a law: more data
will not help, but the useful verdict is the middle pile with the fix named.
`groups` fails as Intent. Reason strings interpolate `{display}`, `{have}`,
`{needed}`; `plabel()` lowercases the label's first letter and strips the
gloss, and `plabels()` joins with "or", because these are alternatives.

**The weak forms stay in** (maintainer, 2026-10-17): Pie chart and Word cloud
are rows whose `good_for` is a narrow concession and whose `not_for` says why
they rarely fit, with `note_*` overrides where the generic reason read badly.
Do not delete them to tidy the catalogue; the page saying why is the point.

**The mapping is the maintainer's to argue with**, as with the format picker:
no check touches which display accepts which answer. **An in-list cell is an
OR, so a form that needs two things must list only the one it cannot do
without.** The first real test (2026-10-19, the maintainer's Missouri Upstream
action plans: 152 plans across 45 circuits, 41 categories, kept off the repo)
caught the funnel, part-in-whole bars and quote cards fitting "counts, how
common" because their cells read "Process;Counts" or "Words;Counts", and the
time-ordered matrix, spans over time and span chart fitting "which cases have
which features" through an "Attributes" they did not need. Those cells now
carry the one shape each form requires (funnel Process, part-in-whole and the
two time forms Sequence, span Number, quote cards and the role-ordered matrix
Words). The same test showed `words_ok` = "Pattern" alone was too strict:
"Helpful, but not required" was tagging every pattern chart "Pair with the
text", so every pattern chart now accepts Helpful and only "the quotes carry
the evidence" trips the tag. Re-run that dataset's four questions (counts and
how common; attributes and compare; words and said; counts and compare across
several groups) after any mapping change: the clean answers are ranked bar,
lollipop, icon array, stat tiles, treemap; heatmap, icon array, framework
matrix, presence grid; codebook, framework and role-ordered matrix, quote
cards, word tree; heatmap and small multiples. Eight families:
Counting the codes (13, incl. the exhibits), Matrices (6), Ranges and
thresholds (3), Time and process (5), Relationships and structure (3), The
text itself (5), Metaphor and illustration (3), Places and maps (1). Thirteen
rows carry "see it in use" links to live exhibits (compassionate release
exhibits 01-10, Maturity Gap's frame, dumbbell and heatmap); the anchors are
the published section ids, verified against `gh-pages`.

**Places and maps (added 2026-10-20, maintainer's ask):** the Missouri test
ended in a choropleth question (its circuits are whole counties plus St.
Louis City, so the count heatmap can sit on a county map), and the picker had
no map row and no answer that could reach one. The `shape` axis gained a
third level, `Places` ("Places on a map (a value or feature per county,
circuit, or state)", order 3, the later shapes shifted), and `CHORO`
"Choropleth map (shaded areas)" is the family's one row: shape Places, question
Compare or Common, at least a handful of cases, no upper bound, `words_ok`
Helpful or Pattern, shows Pattern, with a `not_for` about reading size from
area (large rural units fill the eye). The family colour is `#3F6B5E` in
`FAMILY_COLORS`. Places alone fits only the choropleth, so Places with "what
was said" rules everything out, which is correct: a map cannot carry quotes.
The source cell says the cartographic sources are still to come: the
maintainer asked the same day for a rescan of the visualization literature
beyond qualitative methods (cartography, graphical perception, information
science), and nothing may be credited until she has supplied the PDFs and
they have been read. Cartogram, dot and hex maps are the obvious next rows
once that reading exists.

**Pictograph (added 2026-10-20, maintainer's ask):** `PICTO` "Pictograph (icon
units)" joined Counting the codes when the maintainer asked whether icon
charts and infographics belong here. The icon array (one mark per case) was
already in; the pictograph is the other icon form, one icon per set number of
cases, so it needs a round unit: `units_min` Dozens (a handful is an icon
array), counting Census or Designed, question Common or Compare, groups One or
Two, with a `not_for` about half icons and more than five or six categories.
Infographics are a deliverable, not a figure form, and stay in the format
picker (`INFOGRAPHIC`, Outreach and media); this picker chooses the figures
that go inside one. The source cell is "in common use (the Isotype unit
chart)" pending the rescan, like the choropleth's. Its four prose strings
were offered as options and the maintainer picked A throughout the same day,
so the shipped copy is reviewed.

**Sources, verified 2026-10-19 against the maintainer's own PDFs** (she
uploaded five from her program evaluation folder). Verdinelli and Scagnoli
(2013, IJQM 12: nine display types, matrices 60 percent of 377 displays, 27
percent of 784 articles using any display), Henderson and Segal (2013, NDE
139: word, sentence and theme levels; word clouds, word trees, phrase nets,
shaded theme-by-case matrix, thematic map, chronological charts, spectrum
display; the warning about losing subtlety is on p. 56), Wattenberg and
Viégas (2008, TVCG 14(6): the word tree as a graphical keyword-in-context,
font size by square root of frequency, branches under 1 percent pruned),
Gale and colleagues (2013, BMC Med Res Methodol 13:117: the framework matrix,
cases by codes with summarised cells, and the "13 out of 20 participants"
pitfall the counting axis answers) and Onwuegbuzie and Dickinson (2008, TQR
13(2): Tufte's five levels, Miles and Huberman's ordered displays, quantitizing
and crossover displays) all say what the page credits them with. **Miles,
Huberman and Saldaña is the one source still unread** (a book, not in the
upload); its matrix orderings and checklist matrix are credited on the
strength of the summaries in Onwuegbuzie and Dickinson (pp. 207-209) and
Verdinelli and Scagnoli, both of which cite the 1994 edition. The footer
links are DOIs and the Sage page; doi.org is egress-blocked in CCR, so they
were not fetched from here. The fix pass that followed the reading: rows with
no "see it in use" link no longer carry a source string promising one, the
Onwuegbuzie and Dickinson credit says quantitizing rather than calling every
bar chart a crossover display, the word tree's not_for concedes that size
does show frequency roughly, and the footer gained the Gale pitfall.

Verification without R: `make_workbook.py` is not in the repo (the workbook is
the source now); replicate the build in Python (openpyxl is present in the
CCR image), drive the page in headless Chromium, and sweep every Levels value
alone to confirm at least one fit each.

### Update checklist

**Adding a display:** a Displays row with a unique id, a family from the eight
(or add a colour to `FAMILY_COLORS` in the template), `shows`, every rule cell
blank or a Levels value, and an example pair only if a live exhibit exists.
**Adding an axis:** a Rules row, its Levels rows with `order`, `reason_` and
`short_` Copy rows, and the column on Displays; the validator catches the rest.

## Data STORYtelling page (`story/`)

Added 2026-10-20 (maintainer's call: the Teaching page had grown overwhelming,
so the planning tools got their own page and navbar entry). Navbar text is
**STORY** (seventh entry, after Teaching); the page title is "Data
STORYtelling" with the eyebrow "Planning tools" and `pagetitle: "Data
STORYtelling"`. It holds what used to be Teaching's "The STORY Framework"
section: the worksheet card first (the hub, structure C, with the format
picker as its companion link), then the evaluation picker and the qualitative
display picker, in one default three-column `.project-grid` under **The
Tools** (`01 · planning tools`, anchor `#planning-tools` kept from Teaching).
Above the grid sits an **ink band** naming the five STORY elements, the
"structure before coral" decision: the maintainer asked whether more coral
would break the pages up, and the answer was no, because coral everywhere
costs the one-coral-dot motif its meaning and Coral on cream fails contrast,
so the band is Ink Plum with Coral letters (the brand's one coral-as-text
pairing, 5.1:1) and a one-clause gloss per element in cream. The glosses
shipped as the worksheet's Elements-sheet intros copied verbatim, which made
the band tall (a single column about 2,000px of the phone page), so the same
day the maintainer asked for one clause each and the band now carries short
cuts of those intros (offered as options, maintainer picked A throughout)
while **the worksheet keeps the full sentences**; a change to an element's
meaning touches both, and the band's clause should stay a cut of the
worksheet's sentence, not a new claim. Below 520px each element lays out as
a row (letter at left, name and clause beside it), which took the phone band
from about 1,100px to about 650px. The band's CSS is page-scoped in the qmd. **The three card thumbnails are light**
(2026-10-21, maintainer's call): each is a 1150x430 crop of the tool's intro
screen taken just below its dark header bar (header bottom at 97px on all
three), so the band is the page's only ink block; the dark-bar versions made
four in a row on a phone. Regenerate the same way after any intro-copy change,
because the intro headline is legible in the crop. The four planning tools' top bars (evalpicker,
formatpicker, qualpicker, datastory templates) link "STORY" to
`../story/index.html` instead of Teaching; the three exercises still link
Teaching. The Projects subtitle names both pages. The STORY-page card copy was
offered as options the same day (page subtitle, section intro, the trimmed
worksheet and qualitative-picker descriptions, plus the Teaching subtitle,
the Barnum line and the Projects subtitle) and the maintainer picked A
throughout the same day, so the shipped copy is reviewed.

## Data STORY Worksheet (`datastory/`)

Shipped 2026-09. A fillable planning worksheet, not a sorter: the five elements
and seventeen steps of Figure 1 in the maintainer's "Cultivating a Court's Data
STORY" (NCSC Trends 2025, ch. 12), each step a card of dropdowns, checkboxes and
text boxes. It digitizes the paper version she already used (a Word table of
element / step / answer, e.g. her NACM 2025 presentation notes). Same Excel to R
to one-HTML-page shape as the pickers, vanilla JS, no CDN beyond Google Fonts,
no new CI packages (readxl plus base R).

Maintainer picks (2026-09-25): structure **C**, the worksheet is the hub and
deeper tools branch off the step they serve ("Select the Format" links to the
format picker; future STORY tools hang off their own steps rather than getting
their own Teaching cards, because a page of single decision tools was judged "a
bit much"). Name **The Data STORY Worksheet**; intro headline "A data story is
planned long before it is written, and this is where the planning goes."
Teaching page: one Data STORY card replaces the format picker's card, with the
picker as a companion link; card description maintainer-picked 2026-09-27
("...It will not write the story for you, but it will show you which parts
you have not thought through yet"). The Teaching grid still has six cards. No worked example yet (her NACM notes name
co-presenters and OVW guidance; use them only scrubbed and with her say-so).

### The pieces

| File | Role |
|---|---|
| `datastory/data/story_worksheet.xlsx` | Source of truth. Sheets: **Elements** (5), **Steps** (17; label is Figure 1 verbatim, help_text condenses the chapter, optional link_label + link_url), **Fields** (40; input_type select / multi / text / textarea, list_id for the first two), **Options** (41), **Copy** (23 UI strings) |
| `datastory/build_story.R` | Pre-render step. Validates, then injects `__ELEMENTS_DATA__`, `__STEPS_DATA__`, `__FIELDS_DATA__`, `__OPTIONS_DATA__`, `__COPY_DATA__`, producing `datastory/story_worksheet.html` (gitignored; built in CI; never edit the output) |
| `datastory/app/_template.html` | Look and behaviour: intro, worksheet with a sticky S-T-O-R-Y rail showing per-element progress, and the plan screen |

### Rules that are decisions

- **Two lists are borrowed, not authored.** `@formats` (Formats sheet
  format_name) and `@audiences` (Levels audience labels) are read from
  `formatpicker/data/delivery_formats.xlsx`, so the worksheet and the picker it
  links to cannot disagree. The Options sheet may not define `@` ids (the
  validator refuses). Adding a format to the picker adds it here for free.
- **Answers never leave the browser.** localStorage key
  `datastory-worksheet-v1`, every access in try/catch; the page works without
  storage. Courts may plan with real findings, so do not add anything that
  posts answers anywhere.
- **Output is print plus Word.** Printing from any screen prints the plan (the
  print CSS hides the form), and "Download as Word" builds a real `.docx` in the
  browser: a stored (uncompressed) zip with a hand-rolled CRC-32 and three
  parts. WordprocessingML is order-sensitive: inside `w:pPr`, `keepNext` must
  precede `spacing`, and inside `w:rPr` the order is rFonts, b, i, color, sz. A
  wrong order can make Word call the file corrupt, so keep that order when
  editing `para()`. Control characters are stripped before they reach the XML.
- The validator checks: unique ids on every sheet, parents exist, every element
  has a step and every step a field, numeric `order`, known input types, every
  select/multi names a list with 2+ options and text fields name none, link
  pairs complete, and every Copy key the template names resolves (same scan as
  the pickers' check 5b). A failed render is the validator working; fix the
  workbook.
- Phone pass 2026-10-23 (maintainer's picks A, A and A). Questions are spaced
  by `.field + .field`, not `.field:first-of-type`: the old rule matched by tag,
  so the first `<fieldset>` (a checkbox group) in a step lost its gap, and five
  questions sat flush against the one above. Below 640px each `.check` row is
  about 38px tall (it was 24px with ~5px between, easy to miss with a thumb),
  and since the rail hides the "1 of 4 steps" counts there, a 3px bar under each
  letter fills as steps are answered (`--p`, set on the link in `refresh()`;
  Coral fill on a faint mauve track), so a half-done element shows before its
  letter fills. The `.step-tag` went from 0.68rem to 0.7rem, the brand's 11px
  floor. The phone page is about 10,190px at 390px.
- Verification without R: replicate the injection in Python, drive the page in
  headless Chromium, and open the downloaded `.docx` with python-docx
  (installable from a downloaded wheel; LibreOffice is present in the CCR image
  but cannot load files).

## The Plot So Far (`selected-work/`)

The publications page. Renamed from "Selected Work" July 2026 once it showed
the complete record (title plays on the site name; the navbar entry and the
homepage link say "The Plot So Far" too). **The folder and URL stay
`selected-work/`** so nothing external breaks; only displayed names changed.

Section names follow the same register as the Counted Wrong headings (short,
concrete, a little literary): **The Plot Thickens** (was "Research Areas" then
"The Four Threads"; the figures say "by thread" to match, and "plot threads"
keeps the pun), **The Applied Side** (was "Program
Evaluations and Applied Research"), **The Paper Trail** (was "Citation
Impact"). **Curriculum Vitae keeps its proper name**, maintainer's choice, as
did "Writing" and "Projects": a second plot pun in the nav ("Plot Points") or
renaming Projects to "Exhibits" was judged one step too cute. Keep new names
in this register and stop before kitsch.

The same naming pass reached the other pages (all July 2026, maintainer-picked
from offered options): homepage sections are **The Premise** (was "What I Do",
over the bio) and **Start Here** (was "Featured Projects"); the html anchor ids
(#about, #featured) kept their old names on purpose, so links do not break. (A
third section, **The Method** / "How I Do It" / #whatIdo, lived on the homepage
until the 2026-07-21 declutter relocated it to the Projects page, below.) Teaching's topics section
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
an all-inclusive list, repeats were the complaint that prompted it.

Phone pass 2026-09-27 (maintainer-picked): both figures draw twice. At 560px
and wider they are the original 920-unit drawings (timeline gutter labels,
citation labels left of the bars, `minWidth: 680px` with the swipe hint as a
fallback). Below 560px a compact drawing is built to the pixel instead: the
thread names move to a wrapping HTML legend, the timeline gets the full width
(ticks every fourth year, a thin color rule per lane) and each citation label
sits above its bar, so nothing needs swiping and every count shows. Tooltips
open on click as well as hover, because on touch `pointerleave` fires the
moment a finger lifts and a hover-only tip just flashes; only a mouse leaving
hides it, and a tap outside the charts dismisses it. That is what makes the
header's "Tap or hover any point" true, so keep the two together. Headings
carry plain labels (`01 · research areas`, `02 · program evaluations`,
`03 · citations`, `04 · cv`), matching the other section pages, and the
`.pub-all` summaries are padded to a ~48px tap target in brand muted ink. The two legends name the threads differently on purpose (2026-10-22,
maintainer kept it, option A): the timeline uses the full area labels and the
citations chart the short `legend_key`s, which suit its narrower legend. A
title ending in "?" or "!" takes no added period in a citation (`cite_line()`),
so "Am I a Caregiver?" no longer renders as "?." The page's five content blocks (both
figure cards, the area lists, the reports, the CV block) are `.container`s
with an inline max-width (960px for figures, 820px for text) and, since
2026-10-23, `margin-left: 0; padding-left: 0` (maintainer's pick B): Bootstrap
centred them, so on desktop the figures sat about 100px and the lists about
170px right of the section headings' left edge, and the padding indented them
12px on phones. They now share the headings' left edge at every width and keep
their max-widths; the `.pub-all` summary arrows still hang just left of it.

The Writing page (regrouped 2026-09-27, maintainer-picked) has two labelled
sections: **On the Record** (`01 · published`, `#on-the-record`), live pieces
as `.essay-card` links each ending in a visible `.essay-go` "Read ... →" line,
and **In the Works** (`02 · in progress`, `#in-the-works`), unwritten essays
as a compact `.essay-list` with no read times (a read time on an unwritten
piece is a promise the page cannot keep) and no hover lift, so they do not
look clickable. When an essay ships, move it from the list to a card with its
real link. "Cultivating a Court's Data STORY" is the published Trends 2025
chapter, so it sits On the Record linking the NCSC PDF, with its venue as an
`.essay-venue` line; it was wrongly listed as coming soon until then.

Writing refinement (2026-10-01, every string maintainer-picked): new subtitle
("Essays and data stories on measurement and evidence, and on the gap..."),
an untangled Maturity Gap description, and two accuracy fixes. The
compassionate release read time is 12 min, not 9: the published page is about
2,900 words with the folded codebook excluded (Maturity Gap's 8 min checks out
at about 2,100). Re-count read times from the published HTML when a data story
grows. Trust the Checklist no longer says a two-variable rule wins "almost
everywhere we've checked"; it now says simple rules "match or beat expert
judgment most of the time", which is what the Gut exercise's own sources (Meehl
1954; the 136-study meta-analysis) support. `.essay-card:focus-visible` carries
a Deep Coral ring, because the whole card is the link.
Same day (maintainer's idea pick, wording option A): the three In the Works
items that already have a matching exercise end on a `.essay-companion` line,
"Companion exercise: <name> →" (hip-hop essay → The Hip-Hop Periodic Table,
How Old Is Old? → its exercise, Trust the Checklist → Trust Your Gut?); When
the Metric Becomes the Policy has none. The item itself stays unclickable; the
whole companion line is the link (label in muted ink, name underlined Deep
Coral), because an inline-block name after a separate label dropped to its own
line on phones and left the label stranded. When an essay ships, its item
becomes an On the Record card and the companion line goes with it (or moves
into the card's description). Links in muted-ink text must be underlined:
Deep Coral and muted ink are about 1.0:1 in luminance, so colour alone does
not mark them (the sitewide `a { text-decoration: none }` rule makes this the
default trap); `.project-card-companion a` is underlined for the same reason.
Desktop pass 2026-10-23 (maintainer's picks B and B): `.essay-card` is a
column flexbox and `.essay-go` takes `margin-top: auto`, so the three "Read"
links share the cards' bottom line instead of following their descriptions to
three heights; and `.essay-list` is capped at 520px, the page subtitle's width,
so an In the Works description runs about 85 characters a line instead of about
140 across the full page.

### The pieces

| File | Role |
|---|---|
| `selected-work/data/publications.xlsx` | Source of truth for publication metadata. Sheets: **Publications** (36 rows: id, year, area, type, title, venue, authors, url, short_label, featured, featured_order), **Areas** (4: key, label, legend_key, color, description, order), **Reports** (21 project reports for the Program Evaluations section), **Meta** (citations_source, citations_asof, scholar_url, tail_count, tail_total, ncsc_url, jji_url) |
| `selected-work/data/citations.csv` | Citation counts, text format on purpose (a bot edits it; a binary xlsx cannot merge). `citations` is the DISPLAYED count (Google Scholar, maintainer-curated); `openalex_id` / `openalex_cited` / `openalex_fetched` are reference columns the monthly workflow refreshes and the page never shows |
| `selected-work/index.qmd` | One validating R chunk (stopifnot, fail-loud like countedwrong) reads both files and emits `window.SW` JSON for the two chart IIFEs, the research-area sections (curated list + collapsible "All N publications"), the reports section, and the computed citation figure title and footnote. Both figures and every list render from one dataset, so they cannot contradict each other |
| `selected-work/_metadata.yml` | `freeze: false`; `_freeze/selected-work/` is gitignored |
| `selected-work/refresh_citations.R` | Updates the OpenAlex reference columns from the API. Never touches `citations` |
| `.github/workflows/refresh-citations.yml` | Cron, 06:00 UTC on the 1st monthly, plus `workflow_dispatch`. Runs the refresh script and opens a PR (`bot/citation-refresh`) when counts moved; never pushes to main. The PR body lists movers as a prompt to hand-refresh the Scholar numbers and `citations_asof`. Needs the repo setting Settings → Actions → General → "Allow GitHub Actions to create and approve pull requests" enabled, or the run does the refresh and then dies at PR creation (the first run, 2026-08-15, failed exactly there and its refresh was dropped) |

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
merge. The chart order, title, and totals recompute. Two Meta values do NOT
recompute and go stale silently: `tail_count` and `tail_total` (the footnote's
"N more publications have 9 or fewer citations each, about M combined") are
hand-set, and the "9 or fewer" cutoff is why an uncharted paper that reaches 10
on Scholar must be promoted (give it a `citations` value; it already has a
`short_label`), moving its count out of the tail. Check both on every refresh.
The bot only watches OpenAlex, which barely moves on this record (one paper
changed in two months while 12 of 20 Scholar counts had drifted by 2026-09), so
a quiet bot PR is not evidence the displayed counts are current: compare the
Scholar profile itself (it loads fine in a real browser, only scripts are
blocked) and bump `citations_asof` only after doing so.

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

## Swag (`swag/`)

The brand-merch page: stickers and shirt art you can actually download, plus
mockups of things that do not exist. Shipped July 2026, reorganised 2026-07-25.
Pure static HTML in one `{=html}` block, no build step, no `_metadata.yml`,
nothing renders from it, so freeze never enters into it. Linked only from the
navbar (`_quarto.yml`).

Two sections, and the split is the point: **01 Downloads** is everything that
hands you a real file (quote stickers, character stickers, shirt art), **02 The
Merch Table** is mockups only. That distinction is carried by the structure and
stated once in the header intro; it used to be repeated four times, which is
most of what made the first version read as cluttered.

### The pieces

| File | Role |
|---|---|
| `swag/index.qmd` | The whole page. Page-scoped `<style>` block plus shared card classes from `site-theme.scss` (`.project-card`, `.source-chips`, `.chip-link`, `.page-header`) |
| `swag/downloads/stickers/*.png` | Seven individual quote stickers, transparent (five quotes plus the two bare marks) |
| `swag/downloads/sticker-sheet.png` | The original flat sheet, offered as the whole-set download |
| `swag/downloads/shirts/*.png` | Six individual shirt designs |
| `swag/downloads/shirt-designs.png` | Six-up contact sheet of the shirt designs |
| `swag/pics/sticker-*.png` | Six full-resolution character stickers (the download targets) |
| `swag/pics/thumbs/sticker-*.png` | ~300px previews of the same six (what the gallery displays) |
| `swag/pics/kit-*.png` | Mockup images for The Merch Table (tote, mug, laptop) |
| `swag/pics/mascot-headshot.png` | The "Your host" avatar in the page header |

### Where the art comes from

The quote stickers existed only flattened into `sticker-sheet.png`, so there was
nothing to feature until they were separated. The seven files in
`downloads/stickers/` were cut out of that sheet losslessly by a pure-Python PNG
decode (there is no PIL, ImageMagick or pngquant in the CCR sandbox, and pip
times out), then the outer cream was flood-filled to transparent from the crop
border. The sheet itself stays as the download for the whole set.

**`sticker-be-the-outlier.png` is the exception: it is no longer a crop.** The
face baked into the old sheet was an early, much cruder drawing that does not
resemble the maintainer, so the badge was rebuilt (2026-07-25) from
`pics/mascot-headshot.png`, the same illustration as the "Your host" avatar and
the six character stickers. The composition is unchanged (coral disc, Paper
inner circle, white Spectral wordmark), it renders at 632x632 on transparency,
and the sheet was regenerated to pick it up. Do not restore it from the old
sheet. Anything else needing that face should come from `pics/`, not from a
crop: the six character stickers carry their own baked-in text, so
`mascot-headshot.png` is the only clean source.

The shirt PNGs are rasterised from the inline SVGs in `index.qmd` with headless
Chromium (`/opt/pw-browsers/chromium`). **Spectral and JetBrains Mono must be
inlined as base64 `@font-face` data URIs** or the type silently falls back to
Georgia; fetch them from Google Fonts, which the proxy allows. Five render on
transparent backgrounds; **The Wordmark renders on its ink background** because
its art is cream and would otherwise be invisible. `shirt-designs.png` is built
from those six files and cropped to content: the version before 2026-07-25
truncated its bottom row of three designs by 79px against a hard canvas edge, so
if you rebuild it, decode the result and assert the content is inset from every
edge. The same rebuild has a second trap: a `figure` laid out with flex and
`justify-content` silently dropped the second row's captions, so use
`display:block` with `padding-top` on the `figcaption` and verify a caption band
exists under every row.

### Rules that are decisions, not accidents

- **The character stickers stay folded.** The funny quote stickers are the
  focus; the six stickers of the maintainer sit inside `<details
  class="swag-fold">`, styled after `details.codebook-fold`. Do not promote them
  back to the top level. The default view is five tiles, not fourteen.
- **Gallery previews are the thumbnails, downloads are the originals.** The six
  character stickers are 438-672 KB each; pointing the previews at them put
  about 3.6 MB on first paint. Preview from `pics/thumbs/`, link to `pics/`.
- **Wallpapers were removed** (2026-07-25) and should not return.
- **The Merch Table is three mockups.** The business card and slide template were
  removed; do not re-add them.
- **Shirt art lives under Downloads, not with the mockups**, because it
  downloads. The tees themselves are still imaginary.
- Decorative inline SVGs carry `aria-hidden="true"` plus `focusable="false"`, or
  they read their baked-in text ("AGE 18", "DATA WITH A PLOT") to a screen
  reader immediately before the identical card title. Every shirt download chip
  carries an `aria-label` naming its design: five of them otherwise share the
  accessible name "PNG (transparent)".
- **The mockup wells show the whole scene** (2026-10-22). The three
  `pics/kit-*.png` were captures with a white band along the bottom and white
  rounded-corner pixels, and `.swag-art img`'s `max-height: 100%` never
  resolved inside the grid well, so each image ran past its 3:2 box and was
  clipped: the tote lost "the story is in the scatter" and the mug and laptop
  showed white strips. The PNGs are now trimmed to the scene with the corners
  filled taupe, and `.swag-art--kit` gives those wells a definite grid track
  and the scene's own taupe (#D9D0C4) so `contain` letterboxes invisibly. A new
  mockup image goes in a `swag-art swag-art--kit` well, trimmed the same way.
- `.swag-gallery a:focus-visible` must keep a real outline. A shared hover and
  focus rule carrying `outline:none` once left all thirteen sticker download
  links with no visible focus indicator.

### Open items

The maintainer has a fuller set of funny quote stickers, made with Claude
design, that is not in the repo. Google Drive and Adobe Creative Cloud tool
calls are refused at the harness level in CCR sessions (`MCP error -32003`), so
they have to be supplied directly. When they arrive, add them to
`downloads/stickers/` and to the Quote Stickers gallery; nothing else needs
touching.

**Swag is reached from the navbar and nowhere else, on purpose.** A cross-link
card on Teaching or Projects was drafted and turned down (maintainer,
2026-07-25), in the same spirit as the 2026-07-21 declutter: Teaching's grid is
teaching tools, Projects holds the research work, and Start Here is deliberately
the two signature pieces. Do not add a swag card to any of them.

### Update checklist

**Adding a sticker:** file in `downloads/stickers/` (transparent PNG), one `<a
download>` tile in the Quote Stickers `.swag-gallery` with a descriptive `alt`
and a `.cap` caption. The gallery is `repeat(auto-fit, minmax(150px, 1fr))`
(auto-fit since 2026-10-23, maintainer's pick B; auto-fill left an empty sixth
slot beside the five quote stickers at 1200px and up), so a row with fewer
tiles than slots stretches them to fill it. Six tiles fit one row from about
1200px; below that a sixth wraps to a second row. Below 520px the gallery is two tiles per row
(2026-10-22, maintainer's pick B), which cut about 380px of phone scroll from the
five quote stickers; an odd count leaves the last tile alone on its row. `.cap`
is `display:block` so its own 1.3 line height applies when a caption wraps
(as an inline span it inherited the body's looser line box). The
mockup descriptions use curly quotation marks (same day).

The shirt cards' download chip (`.project-card > .source-chips`) takes
`margin-top: auto` (page-scoped, 2026-10-23, maintainer's pick B), so a row's
chips share the cards' bottom line; The Wordmark's longer description had set
its chip about 25px below its neighbours'.

**Adding a shirt design:** inline SVG card in the Shirt Art grid (the wrapper
gets `aria-hidden="true"`), rasterise it to `downloads/shirts/`, add a
`.chip-link` with an `aria-label` naming the design, and rebuild
`shirt-designs.png`.

**Adding a mockup:** a `.project-card` in The Merch Table with a
`pics/kit-*.png` image. Mockups get no download chip: the section lead says once
that the whole group is imaginary.

## Other site areas

- `barnum/` mirrors the hiphop pattern (Excel → `build_barnum.R` → HTML) and is
  the template for self-contained interactives: `howold/` ("How Old Is Old?"),
  `gut/` ("Trust Your Gut?"), `evalpicker/`, `formatpicker/` and `datastory/`
  (all above) follow it. Each is a
  `build_*.R` pre-render step plus `app/_template.html` plus `data/*.xlsx`,
  with a gitignored HTML output: edit the xlsx, CI rebuilds. howold and gut
  shipped July 2026 (reveal punch lines maintainer-approved 2026-07). The July
  2026 reshuffle turned the Teaching page from prose into a card grid (matching
  Projects/Writing). **Teaching regroup (2026-09-27, maintainer-picked)**: the
  maintainer found the intros cheesy and the page too full for visitors who are
  not data people or social scientists, so "The Hook" section and its six
  jargon concept pills were removed, and the six cards split into **Short
  Exercises** (Hip-Hop Periodic Table first as the flagship, then Barnum, How Old
  Is Old?, Trust Your Gut?) and **Planning Tools** (evaluation picker, Data
  STORY Worksheet), each with a one-sentence intro. Same day, those working
  names became themed headings with the plain names kept as `data-eyebrow`
  labels (maintainer-picked from a story-craft brainstorm): **Warm-Ups**
  (`01 · short exercises`) and **Storyboards** (`02 · planning tools`), with
  The Usual Subjects labelled `03 · topics`. "Storyboards" is grounded, not a
  pun: her chapter recommends storyboarding to plan a data story. The labels
  are the findability half of the bargain, so keep them if the headings change
  again. Anchors stay `#short-exercises` / `#planning-tools`. Rejected
  directions, for the record: stage and screen (Table Reads, Cold Reads),
  case files (Case Files, The Lineup), and plain (Try It Yourself / Plan Your
  Own). Cards carry a
  plain tag ("Exercise · Prediction", "Planning Tool · Evaluation") instead of
  the old tech chips (R / Quarto, HTML / JS), which told a non-data visitor
  nothing; do not bring the tech chips back. Both grids use
  `.project-grid--pairs` (site-theme.scss: two columns, one below 700px),
  because the three-column default orphaned the fourth exercise. The header
  subtitle is "The exercises below each ask you to make a quick judgment, and
  the planning tools help you work through an evaluation or report of your
  own," and the header link names the chapter by its real title, "Cultivating a
  Court's Data STORY" (it had read "Telling Your Court's Data Story"). The
  Usual Subjects is trimmed to one line per topic. Phone height went from
  4,656px to 3,519px. Before all this, howold and gut sat under a prose "Two
  Shorter Exercises" heading.
  **Teaching split (2026-10-20, maintainer's call):** the page had become
  overwhelming, so The STORY Framework section moved to its own page
  (`story/`, navbar "STORY", section above), **the Barnum Test was retired
  from the grid** (the page stays live at its URL and Teaching ends on a
  muted "Also still live" line linking it, so nothing 404s and it is still
  usable in a class; `pics/thumb-barnum.jpg` is now unreferenced, like
  `thumb-formatpicker.jpg`), **The Usual Subjects was dropped** (it repeated
  the card tags), the hip-hop card lost its companion links (the periodic
  table's own header nav carries Dashboard and Codebook), the subtitle lost
  its planning-tools clause, and the Warm-Ups grid went back to the default
  three-column `.project-grid`, which fits the three remaining exercises on
  one row (the `--pairs` variant now has no user). On 2026-10-21 the How Old
  and Gut thumbnails went light to match the STORY cards (maintainer's call):
  each is a 1150x430 crop of the exercise's opening screen starting just
  below the white `#progress` strip (y = 156), so neither the ink header nor
  the strip's dark active step shows. `thumb-periodic.jpg` keeps its dark
  header on purpose, because the coloured tiles are the draw. The light Gut
  crop made the exercise's opening legible on the card, so its "No takebacks"
  line in `gut/app/_template.html` changed the same day (maintainer's pick,
  option C) to match the card: "a simple checklist makes the same ten calls,
  and you see where each one does better" (was "a checklist that uses exactly
  two facts makes the same ten calls, and we compare scores"). Retake that
  thumbnail if the intro changes again. **Two-part card tags** ("Planning
  Tool · Data Storytelling") are marked up as `<span>A</span>&nbsp;·
  <span>B</span>` inside `.project-card-tag`, with the halves `nowrap`
  (site-theme.scss, 2026-10-21), so a tag that cannot fit breaks only after
  the dot, never mid-phrase or with a line opening on "·"; below 700px the tag
  drops to the brand's 11px / 0.08em floor, which fits every STORY and
  Teaching tag on one line at 390px. The Projects tags are longer and still
  take two lines, now split cleanly at the dot. A new two-part tag needs the
  same markup. Teaching is one section:
  Warm-Ups (`01 · short exercises`). The notes below describe the page as it
  was before the split and stay as history.
  **Teaching refinement (2026-09-29, every string maintainer-picked):**
  section 02 is now **The STORY Framework** (was Storyboards; label and anchor
  unchanged), its intro names the five elements and says the evaluation picker
  comes first "because a story needs findings before it can be told" (the
  picker is not itself a STORY element, so keep that framing if the section
  changes). New subtitle: "Each exercise asks for a quick judgment and then
  shows what shaped it; the planning tools work through an evaluation or report
  of your own." The How Old card used to promise a comparison with "everyone
  else's" answers the page never makes (it compares your four lines with each
  other and with the law); read a tool before describing it on a card. The
  Usual Subjects gained Program evaluation and Data storytelling, matching the
  planning tools. Every Teaching card now has a
  `pics/thumb-<name>.jpg` header thumbnail (periodic, barnum, howold, gut,
  evalpicker, datastory), and the card links use `.project-card-cta` /
  `.project-card-companion` (site-theme.scss) instead of inline styles.
  Every standalone tool's top bar is a `.top-links` nav: "← datawithaplot.org"
  plus a "Teaching" link, each padded to 44px, with a coral focus ring
  (the default ring is invisible on ink). Barnum, How Old and Gut end on "More
  exercises →" to Teaching (they pointed at Projects after the pages moved).
  The periodic table's tiles are `role="button"` with `tabindex` and an
  aria-label, open on Enter/Space, the modal is a `role="dialog"` that closes on
  Escape and returns focus to the tile; filtered-out tiles leave the tab order.
  Its header nav reads Home / Teaching / Dashboard / Codebook ("Teaching
  Dashboard" beside "Teaching" read as a repeat), and a mono hint, "Swipe the
  table to see every era." (maintainer-picked to mirror The Plot So Far's
  chart hints), sits above the grid only while `updateSwipeHint()` finds it
  wider than its box, so desktop widths never see it.
  How Old Is Old? and Counted
  Wrong now link to each other: the howold link was deferred while the essay
  was still coming, so #48 corrected only its tense and #51 added the link once
  the essay was live. The link sits in howold's reveal (`#screen-2`), which is
  `display:none` until the exercise is done, so drive the sliders and both
  buttons to see it.
  **Projects regroup (2026-09-27, maintainer-picked)**: the three project
  cards used to sit under the page's only heading, "The Method", so they read
  as part of it. The work now comes first under **The Work** (`01 · projects`,
  `#the-work`), with The Method after it (`02 · how I work`, `#the-method`),
  both as raw `<h2 class="section-heading" data-eyebrow=...>` inside the page's
  single `{=html}` block. The tech chips (R / Quarto, HTML / JS, Excel /
  readxl) were dropped here too, matching Teaching; the topic chips stay. The
  Hip-Hop card's jargon sentence became "Built to teach what goes into a score
  and what can quietly bend it, using a subject people genuinely argue about"
  (her pick), and its chips are Interactive plus Measurement.
  No coming-soon project card remains: "A Right That Exists on Paper"
  (`compassionaterelease/`, bullet below) shipped 2026-07-19 (#74) and retired
  the last one, so `projects/index.qmd` has three live cards (the periodic
  table, Maturity Gap, and the compassionate release story; an earlier note
  here said four, which was never true on main).
  **Projects refinement (2026-09-30, every string maintainer-picked):** new
  subtitle ("...each built around a real measurement question; the exercises
  and planning tools live on the Teaching page"), tightened Maturity Gap and
  compassionate release card descriptions (both claims checked against their
  pages), chips say "and" not "&" (the area-label rule, applied to chips), and
  "More projects in progress." became "Work in progress is listed on the
  Writing page." linking `#in-the-works`. All three cards carry header
  thumbnails (`thumb-periodic`, `thumb-maturitygap` retaken with the current
  navbar, new `thumb-compassionaterelease`), links use `.project-card-cta`,
  and `.project-card-meta + .project-card-cta` replaces the old `<br>` spacer.
  `.project-card-desc` stepped up from 0.75rem to 0.9rem below 700px, sitewide
  (and at every width since 2026-10-23).
- **A Right That Exists on Paper (`compassionaterelease/`; shipped 2026-07-19
  in #74, review pass 2026-07-19, sources-and-voice pass 2026-07-21).** Chart-forward data story on compassionate
  release, the qualitative-data sibling of Maturity Gap on the same machinery:
  `index.qmd` with `ggplotly_titled()`, `legend_below()`, `stopifnot` guards
  over every CSV, `_metadata.yml` freeze: false, `_freeze/compassionaterelease/`
  gitignored. Public documents only (USSC Compassionate Release Data Reports,
  FY2025 full year tables 1/10/11 plus FY2026 Q2 table 1; Holland et al. 2020
  *OMEGA* and 2021 *Mortality*;
  Wisconsin's own statutes, rule, forms, and policy); every CSV row carries
  `source` + `source_detail` and the guard refuses to render without them.
  A linked "Data Sources" section leads the page, directly after the intro
  (maintainer's call: the public sources are part of the showcase; verify
  every link live before shipping), and the closing boundaries paragraphs
  live at the end of "What This Cannot Tell You". Visual pass 2026-07-21
  (maintainer-picked): Data Sources renders as a `.source-grid` of four
  cards with `.chip-link` buttons (styles in site-theme.scss next to the
  chart-card family; the Wisconsin card's eyebrow dot is the palette's one
  coral outlier), each chart card opens with a mono `chart-card-tag`
  ("Exhibit 01 · Lollipop" through "Exhibit 09 · Vertical Timeline"), the
  codebook table folds behind `<details class="codebook-fold">`, one
  canonical section divider sits before What This Cannot Tell You, and a
  page-scoped rule renders the "Why this chart:" strong leads as mono-caps
  labels (page-scoped so countedwrong and selected-work stay untouched).
  Ten exhibits, one form each: lollipop, icon array, span, dot plot,
  nested-bar funnel, stat tiles, part-in-whole monthly bars, faceted bars,
  codebook table, vertical timeline. The review pass (maintainer: "too many
  dumb bells") cut
  the dot-on-a-stick forms from three to two, requirements became the icon
  array, and the Wisconsin timeline went vertical because its labels are
  phrases and phrases need horizontal room; keep one lollipop and one span,
  no more (the terminal dot plot deliberately has no stems, because stems
  would make it a second lollipop). **`anchor_text()` exists because ggplotly drops a constant `hjust`
  on `geom_text`** (textposition comes back null, so plotly centers every
  label on its anchor; that was the timeline's label collision and it also
  put the funnel's dark-bar label on the bar). Pipe any chart whose geom_text
  sets hjust through it; the same drop hits `annotate("text", hjust = ...)`.
  Facet tick labels that must survive 280px phone panels are bare numbers
  with the unit in the axis title (the reasons chart). Phone pass 2026-10-26
  (maintainer's picks A throughout): the lollipop's counts ride on the dot
  trace (the Maturity Gap dot plot's fix; a nudge sat on the dots), its axis
  is "States" and "Medical clemency or pardon" wraps; the monthly bars tick
  bare years; the reasons chart wraps theme names over 17 characters, is 5.0
  tall, takes a 36pt panel gap and titles its axis "Percent of reasons"; the
  Wisconsin timeline wraps events at 18 (14 stacked labels into each other).
  `legend_below()` in both data stories now sets `xanchor = "left"`: ggplotly
  left it centered, so `x = 0` hung half the legend off the plot's left edge
  and plotly widened the left margin about 90px to hold it, which is what
  clipped the timeline's labels (and cost Maturity Gap's sexes chart 42px).
  The reason themes are
  the maintainer's own coding over the Commission's codes and the codebook
  table is the contract: change one, change both. Quarterly USSC update =
  extend the open fiscal year's rows in `federal_motions_monthly.csv` from the
  latest quarterly report (closed fiscal years stay on their final full-year
  report; USSC removes superseded quarterlies from its landing page but the
  PDFs survive at their URLs), swap `federal_reasons.csv` to the new full-year
  tables 10/11 when a year closes, then the stopifnot sums and the totals in
  the notes prose. The state layer is
  Holland's 2016 coding, a decade old, and the page says so; re-coding from
  current statutes is the named next piece of work. Step one landed 2026-08:
  `data/state_statutes.csv` is the maintainer's own fifty-state statutory
  review (Wylie, Knutson, and Greene 2018, *Psychology, Public Policy, and
  Law* 24(2), table 1, pp. 220-224; a Data Sources card since #102),
  transcribed cell by cell from the PDF in her Google Drive (apa.org and
  doi.org are egress-blocked in CCR sessions, so Drive is the route to the
  article). 58 rows: 52 compassionate release statutes across 46
  jurisdictions (CA, DC, LA, MD, NY, OK carry two each), 2 temporary-release
  rows (AZ, SD), 4 None rows (IL, IA, MA, UT). Loaded and guarded in the
  setup chunk. Two exhibits read it since 2026-08 (maintainer's picks): the
  age span (Exhibit 03, per-statute rows, 12 statutes, 45 to 70, four
  joined pairs where the age depends on the sentence) and the
  terminal-window dot plot (Exhibit 04, How Long Is Terminal, 15 statutes,
  30 days to 2 years, exhibits 05-10 renumbered to make room). Holland's
  age CSV stays loaded and guarded as the policy-level reference, but no
  chart reads it now. Whether more exhibits move from Holland's policy
  coding to this statute coding stays the maintainer's call.
  The guards assert the printed table, which differs from the article's own
  prose on four counts (chronic 40 in the table, 39 in prose; murder 6 vs 7;
  death/life 19 vs 20; time 15 vs 14); the table wins, verified against the
  PDF text layer. Transcription is faithful to print including its quirks
  (both California rows numbered "(CA) 2", "Government Code if Counties",
  Maine's "MURDERSA" for what is evidently M.R.S.A.); correct those only on
  the maintainer's say-so. Note for future exhibits: a Wylie-coded age span
  runs 45 (LA) to 70 (SC, federal), not Holland's 55 to 70, because statutes
  and department policies genuinely differ.
- The three pickers' results-bar hint says **"Tap or click"** ("Tap or click any card for the full picture.", "...any format for the detail.", "...any display for the detail."; 2026-10-23, maintainer's pick A), because most visitors arrive on a phone. Each lives in its workbook's Copy sheet (`modal_hint` in qualpicker); keep the three in step.
- **How Old Is Old? phone pass (2026-10-23, maintainer's picks A and A).** Both
  number lines were 620px (`.tl { min-width }`) in a ~340px box. "Your Four
  Lines" (screen 2) had no hint and showed one of four dots; it now takes
  `.tl-fit` (min-width 0, same 30-to-100 scale) and `layoutLabels()` places the
  labels from their measured widths: centred on the dot, clamped to the track's
  padding, stacked on the lowest clear row, and re-run on resize. That needs
  the screen visible, so `go-yardstick` and `go-law` now call `showScreen()`
  before building. The law's lines (screen 3) keep scrolling, with their hint,
  but `scrollToYou()` opens them centred on your lines (or at the lowest when
  they span wider than the box) instead of on 15 to 60. Labels, ticks, step
  numbers and `.l-cat` went to 0.7rem (11.2px), the brand floor.
- **Trust Your Gut? is now "Who Comes Back to Court?"** (2026-10-24,
  maintainer's pick B: she had forgotten what the old name meant, and with
  "Gut" in coral it read as "your instinct is about to lose", the reading the
  2026-10-21 audit took off the card). The `<title>`, the header `<h1>`
  (`Who Comes <span>Back</span> to Court?`, balanced), the Teaching card title
  and CTA ("Try Who Comes Back to Court? →", the How Old CTA's shape), and
  the Writing page's companion line all moved; the folder, file name
  (`gut/trust_your_gut.html`) and `thumb-gut.jpg` stay, so no link breaks, and
  older notes in this file that say "Trust Your Gut?" or "Gut" mean this page.
  The essay "Trust the Checklist" keeps its title. Phone pass the same day
  (pick A): a file is taller than a phone, so below 600px `.callrow` is sticky
  at the bottom, the two calls side by side and the same size ("Will return"
  had been nearer to hand than "Will miss" on every file, which can nudge the
  answers), and the next file scrolls to its "File N of 10" line, not the page
  top. Small labels went to 0.7rem (11.2px).
  Score-screen copy audited the same day under the humor rule (maintainer
  picked from offered options): the losing punch line ends "which is the usual
  result: across decades of studies, simple rules match or beat expert
  judgment most of the time" (was "Don't take it personally: it beats almost
  everyone"), the winning one "That happens, and on another stack it might
  not; over many files, the checklist tends to come out ahead" (was "Enjoy
  it: run enough stacks, and the checklist wins"), the heading is "Why Two
  Facts Go So Far" (was "Why the Checklist Wins"), the checklist "weighs them
  the same way on every file, whether it is the first of the morning or the
  tenth" (was "...never gives one extra chance because someone brought their
  mom"), and the Teaching Prompt's lesson is "building the checklist,
  auditing it, and studying the cases it gets wrong, which puts expertise to
  better use than second-guessing it file by file" (was "...not overriding it
  one charming file at a time"). Visitors here are often pretrial staff.
  A repetition pass followed (maintainer's picks A, A, B, A, A): the intro
  headline is "Ten people, ten court dates." (was "Ten files. Who comes back?",
  a near-repeat of the new title; `thumb-gut.jpg` was retaken because the crop
  shows it); the Meehl paragraph no longer restates the research claim the
  score line now carries ("...and the rules held up in comparison after
  comparison... reached the same conclusion, in medicine, education, and
  courtrooms alike"; "This fight is old" and "the rules kept winning" went
  with it); the Teaching Prompt opens "Judgment is not worthless: someone had
  to pick the two variables" and ends at "the rule is the better bet" (no
  second "studying" clause, no "tired by the tenth file"); the Dawes source
  note ends at "...outperform the experts who built them" (its "because they
  never get tired, bored, or charmed" echoed the removed digs); and the
  Jasmine K. note reads "...easy for the rule, and cases like this are where
  false confidence comes from" (it used "the gut" twice). The last two are
  workbook cells (Research and Cases sheets).
- Standalone-template footers follow the column above them (2026-09-27):
  intro and plan screens use the 760px `.wrap` while the footer was sized for
  the tool screen (1000-1100px), so its text sat 120-170px left of the content.
  A `body:has(#screen-intro.active...) footer { max-width: 760px }` rule in
  evalpicker, formatpicker and datastory fixes it, and the phone query gives
  `footer` the same 1rem gutter as `main`. A new standalone page with screens of
  different widths needs the same rule.
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
  page's own header, so after any chrome change regenerate the live homepage
  thumbnails from the published pages (a follow-up PR, because the new header
  must deploy first). Since the 2026-07-21 declutter that is just
  `thumb-periodic.jpg` and `thumb-maturitygap.jpg`, plus the six Teaching card
  thumbnails since 2026-09-29 (barnum, howold, gut, evalpicker, datastory, and
  periodic again). The STORY navbar entry (2026-10-20) was such a chrome
  change: `thumb-maturitygap.jpg` and `thumb-compassionaterelease.jpg` are
  page-top screenshots that showed the navbar without STORY, so both were
  retaken 2026-10-21 from the published `gh-pages` pages (1150x430 viewport
  at the top of the page, JPEG q88). Adding or renaming a navbar entry
  re-stales them. Headless Chromium in CCR only loads Spectral and JetBrains
  Mono when launched with `proxy: { server: process.env.HTTPS_PROXY }`;
  without it the fonts silently fall back and the thumbnail is wrong.
  The homepage "Start Here" grid (headed "Featured Projects" until the July
  2026 naming pass) featured the periodic table, both pickers, and Maturity
  Gap until the **2026-07-21 homepage declutter** cut it to the two signature
  pieces, **the periodic table and Maturity Gap only**. Both picker cards were
  dropped (they live on Teaching); the two survivors lost their meta chips and
  duplicate bottom link, with the title now carrying the link
  (`.project-card-title a`, styled to read as the heading); the four repeated
  arc-and-scatter dividers collapsed to one signature mark; and **The Method**
  moved off the homepage to the Projects page as a condensed band (#88-91 era).
  Do not re-add the picker cards here: Start Here is deliberately the two
  signature pieces now. With both pickers gone from the homepage,
  `thumb-formatpicker.jpg` is no longer referenced anywhere
  (`thumb-evalpicker.jpg` is back in use on its Teaching card). Barnum belongs to Teaching too (14e5a48).
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
  what hit the dumbbell and stacked-area charts on first render. Since
  2026-07-21 `ggplotly_titled()` (both copies: here and compassionaterelease)
  also pipes every chart through `config(responsive = TRUE)` plus an
  `htmlwidgets::onRender` ResizeObserver calling `Plotly.Plots.resize`:
  plotly draws at a fixed 700px when its container has no width at draw time
  (a background tab), never re-draws without a window resize, and the
  `.chart-card` overflow: hidden then crops the right edge.
  Since 2026-09-30 the same `onRender` also runs `fit()`: plotly never wraps
  a title, and ggplotly anchors it to the plotting area (`xref: paper`, after
  the y-axis label margin), so on a phone every folded title and subtitle ran
  100-550px off the card and was cropped ("Old enough at"), and a few long
  ones clipped at desktop width too. `fit()` anchors the title to the whole
  chart (`xref`/`yref: container`), wraps title and subtitle to the chart's
  width with canvas text measurement, then measures the drawn title and grows
  `margin.t` and the chart's height together so the plot keeps its height.
  It only acts on titles of the exact `<b>...</b><br><sup>...</sup>` shape
  the helper builds. Verify it without R by injecting the JS into the
  published `gh-pages` pages (`git fetch origin gh-pages`, open the files via
  `file://`; datawithaplot.org itself is egress-blocked in CCR, and the proxy
  answers localhost with 405) and checking every `.gtitle` box sits inside its
  `.chart-card`. Since 2026-10-24 both copies also pass `displayModeBar =
  FALSE` to `config()`: on a touch screen plotly shows its toolbar all the
  time (no hover state), and it sat on top of every folded title, on all ten
  Maturity Gap charts and all eight compassionate release ones. The same phone
  pass (maintainer's defaults) gave the overrepresentation dot plot short row
  labels ("Population", "All arrests", "Sentenced prisoners", "State prison
  releases"; the long "Share of ..." forms crowded the plot to about a third of
  a phone's width), and its % labels ride on the dot trace (`mode`
  "markers+text", `textposition` "middle right", hover moved to `hovertext`)
  so plotly sets them beside the marker at any width; a `geom_text` nudge is a
  fixed data distance and still sat on the dots on a phone (#158 tried 0.03),
  and the axis runs 0 to 44% with ticks every 20% so 29% fits. It turned the
  capacities slope chart into a 2x2 grid (`nrow = 2`, fig-height 5.6, like the
  four-measures chart; at `nrow = 1` the panel titles printed over each other
  on a phone), with a labeller wrapping "Consideration of Others"; both faceted
  charts tick 14, 18, 24 and take a wider `panel.spacing.x` (40pt and 28pt),
  because neighbouring panels' 24 and 14 ran together as "2414". It also
  shortened the dumbbell's x title to "Percent rearrested". The sources
  section is headed "Data Sources" (renamed from "Where the Numbers Come
  From" 2026-07-21, matching compassionaterelease). Voice of
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
  screenshot, JPEG q85, 87 KB); its description opens with the page
  subtitle (maintainer-picked 2026-08-20, replacing a leftover "one chart
  at a time", the phrase her subtitle review had already rejected as
  verging on snarky). The close still links How Old Is Old? and the
  phrase "count some people wrong" stays as the echo of the old name.
- **Homepage phone pass (2026-09-27, maintainer-picked).** The bio avatar is
  `pics/headshot-420.jpg` (420x576, ~39 KB, no metadata). The original
  `pics/Headshot1.jpg` was a 949 KB 2787x3824 phone photo shown at 140px, and
  its EXIF carried **GPS coordinates**, served publicly until this pass.
  Below 768px, where the bio stacks into one column, the avatar is centred
  (`align-self: center`, 2026-10-22, maintainer's call) while the bio text
  stays left-aligned. Any
  photo added to the site must be resized and stripped of EXIF first (Pillow:
  `ImageOps.exif_transpose`, resize, save without `exif=`); a quick scan of
  every JPEG for a GPS IFD with lat/long takes seconds. The Hip-Hop card is
  **"The Hip-Hop Periodic Table"** on the homepage, Teaching and Projects alike
  (it was three different names), and the homepage description matches
  Projects' plain wording. `.project-card-thumb img` takes the screenshot's own
  1150/430 proportions at every width (2026-10-23; a fixed 150px height, with a
  below-700px exception, until then), because the fixed height cropped the
  sides of narrow cards (phones, and every three-up grid: "aturity Gap") and
  the top and bottom of wide ones (the homepage pair, once it went full width).
  **Homepage desktop pass (2026-10-23, maintainer-picked):** the "On this page"
  sidebar is gone (`toc: false`; it listed only two sections and pushed the
  page left of centre), so the homepage content is full width like the other
  section pages, and Start Here uses `.project-grid--pairs` so two cards never
  sit beside an empty third track. `.hero-section` has a 2.5rem bottom margin
  (the first eyebrow sat flush on the card), `.project-card-title a` inherits
  the title's 600 weight (it rendered at 400, lighter than every other card
  title), and `.project-card-desc` is 0.9rem at every width (it was 0.75rem,
  about 12.75px, on desktop). The same day
  `.project-grid`'s minimum dropped from 300px to 290px (maintainer's pick A):
  a `.container` row at 992-1199px is 936px wide, 12px short of three 300px
  cards, so Projects, Teaching, STORY and both Swag grids left one card alone on
  a second row at laptop and tablet-landscape widths. Portrait tablets
  (768-991px) still show two plus one, on purpose: three-up there is too narrow.
  **Card links share a line (2026-10-23, maintainer's pick B):** `.project-card`
  is a column flexbox, and `.project-card-cta` takes `margin-top: auto` so the
  "Read"/"Explore"/"Open" links in a row sit on the cards' shared bottom edge
  (Projects and Teaching; they had followed each description to a different
  height). Two details came with it. A grid holding a `.project-card-companion`
  opts out through `:has()`: STORY's worksheet card carries the companion line
  under its link, so pushing link and line to the bottom left that link a whole
  line above its neighbours, while unpushed the three sit within a few px.
  And as a flex item the tag lost the inline line box that had set a one-line
  tag about 5px lower, so `.project-card > .project-card-tag` takes a 0.3rem
  top margin to restore it; tags now sit at one height across a row, where a
  two-line tag used to sit 5px above its one-line neighbours. The chip-row gap
  above Projects' links (`.project-card-meta + .project-card-cta`) is padding,
  not margin, so the auto margin still applies.
  **Teaching desktop pass (2026-10-23, maintainer's picks B and B):** the
  Warm-Ups grid and the "Also still live" line dropped their `container`
  class, so they share the markdown heading's left edge instead of sitting 12px
  inside it (Bootstrap's container padding). STORY had the same 12px offset
  (its band and grid were containers under a markdown heading) and got the
  same fix in the same PR (maintainer's pick B): the band's wrapper and the
  grid dropped `container`, so both now span the heading's width. Both pages' section intros sit in a
  `::: {.section-intro}` div, capped at 760px (about 100 characters a line,
  down from about 150).
- Every page with `title: ""` (the section indexes draw their own
  `.page-header`, so they all use it) also needs a `pagetitle:` in its front
  matter, or Quarto titles the browser tab and og:title from the filename:
  five pages shipped as "index – Data with a Plot" until 2026-08-19. Quarto
  appends "– Data with a Plot" to `pagetitle` itself, so the value is just the
  page name ("Projects", "The Plot So Far"). The homepage also carries the
  og-image tagline as its `description` so link previews have an og:description.
- `CV/Wylie_Capacity_Dashboard.qmd` is private: gitignored and excluded from
  rendering. Keep it and `_freeze/CV/` out of the public site.
- `_freeze/` is tracked except `_freeze/hiphop/` and `_freeze/countedwrong/`
  (both ignored; freeze disabled for both).
