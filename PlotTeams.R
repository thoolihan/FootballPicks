source("Teams.R")
library(ggplot2)
library(dplyr)
library(gridExtra)

team_data <- mutate(team_data,
                 FavCoverPct = ifelse(is.na(FavCoverPct), 0.0, FavCoverPct),
                 UpsetPct = ifelse(is.na(UpsetPct), 0.0, UpsetPct)
)

covers <- arrange(team_data, FavCoverPct, Favorited)
covers <- mutate(covers, Team = factor(Team, levels = Team, ordered = TRUE))

upsets <- arrange(team_data, UpsetPct, Underdog)
upsets <- mutate(upsets, Team = factor(Team, levels = Team, ordered = TRUE))

g1 <- ggplot(data = covers) +
  geom_point(aes(y = Team,
                 x = FavCoverPct * 100,
                 color="Cover %",
                 size = Favorited), color = "Blue") +
  xlab("Cover as Favorite %")
g2 <- ggplot(data = upsets) +
  geom_point(aes(y = Team,
                 x = UpsetPct * 100,
                 color = "Upset %",
                 size = Underdog), color = "Red") +
  xlab("Upset %")
grid.arrange(g1, g2, ncol = 2)

