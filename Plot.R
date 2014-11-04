source("./Picks.R")
library("ggplot2")

results_2014 = results[results$Year == 2014,]
games_by_week = aggregate(results_2014$Pick, by=list(Week = results$Week), FUN=length)
res_by_week = aggregate(results_2014$Correct, by=list(Week = results$Week), FUN=sum)

print(ggplot(res_by_week, aes(Week)) +
        geom_line(aes(y = games_by_week$x, color="Total")) +
        geom_point(aes(y = res_by_week$x, color="Correct")) +
        geom_line(aes(y = games_by_week$x * 0.5, color="50%")))
