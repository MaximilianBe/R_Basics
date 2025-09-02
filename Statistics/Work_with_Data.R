library(tibble)
library(dplyr)
library(ggplot2)
library(plotly)

getwd()

my_data <- readRDS("Data/campaign_data_example.RDS")
my_data_tbl <- as_tibble(my_data)
print(n = 25, my_data_tbl)

result1 <- my_data_tbl |>
  mutate(Offer_number = ifelse(Offer_Status == "Won", 1, 0)) |>
  group_by(target) |>
  summarize(Offer_Status = mean(Offer_number), .groups = "drop") |>
  mutate(
    Offer_acceptance_rate = paste(round(Offer_Status * 100, 2), "%")
  ) |>
  print()

# Angebote, die an Studenten gerichtet sind, werden häufiger angenommen: Wrong! Schüler nehmen häufiger Angebote an
p1 <- ggplot(
  data = result1,
  aes(x = target, y = Offer_Status * 100, fill = target)
) +
  geom_col() +
  geom_text(
    aes(label = paste(round(Offer_Status * 100, 2), "%")),
    vjust = -0.9
  ) +
  labs(
    x = "Target",
    y = "Offer Acceptance Rate(%)",
    title = "Acceptance Rate with targets"
  ) +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal()

print(p1)

p01 <- ggplot(
  data = result1,
  aes(x = target, y = Offer_Status * 100, fill = target)
) +
  geom_col() +
  geom_text(
    aes(label = paste(round(Offer_Status * 100, 2), "%")),
    vjust = -0.9
  ) +
  labs(
    x = "Target",
    y = "Offer Acceptance Rate(%)",
    title = "Acceptance Rate with targets"
  ) +
  scale_fill_manual(values = c("Pupils" = "blue", "Students" = "yellow"))

print(p01)

result2 <- my_data_tbl |>
  #Date as number of Days since 1970
  mutate(Campaign_Duration = as.numeric(End_Date - Start_Date)) |>
  mutate(
    Company_Size = ifelse(
      Company_Size %in% c("Small", "Medium-Small"),
      "Small",
      "Big"
    )
  ) |>
  group_by(Company_Size) |>
  summarize(
    mean_Campaign_Duration = format(
      round(mean(Campaign_Duration, na.rm = TRUE), 2),
      nsmall = 2
    ),
    .groups = "drop"
  ) |>
  print()

#We Show that Big companies have a longer average Campaign
p2 <- ggplot(
  data = result2,
  aes(x = Company_Size, y = mean_Campaign_Duration)
) +
  geom_col(fill = "blue") +
  geom_text(aes(label = mean_Campaign_Duration), vjust = -1) +
  labs(
    x = "Company Size",
    y = "Average Caimpaign Duration",
    title = "Campaign Durations"
  ) +
  theme_minimal()

print(p2)
#Is not perfect
ggplotly(p2)

result3 <- my_data_tbl |>
  group_by(Company_Name, Company_Size) |>
  summarize(visit_count = n(), .groups = "drop") |>
  filter(visit_count > 1) |>
  print()

#We care if a company returned
result3 |>
  count(Company_Size, name = "returning_Companies")

p3 <- plot_ly(
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

p03 <- plot_ly(data = result3, x = ~Company_Size, type = "bar")
#We care how often a company returned
result03 <- result3 |>
  group_by(Company_Size) |>
  summarize(
    number_Companies = n(),
    total_Requests = sum(visit_count),
    avg_Requests = round(mean(visit_count), 1)
  ) |>
  print()

p003 <- plot_ly(
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

p0003 <- plot_ly(
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

#avg_Reqeusts shows average number of requests of the same returning company
p00003 <- plot_ly(
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
      text = "Returning Customers by size",
      font = list(size = 25, color = "black")
    )
  )

p4 <- result4 <- my_data_tbl |>
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

p04 <- plot_ly(
  data = result4,
  x = ~period_text,
  y = ~percentage,
  type = "scatter",
  mode = "lines+markers",

  line = list(color = "green"),
  marker = list(color = "black")
)|>
  layout(
    title = list(
      text = "Trend about Acceptance Rate",
      font = list(size= 25, color = "black")
    )
  )

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

p004 <- plot_ly(
  data = result04,
  x = ~period_text,
  y = ~percentage,
  type = "scatter",
  mode = "lines+markers",

  text = ~paste(
  "Period:", period_text,
  "<br>Total:", total_offers,
  "<br>Won:", won_offers,
  "<br>Average:", percentage, "%"
  ),
  hoverinfo = "text",

  line = list(color = "green"),
  marker = list(color = "black")
)|>
  layout(
    title = list(
      text = "Trend about Acceptance Rate",
      font = list(size= 25, color = "black")
    ),
    xaxis = list(title = "Period in Quarters"),
    yaxis = list(title = "Acceptance Rate")
  )


result5 <- my_data_tbl |>
  group_by(Company_Name) |>
  summarize(number_IDs = n_distinct(ID), .groups = "drop") |>
  filter(number_IDs > 1) |>
  count(number_IDs)  |>
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
)|>
  layout(
    title = list(
      text = "Companies with different IDs",
      font = list(size= 25, color = "black")
    ),
    xaxis = list(title = "Different IDs", dtick = 1),
    yaxis = list(title = "Number of Companies")
  )

print(p5)
