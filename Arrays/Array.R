multiarray <- array(dim = c(4, 3, 2))
x <- 1
y <- 0
while(x <= length(multiarray)){
    multiarray[x] <- 2 * x
      x <- x + 1
}

print(multiarray)

#Alternative mit 4er Schritte

multiarray2 <- array(4*(1:(4 * 3*2)), dim = c(4, 3, 2))

print(multiarray2)


# Leeres neues Array mit vertauschten Zeilen/Spalten
transposed_array <- array(dim = c(3, 4, 2))  # war (4,3,2) → jetzt (3,4,2)

for (k in 1:2) {  # Für jede Ebene
  original_slice <- multiarray[ , , k]

  # Manuelle Transposition mit cbind
  transposed_slice <- NULL
  for (i in 1:ncol(original_slice)) {
    transposed_slice <- rbind(transposed_slice, original_slice[ , i])
  }

  transposed_array[ , , k] <- transposed_slice
}

print(transposed_array)

for (k in 1:2) {
  cat("\nEbene", k, ":\n")
  print(transposed_array[ , , k])
}
