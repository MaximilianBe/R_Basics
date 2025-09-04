library(shiny)
library(tibble)
library(ggplot2)
library(plotly)
library(bslib)
library(DT)

# Ihre bestehenden Datenvorbereitungen
load("movies.RData")
source("Shiny/Module/MovieSidebar.R")
source("Shiny/Module/MoviePlot.R")
source("Shiny/Module/MovieTable.R")

all_studios <- sort(unique(movies$studio))
min_date <- min(movies$thtr_rel_date)
max_date <- max(movies$thtr_rel_date)
score <- movies %>%
  mutate(score_ratio = audience_score / critics_score)
choices = c(
  "imdb_rating",
  "imdb_num_votes",
  "critics_score",
  "audience_score",
  "runtime"
)
types <- as.list(c("Documentary", "Feature Film", "TV Movie"))

# Angepasste UI mit dem Modul
ui <- page_sidebar(
  sidebar = sidebarModuleUI("sidebar", choices, types),
  # Hier würden Ihre anderen UI-Elemente stehen
  h3("Data from movies.RData"),
  mainPanel(
    plotModuleUI("plot"),
    MovieTableUI("table")
  )
)

server <- function(input, output, session) {
  # Sidebar-Modul aufrufen und Werte erhalten
  sidebar_values <- sidebarModuleServer("sidebar")
  plotModuleServer("plot", sidebar_values, movies)
  MovieTableServer("table", sidebar_values, movies)
  # Beispiel für die Nutzung der Sidebar-Werte
  observe({
    print(paste("Y-Achse:", sidebar_values$y()))
    print(paste("X-Achse:", sidebar_values$x()))
    print(paste("Show data:", sidebar_values$show_data()))
  })
}

shinyApp(ui = ui, server = server)
runApp(list(ui = ui, server = server), launch.browser = TRUE)
