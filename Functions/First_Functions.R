library(tidyverse)

dividable_by_three <- function(n) {
  if (n %% 3 == 0) {
    return(TRUE)
  }
  return(FALSE)
}

not_dividable_by_three <- function(n) {
  if (n %% 5 == 0 || n %% 7 == 0) {
    if (!n %% 3 == 0) {
      return(TRUE)
    }
  }
  return(FALSE)
}

not_dividable_by_three2 <- function(n) {
  for (i in 0:n) {
    if (i %% 3 == 0) {
      next
    }
    if (i %% 5 == 0 || i %% 7 == 0) {
      result <- str_glue(
        "Die Zahl {i} + ist durch 5 oder 7 teilbar, aber nicht durch 3"
      )
      print(result)
    }
  }
}

dividable_by_threeNumbers <- function(n) {
  divs <- c(3, 5, 7)
  all(n %% divs == 0)
  #if(n %% 3 == 0 && n % 5 == 0 && n % 7 == 0)
}

#We check which prime divisor the uneven numbers up to n have
check_divisor <- function(n) {
  for (i in 0:n) {
    #We first check the one with most requirements
    result <- case_when(
      dividable_by_threeNumbers(i) ~
        str_glue(
          "Die Zahl {i} ist durch 3, 5 und 7 teilbar"
        ),
      not_dividable_by_three(i) ~
        str_glue(
          "Die Zahl {i} ist durch 5 oder 7 teilbar, aber nicht durch 3"
        ),
      dividable_by_three(i) ~
        str_glue(
          "Die Zahl {i} ist durch 3 teilbar"
        ),
      TRUE ~ str_glue("Die Zahl {i} ist ganz normal")
    )
    print(result)
  }
}

check_divisor(120)
