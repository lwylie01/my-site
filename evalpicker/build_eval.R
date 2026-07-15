# build_eval.R ────────────────────────────────────────────────────────────────
# Generates evalpicker/eval_picker.html from the editable Excel file.
#
# To update the picker: edit evalpicker/data/evaluation_approaches.xlsx — the
# "Rules", "Levels", "Approaches", "TMFs", "Prerequisites" and "Copy" sheets —
# then re-publish. This script is wired into _quarto.yml as a pre-render step,
# so `quarto render` / `quarto publish` regenerates the page automatically. The
# branded look/feel and the matching logic live in evalpicker/app/_template.html;
# only the data and the eligibility rules come from Excel.
#
# The validator below is not optional. The whole design bets on rules authored
# in a spreadsheet, so a trailing space or a near-miss value would otherwise
# produce a silently wrong eligibility verdict. In a tool that tells a court
# which evaluation to run, silent wrongness is the worst failure mode there is.
# Every check fails loud, naming the sheet, the row, and the valid values.

suppressMessages(library(readxl))

# Quarto runs pre-render scripts from the project root; allow running from the
# evalpicker/ directory too. Anchor every path on where the data file is found.
base <- if (file.exists("evalpicker/data/evaluation_approaches.xlsx")) "evalpicker" else "."
xlsx_path     <- file.path(base, "data", "evaluation_approaches.xlsx")
template_path <- file.path(base, "app", "_template.html")
out_path      <- file.path(base, "eval_picker.html")

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
    if (is.na(x))                        return("null")
    if (is.numeric(x) || is.logical(x)) return(as.character(x))
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

rules      <- read_sheet("Rules")
levels_df  <- read_sheet("Levels")
approaches <- read_sheet("Approaches")
tmfs       <- read_sheet("TMFs")
prereqs    <- read_sheet("Prerequisites")
copy_df    <- read_sheet("Copy")

# ── Validation ────────────────────────────────────────────────────────────────
# A blank cell means "this does not constrain me", so blank always passes.
blank <- function(x) is.na(x) || !nzchar(trimws(as.character(x)))
txt   <- function(x) trimws(as.character(x))

# 1. ids unique and non-blank across Approaches + TMFs
all_ids <- c(txt(approaches$id), txt(tmfs$id))
if (any(vapply(all_ids, blank, logical(1)))) {
  stop("Blank id in Approaches or TMFs. Every row needs an id.")
}
if (anyDuplicated(all_ids)) {
  stop("Duplicate id(s) across Approaches and TMFs: ",
       paste(unique(all_ids[duplicated(all_ids)]), collapse = ", "))
}

# 2. every rule cell resolves to a Levels value for its axis
GATE_VALUES <- c("Required", "Recommended", "Not needed")

check_levels <- function(df, sheet, rule) {
  valid <- txt(levels_df$level_value[txt(levels_df$axis) == rule$axis])
  if (rule$rule_kind == "gate") valid <- GATE_VALUES
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
  for (nm in c("Approaches", "TMFs")) {
    df <- if (nm == "Approaches") approaches else tmfs
    if (!rule$rule_column %in% names(df)) {
      stop(nm, " is missing the column '", rule$rule_column,
           "' required by the Rules sheet.")
    }
    check_levels(df, nm, rule)
  }
}

# 3. Levels needs a numeric order on every row (a blank one becomes JSON null
#    and the ordered comparisons then misbehave silently)
if (any(is.na(levels_df$order))) {
  stop("Levels sheet: every row needs a numeric 'order'.")
}

# 4. axis_label consistent for rows sharing an axis (maturity has two rows)
for (ax in unique(txt(rules$axis))) {
  labs <- unique(txt(rules$axis_label[txt(rules$axis) == ax]))
  if (length(labs) > 1) {
    stop("Rules sheet: axis '", ax, "' has conflicting axis_label values: ",
         paste(labs, collapse = " | "))
  }
}

# 5. Copy needs a reason template per rule
missing <- setdiff(paste0("reason_", txt(rules$rule_column)), txt(copy_df$key))
if (length(missing)) {
  stop("Copy sheet is missing key(s): ", paste(missing, collapse = ", "))
}

