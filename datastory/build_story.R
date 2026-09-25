# build_story.R ───────────────────────────────────────────────────────────────
# Generates datastory/story_worksheet.html from the editable Excel file.
#
# To update the worksheet: edit datastory/data/story_worksheet.xlsx (the
# "Elements", "Steps", "Fields", "Options" and "Copy" sheets), then re-publish.
# This script is wired into _quarto.yml as a pre-render step, so `quarto render`
# / `quarto publish` regenerates the page automatically. The look and behaviour
# live in datastory/app/_template.html; every word and every dropdown comes
# from Excel.
#
# Same family as evalpicker/build_eval.R and formatpicker/build_format.R, but a
# worksheet rather than a sorter: there are no rules, only a tree of elements,
# steps, and fields. Two dropdowns are not authored here at all. The format list
# and the audience expertise ladder are read from the format picker's workbook
# (list ids "@formats" and "@audiences"), so the worksheet and the picker it
# links to can never disagree about what a format or an audience level is.
#
# The validator below is not optional. A field pointing at a list that does not
# exist would render an empty dropdown, and a step with no fields would render
# a heading with nothing under it; neither throws in the browser. Every check
# fails loud, naming the sheet, the row, and the valid values.

suppressMessages(library(readxl))

# Quarto runs pre-render scripts from the project root; allow running from the
# datastory/ directory too. Anchor every path on where the data file is found.
in_root <- file.exists("datastory/data/story_worksheet.xlsx")
base <- if (in_root) "datastory" else "."
root <- if (in_root) "." else ".."
xlsx_path     <- file.path(base, "data", "story_worksheet.xlsx")
template_path <- file.path(base, "app", "_template.html")
out_path      <- file.path(base, "story_worksheet.html")
formats_path  <- file.path(root, "formatpicker", "data", "delivery_formats.xlsx")

read_sheet <- function(path, sheet) {
  df <- read_excel(path, sheet = sheet)
  for (col in names(df)) {
    if (is.character(df[[col]])) df[[col]][is.na(df[[col]])] <- ""
  }
  df
}

# Base-R JSON serialiser, copied from build_format.R: no jsonlite dependency.
# The output is injected as a JS literal rather than parsed, so anything that is
# not valid JSON throws and takes the rest of the script block with it.
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
    s <- gsub("</",   "<\\\\/",   s)
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

elements <- read_sheet(xlsx_path, "Elements")
steps    <- read_sheet(xlsx_path, "Steps")
fields   <- read_sheet(xlsx_path, "Fields")
options  <- read_sheet(xlsx_path, "Options")
copy_df  <- read_sheet(xlsx_path, "Copy")

blank <- function(x) is.na(x) || !nzchar(trimws(as.character(x)))
txt   <- function(x) trimws(as.character(x))

# ── Lists borrowed from the format picker ────────────────────────────────────
# Reserved list ids start with "@". They are built here, never authored in the
# Options sheet, so there is one place to edit a format or an audience level.
fp_formats <- read_sheet(formats_path, "Formats")
fp_levels  <- read_sheet(formats_path, "Levels")

aud <- fp_levels[txt(fp_levels$axis) == "audience", ]
aud <- aud[order(aud$order), ]
borrowed <- rbind(
  data.frame(list_id = "@formats",
             option  = txt(fp_formats$format_name),
             order   = seq_len(nrow(fp_formats)),
             stringsAsFactors = FALSE),
  data.frame(list_id = "@audiences",
             option  = txt(aud$label),
             order   = seq_len(nrow(aud)),
             stringsAsFactors = FALSE)
)
if (!sum(borrowed$list_id == "@formats") || !sum(borrowed$list_id == "@audiences")) {
  stop("Could not read the format list or the audience levels from ",
       formats_path, ". The worksheet borrows both from the format picker.")
}

# ── Validation ────────────────────────────────────────────────────────────────
# 1. ids unique and non-blank on every sheet that has them
check_ids <- function(df, sheet, col) {
  ids <- txt(df[[col]])
  if (any(vapply(ids, blank, logical(1)))) {
    stop(sheet, " sheet: blank ", col, ". Every row needs one.")
  }
  if (anyDuplicated(ids)) {
    stop(sheet, " sheet: duplicate ", col, "(s): ",
         paste(unique(ids[duplicated(ids)]), collapse = ", "))
  }
}
check_ids(elements, "Elements", "element_id")
check_ids(steps,    "Steps",    "step_id")
check_ids(fields,   "Fields",   "field_id")
check_ids(copy_df,  "Copy",     "key")

# 2. every row names a parent that exists
bad <- setdiff(txt(steps$element_id), txt(elements$element_id))
if (length(bad)) {
  stop("Steps sheet: element_id value(s) not in Elements: ",
       paste(bad, collapse = ", "),
       "\n  Valid here: ", paste(txt(elements$element_id), collapse = " | "))
}
bad <- setdiff(txt(fields$step_id), txt(steps$step_id))
if (length(bad)) {
  stop("Fields sheet: step_id value(s) not in Steps: ",
       paste(bad, collapse = ", "),
       "\n  Valid here: ", paste(txt(steps$step_id), collapse = " | "))
}

