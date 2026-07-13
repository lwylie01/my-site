# build_howold.R ──────────────────────────────────────────────────────────────
# Generates howold/how_old_is_old.html from the editable Excel file.
#
# To update How Old Is Old?: edit howold/data/howold_items.xlsx — the
# "Prompts", "Legal Lines", and "Sources" sheets — then re-publish. This
# script is wired into _quarto.yml as a pre-render step, so `quarto render` /
# `quarto publish` regenerates the page automatically. The branded look/feel
# and the interaction logic live in howold/app/_template.html; only the data
# comes from Excel.

suppressMessages(library(readxl))

# Quarto runs pre-render scripts from the project root; allow running from the
# howold/ directory too. Anchor every path on where the data file is found.
base <- if (file.exists("howold/data/howold_items.xlsx")) "howold" else "."
xlsx_path     <- file.path(base, "data", "howold_items.xlsx")
template_path <- file.path(base, "app", "_template.html")
out_path      <- file.path(base, "how_old_is_old.html")

read_sheet <- function(sheet) {
  df <- read_excel(xlsx_path, sheet = sheet)
  for (col in names(df)) {
    if (is.character(df[[col]])) df[[col]][is.na(df[[col]])] <- ""
  }
  df
}

# Base-R JSON serialiser — no jsonlite dependency needed.
as_json <- function(df) {
  encode_val <- function(x) {
    if (is.na(x))                           return("null")
    if (is.numeric(x) || is.logical(x))    return(as.character(x))
    s <- as.character(x)
    s <- gsub("\\\\", "\\\\\\\\", s)
    s <- gsub('"',    '\\\\"',    s)
    s <- gsub("\n",   "\\\\n",    s)
    s <- gsub("\r",   "\\\\r",    s)
    paste0('"', s, '"')
  }
  row_obj <- function(i) {
    pairs <- mapply(
      function(nm, val) paste0('"', nm, '":', encode_val(val)),
      names(df),
      lapply(df, `[[`, i),
      SIMPLIFY = TRUE
    )
    paste0("{", paste(pairs, collapse = ","), "}")
  }
  rows <- vapply(seq_len(nrow(df)), row_obj, character(1))
  paste0("[", paste(rows, collapse = ","), "]")
}

prompts <- read_sheet("Prompts")
lines   <- read_sheet("Legal Lines")
sources <- read_sheet("Sources")

template <- paste(readLines(template_path, warn = FALSE, encoding = "UTF-8"),
                  collapse = "\n")

inject <- function(tpl, placeholder, json) {
  parts <- strsplit(tpl, placeholder, fixed = TRUE)[[1]]
  if (length(parts) != 2L) {
    stop("Expected exactly one ", placeholder, " placeholder in ", template_path)
  }
  paste0(parts[1], json, parts[2])
}

template <- inject(template, "__PROMPTS_DATA__", as_json(prompts))
template <- inject(template, "__LINES_DATA__",   as_json(lines))
template <- inject(template, "__SOURCES_DATA__", as_json(sources))

con <- file(out_path, open = "w", encoding = "UTF-8")
writeLines(template, con, useBytes = FALSE)
close(con)

cat("build_howold.R: wrote", out_path, "with", nrow(prompts), "prompts and",
    nrow(lines), "legal lines\n")
