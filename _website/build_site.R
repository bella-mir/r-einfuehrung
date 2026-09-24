# Builds the course website with Quarto into docs/ (published with GitHub Pages).
#
# Run from the project folder (open RIntroduction.Rproj first):
#   source("_website/build_site.R")
#
# The notebooks are copied into _website/ and rendered there, so the course files
# themselves stay unchanged (no Quarto config in the folder students work in).

if (!file.exists("RIntroduction.Rproj")) {
  stop("Bitte aus dem Projektordner ausführen (RIntroduction.Rproj öffnen).")
}

# Quarto: on the PATH, otherwise the version bundled with RStudio
quarto <- Sys.which("quarto")
if (quarto == "") {
  quarto <- "C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe"
}

# Source file -> file name inside _website/ (becomes the page name on the website)
seiten <- c(
  "0_RINTRO.Rmd"   = "einheit-0.Rmd",
  "I_RINTRO.Rmd"   = "einheit-1.Rmd",
  "II_RINTRO.Rmd"  = "einheit-2.Rmd",
  "III_RINTRO.Rmd" = "einheit-3.Rmd",
  "IV_RINTRO.Rmd"  = "einheit-4.Rmd"
)

for (quelle in names(seiten)) {
  zeilen <- readLines(quelle, encoding = "UTF-8")
  # On the website the course name is already in the header: drop the prefix from titles
  zeilen <- sub('^title: "R-Einführung — ', 'title: "', zeilen)
  writeLines(zeilen, file.path("_website", seiten[[quelle]]), useBytes = TRUE)
}

# The cheat sheet has no YAML header: its first heading becomes the page title
cheatsheet <- readLines("R_Cheatsheet.md", encoding = "UTF-8")
writeLines(c("---", 'title: "Cheatsheet"', "---", cheatsheet[-1]),
           "_website/cheatsheet.md", useBytes = TRUE)

# Course data, so that paths like "data/raw/..." work while rendering
dir.create("_website/data/raw", recursive = TRUE, showWarnings = FALSE)
file.copy(list.files("data/raw", full.names = TRUE), "_website/data/raw", overwrite = TRUE)

Sys.setenv(QUARTO_R = R.home("bin"))
status <- system2(quarto, c("render", shQuote("_website")))
if (status != 0) stop("Quarto render ist fehlgeschlagen.")

file.create("docs/.nojekyll")
message("Fertig. Startseite: docs/index.html")
