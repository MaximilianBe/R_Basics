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
source("Shiny/Sidebar.R")

## ----- libraries -----
library(shiny)
library(shinymanager)
library(ggplot2)
library(tidyverse)

## ----- functions/scripts -----

## ----- constants -----
axis <- as.list(c(
  "imdb_rating",
  "imbd_num_votes",
  "critics_score",
  "audience_score",
  "runtime"
))
choices <- as.list(c("Documentary", "Feature Film", "TV Movie"))

## ----- data -----
movie_data <- readRDS("Data/movies.RDS")

################################################################################-
# ----- Start -------------------------------------------------------------------
## ----- define UI Structure -----

# Defines the ui structure of the shiny app
ui <- function(req) {
  sidebar = sidebar(
    SidebarUI("filter", axis, choices)
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
        movie_data,
        path_to_keys_db = "Keys/keys_database.sqlite",
        path_to_user_db = "Keys/shiny_users.sqlite"
      )
    }
  })
  ### ----- Funcionality -----
}

################################################################################-
# ----- Render Shiny Webpage ----------------------------------------------------

shinyApp(ui, server)
runApp(list(ui = ui, server = server), launch.browser = TRUE)
