library("ggplot2")
library("dplyr")

res <- filter(results, Year == 2014)
weeks <- group_by(res, Week)
my_results <- summarize(weeks, Total = length(Week), Correct = sum(Correct))
model <- lm(Correct ~ Week + Total, data=my_results)
resid <- resid(model)
p <- qplot(data = my_results,
           x = Week,
           y = resid,
           geom = "point") +
  geom_line(aes(y = 0))

print(p)
