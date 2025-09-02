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
