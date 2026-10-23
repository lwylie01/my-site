# build_qual.R ────────────────────────────────────────────────────────────────
# Generates qualpicker/qual_picker.html from the editable Excel file.
#
# To update the picker: edit qualpicker/data/qualitative_displays.xlsx — the
# "Rules", "Levels", "Displays" and "Copy" sheets — then re-publish. This script
# is wired into _quarto.yml as a pre-render step, so `quarto render` /
# `quarto publish` regenerates the page automatically. The branded look/feel and
# the matching logic live in qualpicker/app/_template.html; only the data and
# the eligibility rules come from Excel.
#
# Same shape as formatpicker/build_format.R (itself a cut-down build_eval.R):
# one kind of item, no prerequisites. Two things are new. The units axis feeds
# two rules with opposite fail classes (too few cases is Capacity, too many is
# Intent), like the evaluation picker's maturity axis, so the validator must
# accept two Rules rows on one axis. And each display may carry a "see it in
# use" link to a live exhibit on this site, which the template builds into an
# <a>, so the URL is validated here: relative to the site or https only.
#
# The validator below is not optional. The whole design bets on rules authored
# in a spreadsheet, so a trailing space or a near-miss value would otherwise
# produce a silently wrong verdict about which figure to draw. Every check
# fails loud, naming the sheet, the row, and the valid values.

suppressMessages(library(readxl))

# Quarto runs pre-render scripts from the project root; allow running from the
# qualpicker/ directory too. Anchor every path on where the data file is found.
base <- if (file.exists("qualpicker/data/qualitative_displays.xlsx")) "qualpicker" else "."
xlsx_path     <- file.path(base, "data", "qualitative_displays.xlsx")
template_path <- file.path(base, "app", "_template.html")
out_path      <- file.path(base, "qual_picker.html")

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

rules     <- read_sheet("Rules")
levels_df <- read_sheet("Levels")
displays  <- read_sheet("Displays")
copy_df   <- read_sheet("Copy")

# ── Validation ────────────────────────────────────────────────────────────────
# A blank cell means "this does not constrain me", so blank always passes.
blank <- function(x) is.na(x) || !nzchar(trimws(as.character(x)))
txt   <- function(x) trimws(as.character(x))

# 1. ids unique and non-blank across Displays
all_ids <- txt(displays$id)
if (any(vapply(all_ids, blank, logical(1)))) {
  stop("Blank id in Displays. Every row needs an id.")
}
if (anyDuplicated(all_ids)) {
  stop("Duplicate id(s) in Displays: ",
       paste(unique(all_ids[duplicated(all_ids)]), collapse = ", "))
}

# 2. every rule cell resolves to a Levels value for its axis
check_levels <- function(df, sheet, rule) {
  valid <- txt(levels_df$level_value[txt(levels_df$axis) == rule$axis])
  for (i in seq_len(nrow(df))) {
    raw <- df[[rule$rule_column]][i]
    if (blank(raw)) next
    vals <- if (rule$rule_kind == "in-list") {
      trimws(strsplit(txt(raw), ";")[[1]])
    } else {
      txt(raw)
    }
    vals <- vals[nzchar(vals)]
    bad <- setdiff(vals, valid)
    if (length(bad)) {
      stop(sheet, " row ", i, " (id ", df$id[i], "): column '", rule$rule_column,
           "' has value(s) that are not in the Levels sheet for axis '",
           rule$axis, "': ", paste(bad, collapse = ", "),
           "\n  Valid here: ", paste(valid, collapse = " | "))
    }
  }
}

for (r in seq_len(nrow(rules))) {
  rule <- as.list(rules[r, ])
  if (!rule$rule_column %in% names(displays)) {
    stop("Displays is missing the column '", rule$rule_column,
         "' required by the Rules sheet.")
  }
  check_levels(displays, "Displays", rule)
}

# 3. Levels needs a numeric order on every row (a blank one becomes JSON null
#    and the ordered comparisons then misbehave silently)
if (any(is.na(levels_df$order))) {
  stop("Levels sheet: every row needs a numeric 'order'.")
}

