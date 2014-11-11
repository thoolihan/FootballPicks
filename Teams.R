source("./Picks.R")
library(scales)
library(dplyr)

home_teams = as.character(results$Home_Team)
away_teams = as.character(results$Away_Team)

teams = unique(c(home_teams, away_teams))
tc = length(teams)
team_data <- data.frame("Team" = character(tc),
                        "Games" = numeric(tc),
                        "Wins" = numeric(tc),
                        "Losses" = numeric(tc),
                        "Ties" = numeric(tc),
                        "Picks" = numeric(tc),
                        "PicksCorrect" = numeric(tc),
                        "PicksPct" = numeric(tc),
                        "Favorited" = numeric(tc),
                        "Underdog" = numeric(tc),
                        "FavCoverPct" = numeric(tc),
                        "HomeFavCover" = numeric(tc),
                        "AwayFavCover" = numeric(tc),
                        "UpsetPct" = numeric(tc),
                        "HomeUpset" = numeric(tc),
                        "AwayUpset" = numeric(tc),
                        stringsAsFactors = FALSE)
for(i in 1:length(teams)) {
  team = teams[i]

  home_games <- home_teams == team
  home_fav <- home_games & results$Favorite == "H"
  home_dog <- home_games & results$Favorite == "A"
  home_wins <- home_games & results$Home_Score > results$Away_Score
  home_losses <- home_games & results$Home_Score < results$Away_Score
  home_ties <- home_games & results$Home_Score == results$Away_Score

  away_games <- away_teams == team
  away_fav <- away_games & results$Favorite == "A"
  away_dog <- away_games & results$Favorite == "H"
  away_wins <- away_games & results$Away_Score > results$Home_Score
  away_losses <- away_games & results$Away_Score < results$Home_Score
  away_ties <- away_games & results$Home_Score == results$Away_Score

  team_data$Team[i] <- team
  team_data$Games[i] <- sum(c(home_games, away_games))
  team_data$Wins[i] <- sum(c(home_wins, away_wins))
  team_data$Losses[i] <- sum(c(home_losses, away_losses))
  team_data$Ties[i] <- sum(c(home_ties, away_ties))
  team_data$Picks[i] <- sum(results$Pick == team)
  team_data$PicksCorrect[i] <- sum(results$Pick == team & results$Correct)
  team_data$PicksPct[i] <- team_data$PicksCorrect[i] / team_data$Picks[i]

  team_data$Favorited[i] <- sum(c(home_fav, away_fav))
  team_data$Underdog[i] <- sum(c(home_dog, away_dog))

  team_data$FavCoverPct[i] <- sum(c(home_fav & home_wins, away_fav & away_wins)) /
                              sum(c(home_fav, away_fav))
  team_data$HomeFavCover[i] <- sum(home_fav & home_wins) / sum(home_fav)
  team_data$AwayFavCover[i] <- sum(away_fav & away_wins) / sum(away_fav)

  team_data$UpsetPct[i] <- sum(c(home_dog & home_wins, away_dog & away_wins)) /
    sum(c(home_dog, away_dog))
  team_data$HomeUpset[i] <- sum(home_dog & home_wins) / sum(home_dog)
  team_data$AwayUpset[i] <- sum(away_dog & away_wins) / sum(away_dog)
}

# Needs improving, it's an attempt at a weighted performance score against the spread
teams <- mutate(team_data, combined = FavCoverPct * Favorited +
                     + UpsetPct * Underdog)

examine_teams <- function(...) {
  td <- team_data[team_data$Team %in% list(...),]

  print(cbind(team = td$Team, pick_right = percent(td$PicksPct),
        cover = percent(td$FavCoverPct),
        home_cover = percent(td$HomeFavCover), away_cover = percent(td$AwayFavCover),
        upset = percent(td$UpsetPct),
        home_upset = percent(td$HomeUpset), away_upset = percent(td$AwayUpset),
        record = paste(td$Wins, "-", td$Losses, "-", td$Ties, sep="")))
}


