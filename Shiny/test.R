library(shiny)

ui <- fluidPage(
  # UI elements here
)

server <- function(input, output, session) {
  # Server logic here
}

shinyApp(ui, server)
runApp(list(ui = ui, server = server), launch.browser = TRUE)