# 4. axis_label consistent for rows sharing an axis
for (ax in unique(txt(rules$axis))) {
  labs <- unique(txt(rules$axis_label[txt(rules$axis) == ax]))
  if (length(labs) > 1) {
    stop("Rules sheet: axis '", ax, "' has conflicting axis_label values: ",
         paste(labs, collapse = " | "))
  }
}

# 5. Copy needs a reason template per rule, and a short form of it. The long
#    reason is the sentence in the modal; the short one is the tag on the card.
rule_keys <- c(paste0("reason_", txt(rules$rule_column)),
               paste0("short_",  txt(rules$rule_column)))
missing <- setdiff(rule_keys, txt(copy_df$key))
if (length(missing)) {
  stop("Copy sheet is missing key(s): ", paste(missing, collapse = ", "))
}

# 5b. every other Copy key the template names must resolve too. t() falls back to
#     a literal "[key_name]" rather than throwing, so any typo, or any key renamed
#     in the sheet but not the template, would ship "[heading_fits]" to the page
#     and nothing would fail. The template is scanned for the shapes that reach
#     t(): a direct t('key') and the setText('id', 'key') init pairs. Unused keys
#     only warn: a stray row is clutter, a missing one is a broken page.
#     Whole-line // comments are dropped before the scan.
template_src <- readLines(template_path, warn = FALSE, encoding = "UTF-8")
template_src <- paste(sub("^\\s*//.*$", "", template_src), collapse = "\n")

grab_keys <- function(pattern) {
  hits <- regmatches(template_src, gregexpr(pattern, template_src, perl = TRUE))[[1]]
  if (!length(hits)) return(character(0))
  sub(pattern, "\\1", hits, perl = TRUE)
}

# The lookbehind matters: without it "paint('fits'" matches as t('fits').
template_keys <- unique(c(
  grab_keys("(?<![A-Za-z])t\\('([a-z_]+)'"),
  grab_keys("setText\\('[a-z-]+',\\s*'([a-z_]+)'")
))
# A capture ending in "_" is a prefix concatenated with a rule_column, as in
# t('short_' + col), not a key anyone expects to resolve. Those families are
# covered per-rule by check 5 above.
template_keys <- template_keys[!grepl("_$", template_keys)]

missing <- setdiff(template_keys, txt(copy_df$key))
if (length(missing)) {
  stop("Copy sheet is missing key(s) that ", template_path, " asks for: ",
       paste(missing, collapse = ", "),
       "\n  Without them the page renders a literal [key_name] where the words",
       " should be.")
}

# 5c. Copy keys the template builds by concatenation: t('shows_' + v) for the
#     text-level chip and t('scale_' + k) for the case-count chip. Check 5b's
#     scan cannot see these (the capture ends in "_"), so they are listed here.
SHOWS_VALUES <- c("Passages", "Phrases", "Pattern")
shows_keys <- paste0("shows_", tolower(SHOWS_VALUES))
scale_keys <- c("scale_one", "scale_range", "scale_open", "scale_over")
missing <- setdiff(c(shows_keys, scale_keys), txt(copy_df$key))
if (length(missing)) {
  stop("Copy sheet is missing key(s) the template builds by name: ",
       paste(missing, collapse = ", "))
}

unused <- setdiff(txt(copy_df$key), c(template_keys, rule_keys, shows_keys, scale_keys))
if (length(unused)) {
  message("build_qual.R: NOTE - Copy key(s) nothing reads: ",
          paste(unused, collapse = ", "),
          "\n  Either wire them up in the template or delete the rows.")
}

# 5d. Copy keys unique. A duplicate key would resolve to whichever row came
#     first and the other row would be silently ignored.
if (anyDuplicated(txt(copy_df$key))) {
  stop("Duplicate key(s) in Copy: ",
       paste(unique(txt(copy_df$key)[duplicated(txt(copy_df$key))]), collapse = ", "))
}

