# server <- function(input, output, session) {
#   # Server logic here
#   data <- (SidebarFilterServer("filter", axis, choices = choices))
#   #output$result <- renderText(data$title())
#   output$plot <- renderPlotly({
#     req(data$x(), data$y(), data$color())

#     # cat("Available columns in movies:", names(movies), "\n")
#     # cat("Selected x:", data$x(), "\n")
#     # cat("Selected y:", data$y(), "\n")
#     # cat("Selected color:", data$color(), "\n")

#     plot_ly(
#       data = movies,
#       x = ~ data$x(),
#       y = ~ data$y(),
#       color = ~ data$color(),
#       type = 'scatter',
#       mode = 'markers',
#       marker = list(
#         size = data$size() * 3,
#         opacity = data$alpha()
#       ),

#       # text = ~ paste(
#       #   "Title:",
#       #   data$title(),
#       #   "<br>",
#       #   data$x(),
#       #   ":",
#       #   round(get(data$x()), 2),
#       #   "<br>",
#       #   data$y(),
#       #   ":",
#       #   round(get(data$y()), 2),
#       #   "<br>",
#       #   data$color(),
#       #   ":",
#       #   get(data$color())
#       # ),
#       hovertemplate = "%{text}<extra></extra>"
#     ) %>%
#       layout(
#         title = if (data$title() != "") data$title() else "Movie Plot",
#         xaxis = list(title = data$x()),
#         yaxis = list(title = data$y()),
#         showlegend = TRUE
#       )
#   })
# }