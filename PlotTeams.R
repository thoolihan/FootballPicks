source("Teams.R")
library("ggplot2")
library("dplyr")

covers <- mutate(team_data,
                 FavCoverPct = ifelse(is.na(FavCoverPct), 0.0, FavCoverPct),
                 UpsetPct = ifelse(is.na(UpsetPct), 0.0, UpsetPct)
)

covers <- arrange(team_data, FavCoverPct, UpsetPct)
covers <- mutate(covers, Team = factor(Team, levels = Team, ordered=TRUE))

visuals <- ggplot(data = covers) +
  geom_point(aes(y = Team,
                 x = FavCoverPct * 100,
                 color="Cover %",
                 size = Favorited), color = "Blue") +
  geom_point(aes(y = Team,
                 x = UpsetPct * 100,
                 color = "Upset %",
                 size = Underdog), color = "Red") +
  xlab("% Cover or Upset")
print(visuals)
