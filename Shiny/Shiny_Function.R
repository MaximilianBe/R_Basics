library(shiny)

iconRadioButtons <- function(inputId, label, choices, selected = NULL) {
  names <- lapply(choices, icon)
  values <- if (!is.null(names(choices))) names(choices) else choices
  radioButtons(
    inputId,
    label = label,
    choiceNames = names,
    choiceValues = values,
    selected = selected
  )
}

ui <- fluidPage(
  iconRadioButtons("Smile", "Smile", list("smile", "sad-tear")),
  iconRadioButtons("sad", "sad", "sad-tear")
)

server <- function(input, output, session) {
  # Server logic here
}

shinyApp(ui, server)
runApp(list(ui = ui, server = server), launch.browser = TRUE)
