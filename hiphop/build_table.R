# build_table.R ───────────────────────────────────────────────────────────────
# Generates hiphop/hiphop_periodic_table.html from the editable Excel file.
#
# To update the periodic table: edit hiphop/data/hiphop_artists.xlsx (the
# "Artist Database" sheet), then re-publish. This script is wired into
# _quarto.yml as a pre-render step, so `quarto render` / `quarto publish`
# regenerates the table automatically. The branded look/feel lives in
# hiphop/table/_template.html; only the data comes from Excel.

suppressMessages({
  library(readxl)
  library(jsonlite)
})

# Quarto runs pre-render scripts from the project root; allow running from the
# hiphop/ directory too. Anchor every path on where the data file is found.
base <- if (file.exists("hiphop/data/hiphop_artists.xlsx")) "hiphop" else "."
xlsx_path     <- file.path(base, "data", "hiphop_artists.xlsx")
template_path <- file.path(base, "table", "_template.html")
out_path      <- file.path(base, "hiphop_periodic_table.html")

df <- read_excel(xlsx_path, sheet = "Artist Database")

# Match the original embedded snapshot: blank (not null) for empty text fields.
for (col in names(df)) {
  if (is.character(df[[col]])) df[[col]][is.na(df[[col]])] <- ""
}

json <- toJSON(df, dataframe = "rows", auto_unbox = TRUE, na = "null")

template <- paste(readLines(template_path, warn = FALSE, encoding = "UTF-8"),
                  collapse = "\n")
parts <- strsplit(template, "__RAW_DATA__", fixed = TRUE)[[1]]
if (length(parts) != 2L) {
  stop("Expected exactly one __RAW_DATA__ placeholder in ", template_path)
}

con <- file(out_path, open = "w", encoding = "UTF-8")
writeLines(paste0(parts[1], json, parts[2]), con, useBytes = FALSE)
close(con)

cat("build_table.R: wrote", out_path, "with", nrow(df), "artists\n")
