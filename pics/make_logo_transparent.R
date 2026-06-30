# Prepares the brand logo for the website:
#   1. strips the opaque white background to transparent
#   2. crops the surrounding empty padding to the logo's content bounds
# so it sits tightly on the gradient hero and the light navbar. Run from root:
#   Rscript pics/make_logo_transparent.R
#
#   pics/logoW.png  (white bg, padded)  ->  pics/logoW-clear.png  (transparent, cropped)
#
# Re-run whenever logoW.png is re-exported. Both the hero and the navbar use
# the transparent, cropped logoW-clear.png.

library(png)

img <- readPNG("pics/logoW.png")
if (dim(img)[3] == 3) {                       # add an alpha channel if missing
  img <- array(c(img, matrix(1, dim(img)[1], dim(img)[2])), dim = c(dim(img)[1:2], 4))
}

R <- img[, , 1]; G <- img[, , 2]; B <- img[, , 3]
mx <- pmax(R, G, B); mn <- pmin(R, G, B)

# Near-white, low-saturation pixels = background -> fully transparent.
# Colored elements (dots, wordmark) keep their saturation, so they're preserved.
white_bg <- (mn >= 0.92) & ((mx - mn) <= 0.05)
img[, , 4][white_bg] <- 0
pct_clear <- 100 * mean(white_bg)

# Crop to the bounding box of visible (non-transparent) content, plus a small pad.
A    <- img[, , 4]
rows <- which(apply(A > 0, 1, any))
cols <- which(apply(A > 0, 2, any))
pad  <- 10
r1 <- max(min(rows) - pad, 1); r2 <- min(max(rows) + pad, nrow(A))
c1 <- max(min(cols) - pad, 1); c2 <- min(max(cols) + pad, ncol(A))
img <- img[r1:r2, c1:c2, , drop = FALSE]

writePNG(img, "pics/logoW-clear.png")
cat(sprintf("Wrote pics/logoW-clear.png  (%.1f%% cleared; cropped to %d x %d)\n",
            pct_clear, dim(img)[2], dim(img)[1]))
