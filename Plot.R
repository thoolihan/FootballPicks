source("./Picks.R")
library("ggplot2")

results_2014 = results[results$Year == 2014,]
games_by_week = aggregate(results_2014$Pick, by=list(Week = results$Week), FUN=length)
res_by_week = aggregate(results_2014$Correct, by=list(Week = results$Week), FUN=sum)

projected = coef(lm(res_by_week$x ~ res_by_week$Week))

print(ggplot(res_by_week, aes(Week, x)) +
        stat_smooth(aes(color = "Projected"), method="lm", color="purple", linetype="dotted") +
        geom_line(aes(y = games_by_week$x, color="Total"), color = "black", linetype = "dashed") +
        geom_point(aes(y = res_by_week$x, color="Correct", size = 10), color = "dark green") +
        geom_line(aes(y = games_by_week$x * 0.5, color="50%"),
                  linetype = 'dashed', color = "blue") +
        xlim(1, 17) +
        ylim(0, 16) +
        ylab('Picks'))

