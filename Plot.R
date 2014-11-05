source("./Picks.R")
library("ggplot2")
library("dplyr")

res <- filter(results, Year == 2014)
weeks <- group_by(res, Week)
my_results <- summarize(weeks, Total = length(Week), Correct = sum(Correct))

p <- qplot(data = my_results,
           x = Week,
           y = Correct,
           geom = c("point", "line"),
           color = "Correct",
           main = "Tim's 2014 Spread Pick Results") +
  stat_smooth(aes(y = Correct, color = "Linear Projection"),
                method = "lm") +
  geom_line(aes(y = Total, color = "Total"),
            linetype = "dashed") +
  geom_line(aes(y = Total * 0.5, color="50%"),
            linetype = 'dashed') +
  scale_x_continuous(breaks = 1:17, limits = c(1,17)) +
  scale_y_continuous(breaks = seq(0, 16, 2), limits = c(0,16))
print(p)
