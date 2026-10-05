# R-Cheatsheet

Die wichtigsten Funktionen dieser Einführung, in der Reihenfolge der Einheiten.
Platzhalter: `x` = Vektor · `df` = Data Frame · `m` = Matrix · `l` = Liste · `f` = Faktor ·
`g` = Gruppenspalte.

---

# Vorbereitung — RStudio, Projekte & Pakete

## Pakete & Hilfe

| Code | Bedeutung |
|---|---|
| `install.packages("pkg")` | Paket installieren — einmal pro Rechner, in der Console |
| `library(pkg)` | Paket laden — in jeder Sitzung, oben im Skript |
| `pkg::fun()` | eine Funktion nutzen, ohne das Paket zu laden |
| `?fun` | Hilfeseite öffnen (Arguments, Examples) |
| `getwd()` | aktuelles Arbeitsverzeichnis anzeigen |

## RStudio & R Markdown

| Tastenkürzel (Windows) | Wirkung |
|---|---|
| `Strg + Enter` | Zeile / Auswahl ausführen |
| `Strg + Shift + Enter` | Chunk ausführen |
| `Strg + Alt + I` | neuen Chunk einfügen |
| `Strg + Shift + K` | Dokument knitten |
| `Alt + -` | `<-` einfügen |
| `Strg + Shift + M` | Pipe einfügen |
| `Strg + Shift + F10` | R neu starten (leert Environment, entlädt Pakete) |

Auf dem Mac: `Cmd` statt `Strg`, `Option` statt `Alt`.

| Chunk-Option | Wirkung |
|---|---|
| `echo=FALSE` | Code ausführen, aber nicht zeigen |
| `eval=FALSE` | Code zeigen, aber nicht ausführen |
| `message=FALSE` · `warning=FALSE` | Meldungen · Warnungen ausblenden |
| `error=TRUE` | Fehler anzeigen statt abbrechen |

---

# Einheit 1 — Grundlagen

## Rechnen, Zuweisen, Vergleichen

| Code | Bedeutung |
|---|---|
| `+ - * / ^` | Grundrechenarten, Potenz |
| `%/%` · `%%` | ganzzahlige Division · Rest |
| `x <- 5` | zuweisen |
| `> >= < <=` · `==` · `!=` | vergleichen · gleich? · ungleich? |
| `&` · <code>&#124;</code> · `!` | und · oder · nicht |
| `round(3.14159, digits = 2)` | Funktion mit benanntem Argument |

## Datentypen

| Code | Bedeutung |
|---|---|
| `42.5` · `4L` · `"Text"` · `TRUE` / `FALSE` · `NA` | Zahl · Ganzzahl · Text · logisch · fehlend |
| `class(x)` | Datentyp anzeigen |
| `as.numeric(x)` · `as.character(x)` | Typ umwandeln (nicht umwandelbar → `NA`) |

## Vektoren

| Code | Bedeutung |
|---|---|
| `c(1, 2, 3)` | Vektor bauen |
| `1:10` · `seq(0, 100, by = 25)` | Folge in Einerschritten · mit Schrittweite |
| `length(x)` | Anzahl Elemente |
| `names(x) <- c(...)` | Elemente benennen |
| `x[1]` · `x[c(1, 3)]` · `x[2:4]` · `x["Jul"]` | auswählen (Index beginnt bei 1) |
| `x[-1]` | alles außer Position 1 |
| `x[x > 5]` · `which(x > 5)` · `sum(x > 5)` | filtern · Positionen · Anzahl |
| `x %in% c("a", "b")` | kommt der Wert in der Menge vor? |
| `x[2] <- 99` · `x[x < 0] <- NA` | Elemente überschreiben |
| `x + y` | elementweise rechnen |

## Kennzahlen & fehlende Werte

| Code | Bedeutung |
|---|---|
| `mean(x)` · `median(x)` · `sum(x)` · `min(x)` · `max(x)` · `sd(x)` | Grundfunktionen |
| `mean(x, na.rm = TRUE)` | fehlende Werte auslassen |
| `is.na(x)` · `sum(is.na(x))` | fehlt der Wert? · wie viele fehlen? |
| `round(x, 1)` · `sort(x)` · `which.max(x)` / `which.min(x)` | runden · sortieren · Position des Maximums / Minimums |

## Base-R-Grafik

