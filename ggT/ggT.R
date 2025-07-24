ggT <- function(a, b) {
  a <- abs(a)
  b <- abs(b)
  g <- a
  f <- b
  while (b != 0) {
    q <- 0
    temp <- a

    # Subtraktion statt Division
    while (temp >= b) {
      temp <- temp - b
      q <- q + 1
    }

    r <- temp
    cat(a, "=", b, "*", q, "+", r, "\n")  # Ausgabe des Rechenschritts

    a <- b
    b <- r
    if(r > 0){
        rest <- r
    }
  }
  cat("der ggT von", g, "und", f, "ist", rest, "\n")
  cat("\n");
  return(a)
}

ggT(5, 15)
ggT(3, 420)
ggT(1071, 462)
ggT(26, 987)