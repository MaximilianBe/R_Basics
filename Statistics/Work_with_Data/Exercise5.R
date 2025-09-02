library(tibble)
library(dplyr)
library(ggplot2)
library(plotly)

getwd()

my_data <- readRDS("Data/campaign_data_example.RDS")
my_data_tbl <- as_tibble(my_data)
print(n = 25, my_data_tbl)

result5 <- my_data_tbl |>
  group_by(Company_Name) |>
  summarize(number_IDs = n_distinct(ID), .groups = "drop") |>
  filter(number_IDs > 1) |>
  count(number_IDs) |>
  rename(number_of_companies = n) |>
  print()

p5 <- plot_ly(
  data = result5,
  x = ~number_IDs,
  y = ~number_of_companies,
  type = "bar",

  marker = list(color = ~number_IDs),
  colors = "Viridis",
  showlegend = FALSE
) |>
  layout(
    title = list(
      text = "Companies with different IDs",
      font = list(size = 25, color = "black")
    ),
    xaxis = list(title = "Different IDs", dtick = 1),
    yaxis = list(title = "Number of Companies")
  )

print(p5)
