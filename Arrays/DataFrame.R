Videogames <- data.frame(
    name = c("Mario Kart World", "Donkey Kong: Bananza", "Wuchang"),
    metascore = c(90, 91, 75)
)

print(Videogames)

print(mean(Videogames$metascore))
cat("Median:",median(Videogames$metascore) , "\n")

#Showing that median is the same => Intern sort
MetaScores <- sort(Videogames$metascore)

print(median(MetaScores))