# 6. Every display names what it shows of the text, from the fixed set, and
#    carries a family (the card's dot) so no card renders without one.
for (i in seq_len(nrow(displays))) {
  if (!txt(displays$shows[i]) %in% SHOWS_VALUES) {
    stop("Displays row ", i, " (id ", displays$id[i], "): 'shows' must be one of ",
         paste(SHOWS_VALUES, collapse = " | "), ", got '", displays$shows[i], "'")
  }
  if (blank(displays$family[i])) {
    stop("Displays row ", i, " (id ", displays$id[i], "): blank family.")
  }
}

# 7. units_min never exceeds units_max on a row (the row could never fit).
units_rank <- function(v) {
  if (blank(v)) return(NA_real_)
  levels_df$order[txt(levels_df$axis) == "units" & txt(levels_df$level_value) == txt(v)]
}
for (i in seq_len(nrow(displays))) {
  lo <- units_rank(displays$units_min[i]); hi <- units_rank(displays$units_max[i])
  if (!is.na(lo) && !is.na(hi) && lo > hi) {
    stop("Displays row ", i, " (id ", displays$id[i], "): units_min '",
         displays$units_min[i], "' is above units_max '", displays$units_max[i], "'.")
  }
}

# 8. "See it in use" links come in pairs, and the URL is relative to this site
#    (../page/index.html#anchor) or https. The template writes the URL into an
#    href, so this is the one place a stray workbook cell could inject markup.
for (i in seq_len(nrow(displays))) {
  lab <- displays$example_label[i]; url <- displays$example_url[i]
  if (blank(lab) != blank(url)) {
    stop("Displays row ", i, " (id ", displays$id[i], "): example_label and ",
         "example_url must both be filled or both be blank.")
  }
  if (!blank(url) && !grepl("^(\\.\\./[A-Za-z0-9_./#-]+|https://[^\\s\"'<>]+)$", txt(url))) {
    stop("Displays row ", i, " (id ", displays$id[i], "): example_url must be ",
         "a site-relative path starting with ../ or an https URL, got '", url, "'")
  }
}

# 9. Every Levels value on an in-list axis is accepted by at least one display.
#    A value no row accepts fails everything the moment it is picked, which is
#    exactly how the evaluation picker shipped two dead options in 2026-07.
for (r in seq_len(nrow(rules))) {
  rule <- as.list(rules[r, ])
  if (rule$rule_kind != "in-list") next
  valid <- txt(levels_df$level_value[txt(levels_df$axis) == rule$axis])
  used <- unique(unlist(lapply(displays[[rule$rule_column]], function(raw) {
    if (blank(raw)) return(character(0))
    trimws(strsplit(txt(raw), ";")[[1]])
  })))
  # A blank cell accepts everything, so an axis with any blank cell is covered.
  if (any(vapply(displays[[rule$rule_column]], blank, logical(1)))) next
  dead <- setdiff(valid, used)
  if (length(dead)) {
    stop("Levels value(s) for axis '", rule$axis, "' that no display accepts in '",
         rule$rule_column, "': ", paste(dead, collapse = ", "),
         "\n  Picking one would rule out every display.")
  }
}

# ── Inject ────────────────────────────────────────────────────────────────────
template <- paste(readLines(template_path, warn = FALSE, encoding = "UTF-8"),
                  collapse = "\n")

inject <- function(tpl, placeholder, json) {
  parts <- strsplit(tpl, placeholder, fixed = TRUE)[[1]]
  if (length(parts) != 2L) {
    stop("Expected exactly one ", placeholder, " placeholder in ", template_path)
  }
  paste0(parts[1], json, parts[2])
}

template <- inject(template, "__RULES_DATA__",   as_json(rules))
template <- inject(template, "__LEVELS_DATA__",  as_json(levels_df))
template <- inject(template, "__DISPLAYS_DATA__", as_json(displays))
template <- inject(template, "__COPY_DATA__",    as_json(copy_df))

con <- file(out_path, open = "w", encoding = "UTF-8")
writeLines(template, con, useBytes = FALSE)
close(con)

cat("build_qual.R: wrote", out_path, "with", nrow(displays), "displays\n")
