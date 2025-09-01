library(tibble)
library(dplyr)

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
p <- ggplot(
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

print(p)

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
  scale_fill_manual(values = c("Pupils" = "blue", "Students" = "yellow"))

print(p1)

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
    ), .groups = "drop"
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

result3 <- my_data_tbl |>
    group_by(Company_Name)|>
  summarize(count = n(), .groups = "drop") |>
  filter(count > 1) |>
  print()
