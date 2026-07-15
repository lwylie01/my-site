# build_gut.R ─────────────────────────────────────────────────────────────────
# Generates gut/trust_your_gut.html from the editable Excel file.
#
# To update Trust Your Gut?: edit gut/data/gut_cases.xlsx — the "Cases",
# "Rule", "Research", and "Method" sheets — then re-publish. This script is
# wired into _quarto.yml as a pre-render step, so `quarto render` /
# `quarto publish` regenerates the page automatically. The branded look/feel
# and the interaction logic live in gut/app/_template.html; only the data
# comes from Excel.

suppressMessages(library(readxl))

# Quarto runs pre-render scripts from the project root; allow running from the
# gut/ directory too. Anchor every path on where the data file is found.
base <- if (file.exists("gut/data/gut_cases.xlsx")) "gut" else "."
xlsx_path     <- file.path(base, "data", "gut_cases.xlsx")
template_path <- file.path(base, "app", "_template.html")
out_path      <- file.path(base, "trust_your_gut.html")

read_sheet <- function(sheet) {
  df <- read_excel(xlsx_path, sheet = sheet)
  for (col in names(df)) {
    if (is.character(df[[col]])) df[[col]][is.na(df[[col]])] <- ""
  }
  df
}

# Base-R JSON serialiser — no jsonlite dependency needed. The output is injected
# as a JS literal rather than parsed, so anything that is not valid JSON throws
# and takes the rest of the script block with it: booleans must be lowercase,
# and Inf has no JSON spelling, so it joins NA and NaN as null.
as_json <- function(df) {
  encode_val <- function(x) {
    if (is.na(x))      return("null")
    if (is.logical(x)) return(if (x) "true" else "false")
    if (is.numeric(x)) return(if (is.finite(x)) as.character(x) else "null")
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

cases    <- read_sheet("Cases")
rule     <- read_sheet("Rule")
research <- read_sheet("Research")
method   <- read_sheet("Method")

template <- paste(readLines(template_path, warn = FALSE, encoding = "UTF-8"),
                  collapse = "\n")

inject <- function(tpl, placeholder, json) {
  parts <- strsplit(tpl, placeholder, fixed = TRUE)[[1]]
  if (length(parts) != 2L) {
    stop("Expected exactly one ", placeholder, " placeholder in ", template_path)
  }
  paste0(parts[1], json, parts[2])
}

template <- inject(template, "__CASES_DATA__",    as_json(cases))
template <- inject(template, "__RULE_DATA__",     as_json(rule))
template <- inject(template, "__RESEARCH_DATA__", as_json(research))
template <- inject(template, "__METHOD_DATA__",   as_json(method))

con <- file(out_path, open = "w", encoding = "UTF-8")
writeLines(template, con, useBytes = FALSE)
close(con)

cat("build_gut.R: wrote", out_path, "with", nrow(cases), "case files\n")
