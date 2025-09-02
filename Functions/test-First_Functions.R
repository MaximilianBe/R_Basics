library(testthat)

context("Checking single digit prime divisors of numbers up to n")
source("Functions/First_Functions.R")
#getwd()

test_that("Number is dividable by three", {
  temp <- dividable_by_three(21)
  temp2 <- dividable_by_three(25)

  expect_that(temp, equals(TRUE))

  expect_that(temp2, equals(FALSE))
})

test_that("Prime Divisors", {
  temp <- check_divisor(105)
  temp2 <- check_divisor(86)

  expect_match(temp, "Die Zahl 105 ist durch 3, 5 und 7 teilbar")

  expect_match(temp2, "Die Zahl 86 ist ganz normal")
})
