source("./Picks.R")
library(ggplot2)
library(dplyr)
library(gridExtra)

my_results <- filter(results, Year == 2014) %>%
  group_by(Week) %>%
  summarize(Total = length(Week), Correct = sum(Correct))

p1 <- qplot(data = my_results,
           x = Week,
           y = Correct,
           geom = c("point", "line"),
           color = "Correct",
           main = "Tim's 2014 Spread Pick Results Trending") +
  geom_line(aes(y = Total, color = "Total"),
            linetype = "dashed") +
  stat_smooth(aes(y = Correct, color = "Projected"), method = "lm") +
  scale_x_continuous(breaks = 1:17, limits = c(1,17)) +
  scale_y_continuous(breaks = seq(0, 16, 2), limits = c(0,16)) +
  theme_bw()

p2 <- qplot(data = my_results,
           x = Week,
           y = Correct,
           geom = c("point", "line"),
           color = "Correct",
           main = "Tim's 2014 Spread Pick Results Against 50%") +
  geom_line(aes(y = Total, color = "Total"),
            linetype = "dashed") +
  geom_line(aes(y = Total * 0.5, color="50%"),
            linetype = 'dashed') +
  scale_x_continuous(breaks = 1:17, limits = c(1,17)) +
  scale_y_continuous(breaks = seq(0, 16, 2), limits = c(0,16)) +
  theme_bw()

grid.arrange(p1, p2, nrow = 2)
