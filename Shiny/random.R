library(shiny)

randomUI <- function(id) {
  tagList(
    wellPanel(
      fluidRow(
        column(6, h4("Random Value:"), textOutput(NS(id, "val"), inline = TRUE))
      )
    ),
    actionButton(NS(id, "go"), "Go!")
  )
}
randomServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    rand <- eventReactive(input$go, sample(100, 1))
    output$val <- renderText(rand())
  })
}

ids <- paste("random", 1:4)
ui <- fluidPage(
  lapply(ids, randomUI)
)

server <- function(input, output, session) {
  # Server logic here
  lapply(ids, randomServer)
}

shinyApp(ui, server)
runApp(list(ui = ui, server = server), launch.browser = TRUE)
