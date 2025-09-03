library(shiny)

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"),
  # UI elements here
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Observations:", min = 0, max = 1000, value = 500)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  ),
  navbarPage(
    "Page title",
    tabPanel("panel 1", "one"),
    tabPanel("panel 2", "two"),
    tabPanel("panel 3", "three"),
    navbarMenu(
      "subpanels",
      tabPanel("panel 4a", "four-a"),
      tabPanel("panel 4b", "four-b"),
      tabPanel("panel 4c", "four-c")
    )
  )
)

server <- function(input, output, session) {
  # Server logic here
}

shinyApp(ui, server)
runApp(list(ui = ui, server = server), launch.browser = TRUE)
