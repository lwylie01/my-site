# ── Brand-matched colour palettes ─────────────────────────────────────────────
# Replace the existing palette section in the setup chunk with this block

# Region palette — terracotta/mauve family + warm neutrals
region_pal <- c(
  "NYC"           = "#8C6A8D",   # primary mauve
  "LA"            = "#E98973",   # secondary terracotta
  "South"         = "#C4956A",   # warm amber-brown
  "Midwest"       = "#B08FAF",   # lighter mauve
  "Bay Area"      = "#D4A843",   # warm gold
  "UK"            = "#D2B1A3",   # accent dusty rose
  "International" = "#7A9E9F"    # cool sage — intentional contrast for intl
)

# Era palette — sequential warm-to-cool across time
era_pal <- c(
  "Old School" = "#6b4f6c",   # deep mauve
  "Golden Age" = "#8C6A8D",   # primary mauve
  "Late 90s"   = "#E98973",   # terracotta
  "2000s"      = "#C4956A",   # amber-brown
  "2010s"      = "#D2B1A3",   # dusty rose
  "2020s"      = "#A3B5B5"    # cool sage-grey
)

# Dimension palette — five distinct tones all harmonious with brand
dim_pal <- c(
  "Rhyme Density"    = "#8C6A8D",   # primary mauve
  "Vocab Breadth"    = "#C4956A",   # amber-brown
  "Storytelling"     = "#E98973",   # terracotta
  "Metaphor/Imagery" = "#D2B1A3",   # dusty rose
  "Conceptual Depth" = "#6b4f6c"    # deep mauve
)

# Confidence palette — traffic light logic kept, warmed to brand
conf_pal <- c(
  "H" = "#7A9E7E",   # muted sage green  — high confidence
  "M" = "#D4A843",   # warm amber        — medium / provisional
  "L" = "#E98973"    # terracotta        — low / estimate only
)