# 3. and every parent has at least one child, or it renders as an empty heading
for (e in txt(elements$element_id)) {
  if (!e %in% txt(steps$element_id)) stop("Elements sheet: '", e, "' has no Steps rows.")
}
for (s in txt(steps$step_id)) {
  if (!s %in% txt(fields$step_id)) stop("Steps sheet: '", s, "' has no Fields rows.")
}

# 4. a numeric order on every ordered row (a blank one becomes JSON null and
#    the sort then misbehaves silently)
for (nm in c("Elements", "Steps", "Fields", "Options")) {
  df <- switch(nm, Elements = elements, Steps = steps, Fields = fields, Options = options)
  if (!is.numeric(df$order) || any(is.na(df$order))) {
    stop(nm, " sheet: every row needs a numeric 'order'.")
  }
}

# 5. input types are known, and lists line up with them: a select or a multi
#    needs a list with at least two options; a text box must not name one
known_types <- c("select", "multi", "text", "textarea")
if (any(grepl("^@", txt(options$list_id)))) {
  stop("Options sheet: list ids starting with '@' are reserved for lists read",
       " from the format picker. Rename: ",
       paste(unique(txt(options$list_id)[grepl("^@", txt(options$list_id))]), collapse = ", "))
}
all_opts <- rbind(options[, c("list_id", "option", "order")], borrowed)
for (i in seq_len(nrow(fields))) {
  ty  <- txt(fields$input_type[i])
  lid <- txt(fields$list_id[i])
  fid <- txt(fields$field_id[i])
  if (!ty %in% known_types) {
    stop("Fields row ", i, " (", fid, "): input_type '", ty, "' is not known.",
         "\n  Valid here: ", paste(known_types, collapse = " | "))
  }
  if (ty %in% c("select", "multi")) {
    n <- sum(txt(all_opts$list_id) == lid)
    if (n < 2) {
      stop("Fields row ", i, " (", fid, "): list_id '", lid, "' has ", n,
           " option(s); a ", ty, " needs at least two.",
           "\n  Lists available: ", paste(unique(txt(all_opts$list_id)), collapse = " | "))
    }
  } else if (!blank(lid)) {
    stop("Fields row ", i, " (", fid, "): a ", ty, " field takes no list_id, but names '",
         lid, "'.")
  }
}

# 6. a step link needs both halves
for (i in seq_len(nrow(steps))) {
  if (blank(steps$link_label[i]) != blank(steps$link_url[i])) {
    stop("Steps row ", i, " (", steps$step_id[i], "): link_label and link_url",
         " must both be filled or both be blank.")
  }
}

# 7. every Copy key the template names must resolve. t() falls back to a literal
#    "[key_name]" rather than throwing, so a typo would ship to the page and
#    nothing would fail. The template is scanned for t('key') and the
#    setText('id', 'key') init pairs, with whole-line // comments dropped first.
#    Unused keys only warn: a stray row is clutter, a missing one is a broken page.
template_src <- readLines(template_path, warn = FALSE, encoding = "UTF-8")
template_src <- paste(sub("^\\s*//.*$", "", template_src), collapse = "\n")

grab_keys <- function(pattern) {
  hits <- regmatches(template_src, gregexpr(pattern, template_src, perl = TRUE))[[1]]
  if (!length(hits)) return(character(0))
  sub(pattern, "\\1", hits, perl = TRUE)
}
template_keys <- unique(c(
  grab_keys("(?<![A-Za-z])t\\('([a-z_]+)'"),
  grab_keys("setText\\('[a-z-]+',\\s*'([a-z_]+)'")
))

missing <- setdiff(template_keys, txt(copy_df$key))
if (length(missing)) {
  stop("Copy sheet is missing key(s) that ", template_path, " asks for: ",
       paste(missing, collapse = ", "),
       "\n  Without them the page renders a literal [key_name] where the words",
       " should be.")
}
unused <- setdiff(txt(copy_df$key), template_keys)
if (length(unused)) {
  message("build_story.R: NOTE - Copy key(s) nothing reads: ",
          paste(unused, collapse = ", "),
          "\n  Either wire them up in the template or delete the rows.")
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

template <- inject(template, "__ELEMENTS_DATA__", as_json(elements))
template <- inject(template, "__STEPS_DATA__",    as_json(steps))
template <- inject(template, "__FIELDS_DATA__",   as_json(fields))
template <- inject(template, "__OPTIONS_DATA__",  as_json(all_opts))
template <- inject(template, "__COPY_DATA__",     as_json(copy_df))

con <- file(out_path, open = "w", encoding = "UTF-8")
writeLines(template, con, useBytes = FALSE)
close(con)

cat("build_story.R: wrote", out_path, "with", nrow(steps), "steps and",
    nrow(fields), "fields\n")
