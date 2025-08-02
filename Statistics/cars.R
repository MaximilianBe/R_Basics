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