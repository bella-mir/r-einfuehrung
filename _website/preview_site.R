# Live preview of the course website: opens it in the browser and reloads the page
# whenever one of the course files (.Rmd, cheatsheet.md, data/raw/) is saved.
#
# Run from the project folder, best in the RStudio tab "Terminal" (keeps the console free):
#   Rscript _website/preview_site.R
# or in the console: source("_website/preview_site.R")
# Stop with Ctrl+C (Terminal) or Esc / the stop button (console).
#
# The preview is for checking only: before publishing, build the site with
# source("_website/build_site.R").

source("_website/prepare_site.R")
if (!requireNamespace("processx", quietly = TRUE)) {
  stop('Bitte zuerst install.packages("processx") ausführen.')
}

kopiere_quellen()
vorschau <- processx::process$new(quarto, c("preview", "_website"),
                                  stdout = "|", stderr = "2>&1", cleanup_tree = TRUE)

# Quarto only watches _website/: pass on changes to the course files once per second
tryCatch(
  while (vorschau$is_alive()) {
    cat(vorschau$read_output())
    kopiere_quellen()
    Sys.sleep(1)
  },
  finally = {
    cat(vorschau$read_output())
    vorschau$kill_tree()
  }
)
