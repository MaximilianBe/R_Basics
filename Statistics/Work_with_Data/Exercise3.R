library(tibble)
library(dplyr)
library(ggplot2)
library(plotly)

getwd()

my_data <- readRDS("Data/campaign_data_example.RDS")
my_data_tbl <- as_tibble(my_data)
print(n = 25, my_data_tbl)

result3 <- my_data_tbl |>
  group_by(Company_Name, Company_Size) |>
  summarize(visit_count = n(), .groups = "drop") |>
  filter(visit_count > 1) |>
  print()

#We care if a company returned
result3 |>
  count(Company_Size, name = "returning_Companies")

unique_returning_customer <- plot_ly(
  data = result3,
  x = ~Company_Size,

  #histogram counts automatically
  type = "histogram",

  color = ~Company_Size,
  colors = "Set1"
) |>
  layout(
    title = list(
      text = "unique Returning Customers by size",
      font = list(size = 25, color = "black")
    )
  )

print(unique_returning_customer)

#We care how often a company returned
result03 <- result3 |>
  group_by(Company_Size) |>
  summarize(
    number_Companies = n(),
    total_Requests = sum(visit_count),
    avg_Requests = round(mean(visit_count), 1)
  ) |>
  print()

returning_customer <- plot_ly(
  data = result03,
  x = ~Company_Size,
  y = ~total_Requests,
  type = "bar",

  color = ~Company_Size,
  colors = "Set2",

  text = ~ paste("Anzahl:", total_Requests)
) |>
  layout(
    title = list(
      text = "Returning Customers by size",
      font = list(size = 25, color = "black")
    )
  )

print(returning_customer)

customer_scatter <- plot_ly(
  data = result03,
  x = ~total_Requests,
  y = ~number_Companies,
  color = ~Company_Size,
  type = "scatter",
  mode = "markers",

  colors = "Set1",
  marker = list(size = 10),
  line = list(width = 3)
) |>
  layout(
    title = list(
      text = "Relationship: Total Requests vs Number of Companies",
      font = list(size = 20)
    ),
    xaxis = list(title = "Total Requests"),
    yaxis = list(title = "Number of Companies"),
    legend = list(title = "Company Size")
  )

print(customer_scatter)

#avg_Reqeusts shows average number of requests of the same returning company
avg_returning_customer <- plot_ly(
  data = result03,
  x = ~Company_Size,
  y = ~avg_Requests,
  type = "bar",

  color = ~Company_Size,
  colors = "Set2",

  text = ~ paste("Anzahl:", total_Requests)
) |>
  layout(
    title = list(
      text = "average of returning Customers by size",
      font = list(size = 25, color = "black")
    )
  )

print(avg_returning_customer)
