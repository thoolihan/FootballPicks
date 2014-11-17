library(ggplot2)
library(dplyr)
library(gridExtra)

res_waf <- filter(results, Year == 2014) %>%
            mutate(Week = factor(Week, levels = 1:17)) %>%
            group_by(Week) %>%
            summarize(Total = length(Week), Correct = sum(Correct))
bt_model <- lm(Correct ~ Total, data = res_waf)
bt_resid <- resid(bt_model)

res <- filter(results, Year == 2014) %>%
  group_by(Week) %>%
  summarize(Total = length(Week), Correct = sum(Correct))

bw_model <- lm(Correct ~ Week, data = res)
bw_resid <- resid(bw_model)

btw_model <- lm(Correct ~ I(Total - 13) + Week, data = res)
btw_resid <- resid(btw_model)

p1 <- qplot(data = res_waf,
            x = Week,
            y = bt_resid,
            geom = "point") +
  geom_line(aes(y = 0)) +
  theme_bw() +
  xlab("By Total Number of Games")

p2 <- qplot(data = res,
            x = Week,
            y = bw_resid,
            geom = "point") +
  geom_line(aes(y = 0)) +
  theme_bw() +
  xlab("By Week")

p3 <- qplot(data = res,
            x = Week,
            y = btw_resid,
            geom = "point") +
  geom_line(aes(y = 0)) +
  theme_bw() +
  xlab("By Week & Total Games")

grid.arrange(p1, p2, p3, nrow = 3)
