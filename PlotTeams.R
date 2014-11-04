source("Teams.R")
library("ggplot2")

covers <- team_data[order(team_data$FavCoverPct, team_data$UpsetPct),]
covers$Team <- factor(covers$Team, levels = covers$Team, ordered=TRUE)

covers$FavCoverPct <- ifelse(is.na(covers$FavCoverPct), 0.0, covers$FavCoverPct)
covers$UpsetPct <- ifelse(is.na(covers$UpsetPct), 0.0, covers$UpsetPct)

visuals <- ggplot(data = covers) +
  geom_point(aes(y = Team,
                 x = FavCoverPct * 100,
                 color="Cover %",
                 size = Favorited)) +
  geom_point(aes(y = Team,
                 x = UpsetPct * 100,
                 color = "Upset %",
                 size = Underdog))
print(visuals)
