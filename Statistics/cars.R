library(tibble)
library(dplyr)

Data_cars <- mtcars
print(Data_cars)

cat("Dimension of Table:", dim(Data_cars), "\n")

cat("columns:", names(Data_cars), "\n")

print(sort(Data_cars$wt))

#outputs: Min, First quantile, Median, Mean, Third quantile, Max
print(summary(Data_cars))

#returns index of fitting dataset
print(which.max(Data_cars$wt))
print(which.min(Data_cars$wt))

print(rownames(Data_cars)[which.max(Data_cars$wt)])
print(rownames(Data_cars)[which.min(Data_cars$wt)])

print(mean(Data_cars$wt))
print(median(Data_cars$wt))

#-table will turn the biggest value into the smallest => sort descending
print(names(sort(-table(Data_cars$wt))) [1])

Data_cars |>
  filter(mpg > 20) |>
  arrange(desc(wt))|>
  mutate(mpg = mpg * 100)|>
  group_by(cyl)|>
  summarize(mpg_avg = mean(mpg),
            wt_avg = mean(wt),
            .groups = "drop") |>
  knitr::kable()

Data_cars |>
  filter(mpg > 20) |>
  arrange(desc(wt))|>
  mutate(mpg = mpg * 100)|>
  knitr::kable()
