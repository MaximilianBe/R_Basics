x <- c("A", "B", "C", "D")
y <- c(2, 4, 6, 8)

barplot(y, names.arg = x, density = 10, col="cyan", width=c(2,2,5,5), horiz=TRUE)