| Code | Bedeutung |
|---|---|
| `barplot(x)` | Balken (Namen → Achsenbeschriftung) |
| `plot(x, type = "b")` · `plot(x, y)` | Verlauf · Streudiagramm |
| `hist(x, breaks = 8)` | Histogramm |
| `boxplot(x, y, names = c("a", "b"))` | Boxplots mehrerer Vektoren nebeneinander |
| `main =` · `xlab =` · `ylab =` · `col =` · `pch = 19` | Titel · Achsen · Farbe · Punktsymbol |
| `par(mfrow = c(1, 2))` … `par(mfrow = c(1, 1))` | Grafiken nebeneinander — danach zurücksetzen |

---

# Einheit 2 — Datenstrukturen

## Matrizen

| Code | Bedeutung |
|---|---|
| `matrix(1:6, nrow = 2)` | Matrix bauen (spaltenweise; `byrow = TRUE` zeilenweise) |
| `matrix(..., dimnames = list(zeilen, spalten))` | direkt benennen |
| `rownames(m) <- ...` · `colnames(m) <- ...` | Namen setzen |
| `m[i, j]` · `m[, j]` · `m[i, ]` · `m["Jul", "TMax"]` | auswählen |
| `rowMeans(m)` · `colMeans(m)` | Mittelwert je Zeile · je Spalte |
| `cbind(m, neu = x)` · `rbind(m, neu = x)` | Spalte · Zeile anhängen |
| `t(m)` | Zeilen und Spalten tauschen |

## Listen & Faktoren

| Code | Bedeutung |
|---|---|
| `list(a = x, b = df)` | Liste mit beliebigen Objekten |
| `l$a` · `l[["a"]]` | ein Element holen |
| `factor(x)` · `levels(f)` | Faktor bauen · Levels anzeigen |
| `levels(f) <- c(...)` | Levels umbenennen (in alphabetischer Reihenfolge) |
| `factor(x, levels = c(...), ordered = TRUE)` | geordneter Faktor |

## Data Frames

| Code | Bedeutung |
|---|---|
| `data.frame(a = x, b = y)` | Data Frame bauen |
| `str(df)` · `head(df)` · `summary(df)` | Struktur · erste Zeilen · Kennzahlen |
| `nrow(df)` · `ncol(df)` · `dim(df)` | Anzahl Zeilen · Spalten · beides |
| `df[i, j]` · `df[, "spalte"]` · `df$spalte` | auswählen |
| `df[df$x > 5, ]` · `subset(df, x > 5)` | Zeilen nach Bedingung |
| `unique(df$x)` · `table(df$x)` | vorkommende Werte · Häufigkeiten |
| `df$neu <- df$a / df$b` | neue Spalte |
| `df[order(df$x), ]` · `order(df$x, decreasing = TRUE)` | sortieren · absteigend |

---

# Einheit 3 — Daten einlesen, aufräumen & speichern

## Einlesen

| Code | Bedeutung |
|---|---|
| `read.csv("data/raw/f.csv")` | CSV mit `,` als Trenner und `.` als Dezimalzeichen |
| `read.csv("data/raw/f.csv", sep = ";", dec = ",")` | CSV mit `;` als Trenner und `,` als Dezimalzeichen |
| `skip = 4` · `header = FALSE` · `na.strings = c("", "-")` | Zeilen überspringen · keine Kopfzeile · was als `NA` gilt |
| `readxl::read_excel("data/raw/f.xlsx", sheet = 2)` | Excel-Datei, Tabellenblatt 2 (`skip`, `na` wie oben) |
| `readxl::excel_sheets("data/raw/f.xlsx")` | Namen der Tabellenblätter |

## Daten aufräumen

| Code | Bedeutung |
|---|---|
| `tolower(gsub(".", "_", names(df), fixed = TRUE))` | Spaltennamen in snake_case (Punkte → Unterstriche) |
| `df$x <- as.numeric(df$x)` | Spalte in Zahlen umwandeln |
| `paste("a", "b")` · `paste0("a", "b")` | Text verbinden mit / ohne Leerzeichen |
| `substr(x, 1, 2)` · `trimws(x)` | Zeichen ausschneiden · Randleerzeichen entfernen |
| `cut(x, breaks = c(0, 10, Inf), labels = c("klein", "groß"))` | Zahlen → Kategorien |

## Speichern

