# Builds the course website with Quarto into docs/ (published with GitHub Pages).
#
# Run from the project folder (open r-einfuehrung.Rproj first):
#   source("_website/build_site.R")
#
# The notebooks are copied into _website/ and rendered there, so the course files
# themselves stay unchanged (no Quarto config in the folder students work in).
# While editing, use _website/preview_site.R for a live preview instead.

source("_website/prepare_site.R")
kopiere_quellen()

# docs/ lies outside the Quarto project, so Quarto does not clean it up itself:
# start from an empty folder to avoid leftover files from earlier builds
unlink("docs", recursive = TRUE)

status <- system2(quarto, c("render", shQuote("_website")))
if (status != 0) stop("Quarto render ist fehlgeschlagen.")

file.create("docs/.nojekyll")
message("Fertig. Startseite: docs/index.html")
