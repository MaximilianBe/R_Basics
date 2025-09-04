################################################################################-
# ----- Description -------------------------------------------------------------
#
# description
# Generates a plot according to the inputs of MovieSidebar
# ------------------------------------------------------------------ #
# Authors@R: author
# Date: year/month
#

################################################################################-
# ----- Libraries ---------------------------------------------------------------

################################################################################-
# ----- Module UI -----

plotModuleUI <- function(id) {
  ns <- NS(id)

  plotOutput(ns("plot"))
}

################################################################################-
# ----- Module Server -----

plotModuleServer <- function(id, sidebar_values, extract_data) {
  moduleServer(id, function(input, output, session) {
    plot_data <- reactive({
      req(sidebar_values$n(), sidebar_values$type())

      extract_data %>%
        filter(title_type %in% sidebar_values$type()) %>%
        slice_sample(n = min(sidebar_values$n(), nrow(.))) %>% #nrow(.) we look up how many rows are even left
        # remove NAs
        drop_na(all_of(c(
          sidebar_values$x(),
          sidebar_values$y(),
          sidebar_values$z()
        )))
    })

    output$plot <- renderPlot({
      req(plot_data())
      ggplot(
        data = plot_data(),
        aes(
          x = .data[[sidebar_values$x()]],
          y = .data[[sidebar_values$y()]],
          color = .data[[sidebar_values$z()]],
        )
      ) +
        geom_point(
          alpha = sidebar_values$alpha(),
          size = sidebar_values$size()
        ) +
        labs(title = sidebar_values$plot_title())
    })
  })
  observe({
    print(sidebar_values$n())
  })
}

################################################################################-
# ----- Generate Testdata -----

plotModule_function_testdata <- list(
  last_location = "",
  encrypted_with = "",
  data = structure(list())
)

################################################################################-
# ----- Helping Functions -----

plotModule_function_functions <- list()
