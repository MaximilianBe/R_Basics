library(shiny)
library(tibble)
library(ggplot2)
library(plotly)

movies <- tribble(
  ~Title,
  ~Type,
  ~Genre,
  ~Duration,
  ~Rating,
  ~Studio,
  ~Year,
  ~AudienceRating,
  "The Wedding Banquet (Xi yan)",
  "Feature Film",
  "Drama",
  106,
  "R",
  "Good Machine",
  1993,
  8.2,
  "Blue Valentine",
  "Feature Film",
  "Drama",
  112,
  "R",
  "Weinstein Company",
  2010,
  7.5,
  "Swordfish",
  "Feature Film",
  "Drama",
  99,
  "R",
  "Warner Bros. Pictures",
  2001,
  6.7,
  "The Little Rascals",
  "Feature Film",
  "Comedy",
  82,
  "PG",
  "MCA Universal Home Video",
  1994,
  6.0,
  "Agent Cody Banks 2: Destination London",
  "Feature Film",
  "Action & Adventure",
  100,
  "PG",
  "MGM",
  2004,
  5.8,
  "The Heavenly Kid",
  "Feature Film",
  "Drama",
  90,
  "PG-13",
  "Orion",
  1985,
  6.4,
  "Die Hard 2",
  "Feature Film",
  "Mystery & Suspense",
  124,
  "R",
  "20th Century Fox",
  1990,
  7.9,
  "Pusher III: I'm the Angel of Death",
  "Feature Film",
  "Drama",
  90,
  "R",
  "Nordisk Film Biografdistributi",
  2005,
  7.1,
  "Pay It Forward",
  "Feature Film",
  "Drama",
  123,
  "PG-13",
  "Warner Bros. Pictures",
  2000,
  7.3,
  "A Haunted House 2",
  "Feature Film",
  "Comedy",
  86,
  "R",
  "Open Road Films",
  2014,
  5.2
)


source("Shiny/Sidebar.R")

axis <- as.list(c("Rating", "AudienceRating", "Duration"))
choices <- as.list(c("Documentary", "Feature Film", "TV Movie"))

ui <- fluidPage(
  sidebarPanel(
    SidebarUI("filter", axis, choices = choices)
  ),
  mainPanel(
    plotlyOutput("plot")
  )
)

server <- function(input, output, session) {
  # Server logic here
  data <- (SidebarFilterServer("filter", axis, choices = choices))
  #output$result <- renderText(data$title())
  output$plot <- renderPlotly({
    req(data$x(), data$y(), data$color())

    cat("Available columns in movies:", names(movies), "\n")
    cat("Selected x:", data$x(), "\n")
    cat("Selected y:", data$y(), "\n")
    cat("Selected color:", data$color(), "\n")

    p <- ggplot(
      movies,
      aes(
        x = .data[[data$x()]],
        y = .data[[data$y()]],
        color = .data[[data$color()]],
      )
    ) +
      geom_point(alpha = data$alpha(), size = data$size()) +
      ggtitle(if (data$title() != "") data$title() else "Movie Plot") +
      labs(
        x = data$x(),
        y = data$y()
      ) +
      theme_minimal()
  })
}

shinyApp(ui, server)
runApp(list(ui = ui, server = server), launch.browser = TRUE)
