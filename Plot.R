source("./Picks.R")

results_2014 = results[results$Year == 2014,]
games_by_week = aggregate(results_2014$Pick, by=list(Week = results$Week), FUN=length)
half <- games_by_week
half$x <- half$x * 0.5
res_by_week = aggregate(results_2014$Correct, by=list(Week = results$Week), FUN=sum)

res <- data.frame(Week = games_by_week$Week,
                  Total = games_by_week$x,
                  Correct = res_by_week$x,
                  Half = half$x)

print(ggplot(res, aes(Week), main="Foo") +
        geom_line(aes(y = Total, color="Total")) +
        geom_point(aes(y = Correct, color="Correct")) +
        geom_line(aes(y = Half, color="50%")))
