sidebarModuleUI <- function(id, choices, types) {
  ns <- NS(id)

  sidebar(
    # Select variable for y-axis
    selectInput(
      inputId = ns("y"),
      label = "Y-axis:",
      choices = choices,
      selected = "audience_score"
    ),
    # Select variable for x-axis
    selectInput(
      inputId = ns("x"),
      label = "X-axis:",
      choices = choices,
      selected = "critics_score"
    ),
    selectInput(
      ns("z"),
      "Color by:",
      choices = c(
        "title_type",
        "genre",
        "mpaa_rating",
        "critics_rating",
        "audience_rating"
      ),
      selected = "mpaa_rating"
    ),
    sliderInput(
      ns("alpha"),
      "Alpha:",
      min = 0,
      max = 1,
      step = 0.01,
      value = 0.5
    ),
    sliderInput(ns("size"), "Size:", min = 0, max = 5, step = 1, value = 2),
    textInput(
      ns("plot_title"),
      "Plot Title",
      placeholder = "Enter text to be used as plot title"
    ),
    checkboxInput(
      inputId = ns("show_data"),
      label = "Show data table",
      value = TRUE
    ),
    checkboxGroupInput(
      ns("type"),
      "Select movie type(s):",
      choices = types,
      selected = types
    ),
    numericInput(
      ns("n"),
      "Sample size:",
      value = 5,
      min = 1,
      max = 100
    )
  )
}

#Need Parameter here if you change the dataset with runtime
sidebarModuleServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Reaktive Werte zurückgeben
    return(
      list(
        y = reactive({
          input$y
        }),
        x = reactive({
          input$x
        }),
        z = reactive({
          input$z
        }),
        alpha = reactive({
          input$alpha
        }),
        size = reactive({
          input$size
        }),
        plot_title = reactive({
          input$plot_title
        }),
        show_data = reactive({
          input$show_data
        }),
        type = reactive({
          input$type
        }),
        n = reactive({
          input$n
        })
      )
    )
  })
}
