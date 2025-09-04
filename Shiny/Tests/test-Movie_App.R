library(testthat)


test_that("plotModuleServer verarbeitet Daten korrekt", {
  load("movies.RData")
  # Dummy Sidebar-Werte
  sidebar_values <- list(
    x = function() "imbd_rating",
    y = function() "audience_score",
    z = function() "critics_score",
    type = function() c("Documentary"),
    n = function() 5
  )

  df_type <- movies %>%
    filter(title_type %in% sidebar_values$type()) %>%
    slice_sample(n = min(sidebar_values$n(), nrow(.)))
  df_x <- movies %>%
    filter(imdb_rating %in% c(5, 6))

  expect_true(all(df_type$title_type %in% sidebar_values$type()))
  expect_lte(nrow(df_type), sidebar_values$n())
  #Intended Failure
  #rows df_x > 0?
  expect_lt(nrow(df_x), 15)
})
