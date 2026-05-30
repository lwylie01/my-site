# Corrected File Structure

## What to do with these files

Place them in your project root exactly as organized here:

```
your-project/
│
├── _quarto.yml                  ← REPLACE with corrected version
├── site-theme.scss              ← NEW — was missing, caused build error
├── custom.scss                  ← keep as-is, used only by hiphop dashboard
├── index.qmd                   ← unchanged (root homepage)
│
├── projects/
│   └── index.qmd               ← RENAMED from projects_index.qmd
│
├── teaching/
│   └── index.qmd               ← RENAMED from teaching_index.qmd
│
├── writing/
│   └── index.qmd               ← RENAMED from writing_index.qmd
│
├── hiphop/
│   ├── hiphop_dashboard.qmd    ← MOVE here from root (add custom.scss to its YAML)
│   ├── hiphop_periodic_table.html
│   └── data/
│       └── hiphop_artists.xlsx
│
└── pics/
    └── logoW.png
```

## One manual step: hiphop_dashboard.qmd YAML

After moving `hiphop_dashboard.qmd` into the `hiphop/` subfolder,
make sure its front matter references `custom.scss` with the correct path:

```yaml
---
format:
  dashboard:
    theme:
      - cosmo
      - ../custom.scss   # ← one level up from hiphop/
---
```

## What was fixed

| Problem | Fix |
|---|---|
| `site-theme.scss` missing → build error | Created with all site component styles |
| Nav links broken (`projects/`, `teaching/`, `writing/`) | Files moved into matching subfolders |
| `custom.scss` was site-wide theme candidate | Clarified: scoped to dashboard only |
| `hiphop_dashboard.html` not listed in resources | Added to `_quarto.yml` resources |
