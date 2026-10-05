# Shared by build_site.R and preview_site.R: finds Quarto and copies the course files
# into _website/, where they are rendered.

if (!file.exists("r-einfuehrung.Rproj")) {
  stop("Bitte aus dem Projektordner ausführen (r-einfuehrung.Rproj öffnen).")
}

# Quarto: on the PATH, otherwise the version bundled with RStudio (macOS, Windows)
quarto <- Sys.which("quarto")
if (quarto == "") {
  kandidaten <- c(
    "/Applications/RStudio.app/Contents/Resources/app/quarto/bin/quarto",
    "C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe"
  )
  quarto <- kandidaten[file.exists(kandidaten)][1]
  if (is.na(quarto)) stop("Quarto wurde nicht gefunden (https://quarto.org/docs/get-started/).")
}
Sys.setenv(QUARTO_R = R.home("bin"))

# Source file -> file name inside _website/ (becomes the page name on the website)
seiten <- c(
  "00_vorbereitung.Rmd"                  = "vorbereitung.Rmd",
  "01_grundlagen.Rmd"                    = "einheit-1.Rmd",
  "02_datenstrukturen.Rmd"               = "einheit-2.Rmd",
  "03_daten_einlesen_aufraeumen.Rmd"     = "einheit-3.Rmd",
  "04_daten_auswerten_visualisieren.Rmd" = "einheit-4.Rmd",
  "05_funktionen_schleifen.Rmd"          = "einheit-5.Rmd",
  "06_uebungsaufgabe_1.Rmd"              = "uebungsaufgabe-1.Rmd"
)

# Writes a file only if its content changed, so the preview re-renders only edited pages
schreibe_wenn_geaendert <- function(zeilen, ziel) {
  if (file.exists(ziel) && identical(readLines(ziel, encoding = "UTF-8", warn = FALSE), zeilen)) {
    return(invisible(FALSE))
  }
  writeLines(zeilen, ziel, useBytes = TRUE)
  invisible(TRUE)
}

# Copies only new or changed files, so the preview does not re-render needlessly
kopiere_ordner <- function(von, nach) {
  dir.create(nach, recursive = TRUE, showWarnings = FALSE)
  dateien <- list.files(von, full.names = TRUE)
  ziel <- file.path(nach, basename(dateien))
  neu <- !file.exists(ziel) | file.mtime(dateien) > file.mtime(ziel)
  file.copy(dateien[neu], nach, overwrite = TRUE)
}

kopiere_quellen <- function() {
  for (quelle in names(seiten)) {
    zeilen <- readLines(quelle, encoding = "UTF-8", warn = FALSE)
    # On the website the course name is already in the header: drop the prefix from titles
    zeilen <- sub('^title: "R-Einführung — ', 'title: "', zeilen)
    schreibe_wenn_geaendert(zeilen, file.path("_website", seiten[[quelle]]))
  }

  # The cheat sheet has no YAML header: its first heading becomes the page title
  cheatsheet <- readLines("cheatsheet.md", encoding = "UTF-8", warn = FALSE)
  schreibe_wenn_geaendert(c("---", 'title: "Cheatsheet"', "---", cheatsheet[-1]),
                          "_website/cheatsheet.md")

  # Images and course data, so that paths like "data/raw/..." work while rendering
  kopiere_ordner("images", "_website/images")
  kopiere_ordner("data/raw", "_website/data/raw")
  invisible(NULL)
}
