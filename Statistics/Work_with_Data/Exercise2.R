library(tibble)
library(dplyr)
library(ggplot2)
library(plotly)

getwd()

my_data <- readRDS("Data/campaign_data_example.RDS")
my_data_tbl <- as_tibble(my_data)
print(n = 25, my_data_tbl)

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
  aes(x = Company_Size, y = mean_Campaign_Duration, fill = Company_Size)
) +
  geom_col() +
  geom_text(aes(label = mean_Campaign_Duration), vjust = -1) +
  labs(
    x = "Company Size",
    y = "Average Caimpaign Duration",
    title = "Campaign Durations"
  ) +
  theme_minimal()

print(p2)
#Is not perfect
print(ggplotly(p2))
