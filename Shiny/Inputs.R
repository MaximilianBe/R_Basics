library(shiny)
animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")
ui <- fluidPage(
  #text
  textInput("name", "What's your name?"),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3),

  #numeric
  numericInput("num", "Number one", value = 0, min = 0, max = 100, step = 10),
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100, step = 10),
  sliderInput("rng", "Range", value = c(10, 70), min = 0, max = 100),

  #date
  dateInput("dob", "When were you born?", datesdisabled = "2025-2-15"),
  dateRangeInput("holiday", "When do you want to go on vacation next?"),

  #choice
  selectInput("state", "What's your favourite state?", state.name),
  radioButtons("animal", "What's your favourite animal?", animals),
  radioButtons(
    "rb",
    "Choose one:",
    choiceNames = list(
      icon("angry"),
      icon("smile"),
      icon("sad-tear")
    ),
    choiceValues = list("angry", "happy", "sad")
  ),

  selectInput(
    "state",
    "What's your favourite state?",
    state.name,
    multiple = TRUE
  ),

  checkboxGroupInput("animal", "What animals do you like?", animals),

  #two singular checkboxes
  checkboxInput("cleanup", "Clean up?", value = TRUE),
  checkboxInput("shutdown", "Shutdown?"),

  #upload
  fileInput("upload", NULL),

  #buttons
  actionButton("click", "Click me!", class = "btn-warning"),
  actionButton("drink", "Drink me!", icon = icon("cocktail")),

  #plot
  plotOutput("plot", width = "100%")
)

server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5), res = 96)
}

shinyApp(ui, server)
runApp(list(ui = ui, server = server), launch.browser = TRUE)
