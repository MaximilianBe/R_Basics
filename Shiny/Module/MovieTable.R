################################################################################-
# ----- Description -------------------------------------------------------------
#
# description
#
# ------------------------------------------------------------------ #
# Authors@R: author
# Date: year/month
#

################################################################################-
# ----- Libraries ---------------------------------------------------------------
library(shiny)
library(DT)


################################################################################-
# ----- Module UI -----

MovieTableUI <- function(id) {
  ns <- NS(id)

  DT::dataTableOutput(ns("table"))
}

################################################################################-
# ----- Module Server -----

MovieTableServer <- function(id, sidebar_values, external_input) {
  moduleServer(id, function(input, output, session) {
    output$table <- DT::renderDataTable({
      req(sidebar_values$n(), sidebar_values$type())
      if (sidebar_values$show_data()) {
        DT::datatable(
          data = external_input %>%
            filter(title_type %in% sidebar_values$type()) %>%
            slice_sample(n = min(sidebar_values$n(), nrow(.))) %>%
            select(1:7), #columns 1 to 7
          options = list(pageLength = 10),
          rownames = TRUE
        )
      }
    })
  })
}

################################################################################-
# ----- Generate Testdata -----

MovieTable_testdata <- list(
  last_location = "",
  encrypted_with = "",
  data = structure(list())
)

################################################################################-
# ----- Helping Functions -----

MovieTable_functions <- list()
