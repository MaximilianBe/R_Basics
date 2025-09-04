################################################################################-
# ----- Description -------------------------------------------------------------
#
# description
# a simple app to practice shiny
# ------------------------------------------------------------------ #
# Authors@R: Maximilian Berning
# Date: 2025/09
#

################################################################################-
# ----- Settings ----------------------------------------------------------------

rm(list = ls())
source("Shiny/Module/MovieSidebar.R")
source("Shiny/Module/MoviePlot.R")
source("Shiny/Module/MovieTable.R")

## ----- libraries -----
library(shiny)
library(shinymanager)
library(ggplot2)
library(tidyverse)
library(plotly)

## ----- functions/scripts -----

## ----- constants -----
db_path <- "Keys/keys_database.sqlite"
user_path <- "Keys/shiny_users.sqlite"

choices = c(
  "imdb_rating",
  "imdb_num_votes",
  "critics_score",
  "audience_score",
  "runtime"
)
types <- as.list(c("Documentary", "Feature Film", "TV Movie"))

## ----- data -----
movies <- readRDS("Data/movies.RDS")
shinymanager::custom_show_secrets("Keys/keys_database.sqlite")

################################################################################-
# ----- Start -------------------------------------------------------------------
## ----- define UI Structure -----
movies <- shinymanager::custom_encrypt_data(
  movies,
  name_of_secret = "test",
  path_to_keys_db = db_path,
  path_to_user_db = user_path
)

print(movies)
# Defines the ui structure of the shiny app
ui <- function(req) {
  page_sidebar(
    sidebar = sidebarModuleUI("sidebar", choices, types),
    h3("Data from movies.RData"),
    mainPanel(
      plotModuleUI("plot"),
      MovieTableUI("table")
    )
  )
}

# wrap UI with secure_app
ui <- secure_app(ui, enable_admin = TRUE)

## ----- define Server Function -----

# Defines all content to be placed inside the placeholders of the ui
server <- function(input, output, session) {
  # check_credentials returns a function to authenticate users
  res_auth <- secure_server(
    check_credentials = check_credentials(
      "Keys/shiny_users.sqlite"
    )
  )

  observeEvent(input$shinymanager_where, {
    if (input$shinymanager_where == "application") {
      shinymanager::custom_decrypt_data_2(
        movies,
        name_of_secret = "test",
        path_to_keys_db = "Keys/keys_database.sqlite",
        path_to_user_db = "Keys/shiny_users.sqlite"
      )
    }
  })
  ### ----- Funcionality -----
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

################################################################################-
# ----- Render Shiny Webpage ----------------------------------------------------

shinyApp(ui, server)
runApp(list(ui = ui, server = server), launch.browser = TRUE)