# 6. Prerequisites resolve, and strength is a known value
bad <- setdiff(c(txt(prereqs$approach_id), txt(prereqs$prereq_id)), all_ids)
if (length(bad)) {
  stop("Prerequisites references unknown id(s): ", paste(bad, collapse = ", "))
}
bad <- setdiff(txt(prereqs$strength), c("Required", "Recommended", "Conditional"))
if (length(bad)) {
  stop("Prerequisites has unknown strength(s): ", paste(bad, collapse = ", "),
       "\n  Valid: Required | Recommended | Conditional")
}

# 7. Conditional rows need a real condition; the others must not carry one.
#    A condition on a Required row would silently do nothing, which is exactly
#    the failure mode this validator exists to prevent.
for (i in seq_len(nrow(prereqs))) {
  strength <- txt(prereqs$strength[i])
  ax       <- prereqs$condition_axis[i]
  val      <- prereqs$condition_value[i]
  where    <- paste0("Prerequisites row ", i, " (", txt(prereqs$approach_id[i]),
                     " needs ", txt(prereqs$prereq_id[i]), ")")

  if (strength == "Conditional") {
    if (blank(ax) || blank(val)) {
      stop(where, ": strength is Conditional, so it needs both a condition_axis",
           " and a condition_value. Use Required if it always applies.")
    }
    if (!txt(ax) %in% txt(rules$axis)) {
      stop(where, ": condition_axis '", txt(ax), "' is not an axis in the Rules",
           " sheet.\n  Valid: ", paste(unique(txt(rules$axis)), collapse = " | "))
    }
    valid <- txt(levels_df$level_value[txt(levels_df$axis) == txt(ax)])
    vals  <- trimws(strsplit(txt(val), ";")[[1]])
    vals  <- vals[nzchar(vals)]
    bad   <- setdiff(vals, valid)
    if (length(bad)) {
      stop(where, ": condition_value has value(s) not in the Levels sheet for",
           " axis '", txt(ax), "': ", paste(bad, collapse = ", "),
           "\n  Valid: ", paste(valid, collapse = " | "))
    }
  } else if (!blank(ax) || !blank(val)) {
    stop(where, ": strength is ", strength, " but a condition is filled in. A",
         " condition only does something on a Conditional row, so this would be",
         " silently ignored. Either clear the condition or set strength to",
         " Conditional.")
  }
}

# 8. the blocking graph must be acyclic, or the page hangs. Conditional edges
#    count: a cycle that only closes under some filter states is still a cycle.
edges <- prereqs[txt(prereqs$strength) %in% c("Required", "Conditional"),
                 c("approach_id", "prereq_id"), drop = FALSE]
edges <- data.frame(approach_id = txt(edges$approach_id),
                    prereq_id   = txt(edges$prereq_id),
                    stringsAsFactors = FALSE)
nodes <- unique(c(edges$approach_id, edges$prereq_id))
repeat {
  ready <- setdiff(nodes, edges$approach_id)   # depends on nothing that is left
  if (!length(ready)) break
  nodes <- setdiff(nodes, ready)
  edges <- edges[!edges$prereq_id %in% ready, , drop = FALSE]
}
if (length(nodes)) {
  stop("Prerequisite cycle among: ", paste(nodes, collapse = " -> "),
       "\n  One of these depends on itself through the chain.")
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

template <- inject(template, "__RULES_DATA__",      as_json(rules))
template <- inject(template, "__LEVELS_DATA__",     as_json(levels_df))
template <- inject(template, "__APPROACHES_DATA__", as_json(approaches))
template <- inject(template, "__TMFS_DATA__",       as_json(tmfs))
template <- inject(template, "__PREREQS_DATA__",    as_json(prereqs))
template <- inject(template, "__COPY_DATA__",       as_json(copy_df))

con <- file(out_path, open = "w", encoding = "UTF-8")
writeLines(template, con, useBytes = FALSE)
close(con)

cat("build_eval.R: wrote", out_path, "with", nrow(approaches), "approaches and",
    nrow(tmfs), "frameworks\n")
