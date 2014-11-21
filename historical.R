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
