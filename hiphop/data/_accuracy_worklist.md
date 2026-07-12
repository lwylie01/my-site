# Hip-Hop Periodic Table — Worklist

`hiphop/data/hiphop_artists.xlsx`. **173 acts** = 129 Elements + 44 Compounds.
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
- [x] Era operationalized (2026-07): Era is now derived, the bracket holding the Signature Work year (Debut Year only for Kool Herc), with brackets Old School through 1985 / Golden Age 1986-1994 / Late 90s 1995-1999 / then calendar decades; 46 acts recoded (Raekwon 2000s→Late 90s was the tell), Data Dictionary Era row rewritten to the derived rule; distribution now OS 9 / GA 41 / L90s 33 / 2000s 34 / 2010s 41 / 2020s 15 (Elements 7/22/22/29/36/14, Compounds 2/19/11/5/5/1)
- [x] Signature Work operationalized (2026-07): dictionary row now pins the candidate pool (own-catalog studio projects, canonical mixtapes count, singles only where no album exists, side-group releases count only when the group has no row of its own), the consensus sources, and the original-release-year convention; genuine splits resolved by maintainer call. Audit of all 173 picks (27 flagged, web-verified): 10 changed — Talib Kweli→Black Star (1998), Twista→Adrenaline Rush (1997), Lil Uzi Vert→Luv Is Rage 2 (2017), Polo G→Die a Legend (2019), Lupe Fiasco→Lupe Fiasco's Food & Liquor (2006), A$AP Rocky→Live. Love. A$AP (2011), Salt-N-Pepa→Hot, Cool & Vicious (1986), Rod Wave→Pray 4 Love (2020), Del→Deltron 3030 (2000), Common→Resurrection (1994); 7 splits resolved keep (2Pac, Busta, Royce, 8Ball & MJG, Roc Marciano, Little Brother, Xzibit); Era re-derived (6 moves; now OS 9 / GA 41 / L90s 35 / 2000s 32 / 2010s 43 / 2020s 13); median sig age 26→25
- [x] Jedi Mind Tricks reclassified Element→Compound (2026-07): MC+producer duo per Gang Starr/Atmosphere precedent; now 129 Elements + 44 Compounds; female elements 24/129 (19%); Birth Year blanked per Compound rule
- [x] Cross-navigation + contested calls (2026-07): table header now links Home / Teaching Dashboard / Codebook; dashboard nav-buttons add house + Periodic Table + Codebook; codebook page adds a Contested Calls section logging the 8 split rulings and its scope-rules era bullet now states the derived signature-year bracket (was still describing the old judgment rule)

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
