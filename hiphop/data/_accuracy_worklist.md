# Hip-Hop Periodic Table — Worklist

`hiphop/data/hiphop_artists.xlsx`. **173 acts** = 130 Elements + 43 Compounds.
(Underscore-prefixed so Quarto does not publish this internal doc.)

## Visual encoding (current)

- **Color = style** (soft semantic hues) · Row = era · **Shape = region** · Shape color = confidence · Number+bar = composite

## Done

- [x] Accuracy phase (L/M factual + score nits, web-verified)
- [x] Philly region; region = label/scene rule; dedup (JID/Noname/Ghostface)
- [x] Expansion batch 1 (+18); removed Intl/UK (US scene+label scope)
- [x] Compounds table (27 groups) vs Elements (120 solo); J.J. Fad reclassified Element→Compound (trio, consistent with City Girls)
- [x] Style-as-shape glyph (8 shapes), merged Conscious/Street into Conscious/Lyrical
- [x] Stale-content sweep (2026-07): projects/teaching copy, dashboard gender list (+Da Brat, +Eve), bias-table Language row, dead REGION_COLORS, hardcoded 139s
- [x] Data Dictionary sheet + hiphop/data_dictionary.qmd (codebook page)
- [x] Cleanup pass (2026-07): Gender column added to workbook (dashboard gender chart now data-driven, hardcoded list removed); Composite Score float artifacts normalized to 1 dp; dead template code removed (--uk/--intl vars, .tile-conf/.conf-* rules, 'Late 99s' checks, stale layout comments)
- [x] Expansion batch 2 (+16, gap-targeted, 2026-07): 7 women (Salt-N-Pepa, Megan Thee Stallion, Yo-Yo, Bahamadia, Jean Grae, Trina, Mia X — female elements now 24/132 = 18%); Midwest/Bay/South depth (Bone Thugs-N-Harmony, 8Ball & MJG, Souls of Mischief, Twista, Tech N9ne); prestige-bias cases (Nelly, Chief Keef); modern underground (Roc Marciano, Denzel Curry)
- [x] Region taxonomy rollup (2026-07): Region now East Coast (75) / West Coast (25) / South (41) / Midwest (22); old scene values preserved in new Scene column; modal shows "East Coast (NYC)" style detail; freeze disabled for hiphop/ so data-only Excel edits re-render the dashboard
- [x] Compounds expansion (+10 post-Golden-Age, 2026-07): Fugees, Goodie Mob, Company Flow, Clipse, dead prez, Little Brother, Atmosphere, Blackalicious, Brockhampton, Griselda; Whodini + Armand Hammer reclassified Element→Compound (trio/duo, J.J. Fad precedent); compounds by era now 6/18/6/7/3/3
- [x] Career dimension (2026-07): Signature Work ("Title (Year)") + Active Through columns for all 173 acts (101 active / 72 concluded; blank sig only Kool Herc); modal shows signature + active span; dashboard page 6 "Careers & Longevity" (survivorship prompt, career-length vs composite, years-to-peak distribution); Full Data Table renumbered to 7
- [x] Age dimension (2026-07): Birth Year column for all 130 Elements (Compounds blank by design; ages derive as debut-birth and sig_year-birth); modal debut line shows "(age N)"; Careers page adds age-at-debut-by-era boxplots and age-at-signature vs composite scatter
- [x] Dashboard subtitle fix (2026-07): ggplotly_titled() helper folds each ggplot subtitle into the plotly title as a `<br><sup>` line, all 15 ggplotly charts converted (subtitles were silently dropped, hiding the gender-count and median-signature-age stats)

## Region shapes

● East Coast · ★ West Coast · ▲ South · ■ Midwest
(Scene column keeps the finer NYC/Philly/LA/Bay Area detail)

## Style distribution

| Style | Count |
|---|---|
| Gangsta/Street | 47 |
| Conscious/Lyrical | 47 |
| Party/Pop | 26 |
| Experimental | 18 |
| Abstract | 13 |
| Political | 12 |
| Trap/Drill | 6 |
| Jazz-Rap | 4 |
