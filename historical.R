library(ggplot2)
# analyze data from http://www.repole.com/sun4cast/data.html
nfl_dir <- '~/workspace/data/nfl/'

files <- dir(nfl_dir, pattern = "\\.csv")
years <- vector("list", length = length(files))

for(f in files) {
  years[[f]] <- read.csv(file = file.path(nfl_dir, f))
}

all_nfl <- Reduce(function(...) {
  rbind(...)
}, years)

print(sprintf("Home Average: %0.8f", mean(all_nfl$Home.Score)))
print(sprintf("Away Average: %0.8f", mean(all_nfl$Visitor.Score)))
print(sprintf("Margin of Victory: %0.8f",
              mean(all_nfl$Home.Score) - mean(all_nfl$Visitor.Score)))

hsv <- rnorm(5000, mean = 22.3, sd = 7)
hsd <- dnorm(hsv, mean = 22.3, sd = 7)
p <- ggplot(data.frame(x = hsv, y = hsd)) +
  aes(x = x, y = y) +
  geom_point(color = "blue") +
  labs(x = "Home Score", y = "Probability")
print(p)
