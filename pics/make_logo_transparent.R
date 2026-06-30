# Makes the white background of the brand logo transparent so it can sit on the
# gradient hero. Run from the project root:  Rscript pics/make_logo_transparent.R
#
#   pics/logoW.png  (white background)  ->  pics/logoW-clear.png  (transparent)
#
# Re-run this whenever logoW.png is re-exported. The navbar still uses the
# white-background logoW.png (it reads as a badge on the dark navbar); the hero
# uses the transparent logoW-clear.png.

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

writePNG(img, "pics/logoW-clear.png")
cat(sprintf("Wrote pics/logoW-clear.png (%.1f%% of pixels made transparent)\n",
            100 * mean(white_bg)))
