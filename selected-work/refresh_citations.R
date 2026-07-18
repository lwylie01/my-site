# refresh_citations.R ─────────────────────────────────────────────────────────
# Refreshes the OpenAlex reference columns in selected-work/data/citations.csv.
#
# What it does and deliberately does not do:
#   - Updates openalex_cited and openalex_fetched for every row that carries an
#     openalex_id, straight from the OpenAlex API (free, no key).
#   - NEVER touches the `citations` column. That column is the number the page
#     displays, and it is Google Scholar's count, maintained by hand: Scholar
#     blocks automated requests, and OpenAlex undercounts law-heavy work by
#     enough (Duke arbitration: 56 vs 159 in July 2026) that mixing sources in
#     one ranked figure would be incoherent. The monthly PR this script feeds
#     shows both columns side by side so the maintainer can update the
#     displayed counts from her Scholar profile in one small edit.
#
# Usage:  Rscript selected-work/refresh_citations.R [changes.md]
#   Writes the updated CSV in place and a markdown change summary to the given
#   path (default: changes.md next to the CSV). Exits nonzero on any API or
#   data problem rather than writing a half-updated file.

suppressMessages(library(jsonlite))

base <- if (file.exists("selected-work/data/citations.csv")) "selected-work" else "."
csv_path <- file.path(base, "data", "citations.csv")
args <- commandArgs(trailingOnly = TRUE)
out_md <- if (length(args) >= 1) args[1] else file.path(base, "changes.md")

cit <- read.csv(csv_path, fileEncoding = "UTF-8",
                colClasses = c(id = "character", cite_note = "character",
                               openalex_id = "character",
                               openalex_fetched = "character"))
stopifnot(!anyDuplicated(cit$id),
          all(c("id", "citations", "openalex_id", "openalex_cited",
                "openalex_fetched") %in% names(cit)))

today <- format(Sys.Date(), "%Y-%m-%d")
rows <- which(nzchar(cit$openalex_id))
changes <- data.frame(id = character(), old = integer(), new = integer())

for (i in rows) {
  wid <- cit$openalex_id[i]
  url <- paste0("https://api.openalex.org/works/", wid,
                "?mailto=lwylie01@gmail.com")
  w <- tryCatch(fromJSON(url), error = function(e) {
    stop("OpenAlex request failed for ", cit$id[i], " (", wid, "): ",
         conditionMessage(e))
  })
  new_count <- w$cited_by_count
  if (is.null(new_count) || !is.numeric(new_count)) {
    stop("OpenAlex returned no cited_by_count for ", cit$id[i], " (", wid, ")")
  }
  old_count <- cit$openalex_cited[i]
  if (is.na(old_count) || old_count != new_count) {
    changes <- rbind(changes, data.frame(id = cit$id[i],
                                         old = ifelse(is.na(old_count), NA, old_count),
                                         new = new_count))
  }
  cit$openalex_cited[i] <- new_count
  cit$openalex_fetched[i] <- today
  Sys.sleep(0.25)
}

write.csv(cit, csv_path, row.names = FALSE, na = "")

# ── Markdown summary for the PR body ──────────────────────────────────────────
md <- c(
  "## Monthly citation check",
  "",
  paste0("OpenAlex reference counts refreshed ", today, " for ",
         length(rows), " publications."),
  ""
)
if (nrow(changes)) {
  md <- c(md,
    paste0("**", nrow(changes), " publication(s) moved since the last check:**"),
    "",
    "| id | OpenAlex before | OpenAlex now |",
    "|---|---|---|",
    sprintf("| %s | %s | %d |", changes$id,
            ifelse(is.na(changes$old), "(none)", changes$old), changes$new),
    "",
    paste0("The page displays the Google Scholar counts in the `citations` ",
           "column, which this job never edits. If Scholar moved too, update ",
           "that column from the ",
           "[Scholar profile](https://scholar.google.com/citations?user=-EyTKLcAAAAJ&hl=en) ",
           "and bump `citations_asof` on the Meta sheet of ",
           "`selected-work/data/publications.xlsx`, then merge. Merging ",
           "re-renders the page either way.")
  )
} else {
  md <- c(md, "No movement in OpenAlex counts since the last check.")
}
writeLines(md, out_md)

cat("refresh_citations.R: refreshed", length(rows), "rows;",
    nrow(changes), "changed. Summary at", out_md, "\n")
