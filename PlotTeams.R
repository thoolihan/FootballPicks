source("Teams.R")
library("ggplot2")

covers <- team_data
covers$FavCoverPct <- ifelse(is.na(covers$FavCoverPct), 0.0, covers$FavCoverPct)
covers <- covers[order(covers$FavCoverPct),]
with(covers, {
  Team <- factor(Team, levels = Team, ordered=TRUE)
  print(qplot(x = FavCoverPct * 100,
              y = Team,
              xlab = "Cover %",
              ylab = "Team",
              size = Favorited,
              main = "% Covering The Spread"))
})

upsets <- team_data
upsets$UpsetPct <- ifelse(is.na(upsets$UpsetPct), 0.0, upsets$UpsetPct)
upsets <- upsets[order(upsets$UpsetPct),]
with(upsets, {
  Team <- factor(Team, levels = Team, ordered=TRUE)
  print(qplot(x = UpsetPct * 100,
              y = Team,
              xlab = "Upset %",
              ylab = "Team",
              size = Underdog,
              main = "% Upset When UnderDog"))
})
