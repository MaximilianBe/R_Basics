# Module Definitionen
SidebarUI <- function(
  id,
  axis,
  labels = list(x = "X", y = "Y", color = "Color"),
  choices = c("Documentary", "Feature Film", "TV Movie"),
  color = c("Type", "Genre", "AudienceRating")
) {
  tagList(
    selectInput(NS(id, "Y_axis"), paste0(labels$y, "-Axis:"), choices = axis),
    selectInput(NS(id, "X_axis"), paste0(labels$x, "-Axis:"), choices = axis),
    selectInput(NS(id, "color"), paste0(labels$color, " by:"), choices = color),
    sliderInput(
      NS(id, "alpha"),
      "Alpha:",
      min = 0,
      max = 1,
      step = 0.01,
      value = 0.1
    ),
    sliderInput(NS(id, "size"), "Size:", min = 0, max = 5, step = 1, value = 2),
    textInput(
      NS(id, "title"),
      "Plot title",
      placeholder = "Enter text to be used as plot title"
    ),
    checkboxGroupInput(
      NS(id, "type"),
      "Select movie type(s):",
      choices = as.list(choices)
    ), # as.list() hier
    numericInput(
      NS(id, "sample_size"),
      "Sample size:",
      value = 5,
      min = 1,
      max = 10
    ),
    actionButton(NS(id, "confirm"), "Write CSV", class = "btn btn-success")
  )
}

SidebarFilterServer <- function(id, axis, choices) {
  moduleServer(id, function(input, output, session) {
    selected_y <- reactive({
      input$Y_axis
    }) # Korrekte Input-Namen
    selected_x <- reactive({
      input$X_axis
    })
    selected_color <- reactive({
      input$color
    })
    alpha <- reactive({
      input$alpha
    })
    size <- reactive({
      input$size
    })
    title <- reactive({
      input$title
    })

    list(
      x = selected_x,
      y = selected_y,
      color = selected_color,
      alpha = alpha,
      size = size,
      title = title
    )
  })
}