| Code | Bedeutung |
|---|---|
| `write.csv(df, "data/processed/f.csv", row.names = FALSE)` | als CSV speichern (`,` und `.`) |
| `writexl::write_xlsx(df, "data/processed/f.xlsx")` | als Excel-Datei speichern (`list(a = df1, b = df2)` für mehrere Blätter) |
| `saveRDS(df, "f.rds")` · `readRDS("f.rds")` | im R-Format speichern · laden (behält Typen) |

---

# Einheit 4 — Daten auswerten & visualisieren

## dplyr

| Code | Bedeutung |
|---|---|
| `df %>% f()` · <code>df &#124;&gt; f()</code> | Pipe „und dann": Ergebnis links → erstes Argument rechts |
| `data = .` (bei `%>%`) · `data = _` (bei <code>&#124;&gt;</code>) | Platzhalter, wenn die Daten nicht an erster Stelle stehen |
| `filter(df, x > 5, g %in% c("a", "b"))` | Zeilen auswählen (Komma = und) |
| `select(df, a, b)` | Spalten auswählen |
| `arrange(df, desc(x))` | sortieren (absteigend) |
| `mutate(df, neu = a / b)` | neue Spalte berechnen |
| `mutate(df, k = case_when(is.na(x) ~ NA, x > 40 ~ "hoch", TRUE ~ "niedrig"))` | mehrere Fälle, erster Treffer gewinnt |
| `count(df, g)` | Häufigkeiten zählen |
| `as.data.frame(tb)` · `as_tibble(df)` | Tibble → Data Frame · Data Frame → Tibble |
| `df %>% group_by(g) %>% summarise(n = n(), m = mean(x, na.rm = TRUE))` | Kennzahlen je Gruppe |
| `left_join(df1, df2, by = "id")` | verbinden, alle Zeilen von `df1` behalten |
| `inner_join()` · `right_join()` · `full_join()` | nur gemeinsame · alle von `df2` · alle |
| `tidyr::pivot_longer(df, cols = starts_with("X"), names_to = "jahr", values_to = "wert")` | breit → lang: viele Spalten werden zu Namens- und Wertespalte |
| `tidyr::pivot_wider(df, names_from = jahr, values_from = wert)` | lang → breit: Werte einer Spalte werden zu Spaltennamen |

## ggplot2

| Code | Bedeutung |
|---|---|
| `ggplot(df, aes(x = a, y = b)) + geom_point()` | Grundgerüst: Daten, Achsen, Form |
| `geom_point()` · `geom_col()` · `geom_line()` | Punkte · Balken · Linien |
| `geom_boxplot()` · `geom_histogram(bins = 8)` | Verteilungen |
| `aes(x = reorder(g, wert), y = wert)` · `coord_flip()` | Balken nach Wert sortieren · Grafik drehen |
| `aes(color = g)` · `color = "steelblue"` | Farbe nach Spalte · feste Farbe |
| `labs(title =, x =, y =)` | Beschriftung |
| `facet_wrap(~ g)` | eine Teilgrafik pro Gruppe |
| `theme_minimal()` · `theme_bw()` | Erscheinungsbild |
| `ggsave("output/grafik.png", width = 8, height = 5)` | letzte Grafik speichern |

---

# Einheit 5 — Bedingungen, Schleifen & Funktionen

| Code | Bedeutung |
|---|---|
| `if (x > 0) { ... } else { ... }` | Bedingung für **einen** Wert |
| `ifelse(x > 0, "ja", "nein")` | Bedingung für jedes Element eines Vektors |
| `for (i in seq_along(x)) { ... }` | für jede Position wiederholen |
| `ergebnis <- numeric(length(x))` | Ergebnisvektor vor der Schleife anlegen |
| `while (bedingung) { ... }` | wiederholen, solange die Bedingung gilt |
| `next` · `break` | nächster Durchlauf · Schleife beenden |
| `print(x)` · `cat("Text", x, "\n")` | Ausgabe innerhalb von Schleifen und Funktionen |
| `f <- function(x, n = 1) { ... }` | eigene Funktion mit Standardwert |
| `stop("Meldung")` | mit Fehlermeldung abbrechen |
| `sapply(df, mean)` · `lapply(df, mean)` | Funktion auf jede Spalte anwenden (Vektor · Liste) |
| `df[cols] <- lapply(df[cols], as.numeric)` | mehrere Spalten auf einmal umwandeln |
| `sapply(df, mean, na.rm = TRUE)` | weitere Argumente an die Funktion weiterreichen |
| `sapply(x, function(v) v^2)` · `sapply(x, \(v) v^2)` | mit anonymer Funktion (lang · kurz) |
