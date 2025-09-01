x <- c("a"= 1, "b"= 2, "c" = 3)

x[1]

x[[1]]

x["b"]

x[["b"]]

x["d"]

x[0]

#These don't work
x[[1:2]]

x[[-1]]

x[[0]]

x[["f"]]

x[[4]]

#Works if x is a list
x <- list("a"= 1, "b"= 2, "c" = 3)
str(x)
class(x)
x[["f"]]

l <- list("aa" = 1, "bb" = 2, "bc" = 3)
l$a
column_of_interest <- "bb"
l[[column_of_interest]]
l$column_of_interest