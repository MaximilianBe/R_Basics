library(tibble)
library(dplyr)
library(ggplot2)
library(plotly)

getwd()

my_data <- readRDS("Data/campaign_data_example.RDS")
my_data_tbl <- as_tibble(my_data)
print(n = 25, my_data_tbl)

result4 <- my_data_tbl |>
  mutate(
    year = format(Offer_Date, "%Y"),
    month = as.numeric(format(Offer_Date, "%m")), #01 - 12
    period_text = ifelse(
      month <= 6,
      paste0(year, "-H1"),
      paste0(year, "-H2")
    )
  ) |>
  group_by(period_text) |>
  summarize(
    total_offers = n(),
    won_offers = sum(Offer_Status == "Won", na.rm = TRUE),
    percentage = round(won_offers / total_offers * 100, 2),
    .groups = "drop"
  ) |>
  arrange(period_text) |>
  print()

acceptance_rate_biannual <- plot_ly(
  data = result4,
  x = ~period_text,
  y = ~percentage,
  type = "scatter",
  mode = "lines+markers",

  line = list(color = "green"),
  marker = list(color = "black")
) |>
  layout(
    title = list(
      text = "Trend about Acceptance Rate",
      font = list(size = 25, color = "black")
    )
  )

print(acceptance_rate_biannual)

result04 <- my_data_tbl |>
  mutate(
    year = format(Offer_Date, "%Y"),
    month = as.numeric(format(Offer_Date, "%m")), #01 - 12
    quarter = quarters(as.Date(Offer_Date)),
    period_text = paste0(year, quarter)
  ) |>
  group_by(period_text) |>
  summarize(
    total_offers = n(),
    won_offers = sum(Offer_Status == "Won", na.rm = TRUE),
    percentage = round(won_offers / total_offers * 100, 2),
    .groups = "drop"
  ) |>
  arrange(period_text) |>
  print()

acceptance_rate_quarter <- plot_ly(
  data = result04,
  x = ~period_text,
  y = ~percentage,
  type = "scatter",
  mode = "lines+markers",

  text = ~ paste(
    "Period:",
    period_text,
    "<br>Total:",
    total_offers,
    "<br>Won:",
    won_offers,
    "<br>Average:",
    percentage,
    "%"
  ),
  hoverinfo = "text",

  line = list(color = "green"),
  marker = list(color = "black")
) |>
  layout(
    title = list(
      text = "Trend about Acceptance Rate",
      font = list(size = 25, color = "black")
    ),
    xaxis = list(title = "Period in Quarters"),
    yaxis = list(title = "Acceptance Rate")
  )

print(acceptance_rate_quarter)
