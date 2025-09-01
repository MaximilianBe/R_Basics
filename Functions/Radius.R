compute_radius <- function(x, y) {
  radius <- sqrt(x^2 + y^2)
  return(radius)
}

result <- compute_radius(1, 1)
print(result)
