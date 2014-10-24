source("./Picks.R")

home_teams = as.character(results$Home_Team)
away_teams = as.character(results$Away_Team)

teams = unique(c(home_teams, away_teams))
tc = length(teams)
team_data <- data.frame("Team" = character(tc),
                        "Games" = numeric(tc),
                        "Wins" = numeric(tc),
                        "Losses" = numeric(tc),
                        "Ties" = numeric(tc),
                        stringsAsFactors = FALSE)
for(i in 1:length(teams)) {
  team = teams[i]

  
  home_games = home_teams == team
  home_wins = home_games & results$Home_Score > results$Away_Score
  home_losses = home_games & results$Home_Score < results$Away_Score
  home_ties = home_games & results$Home_Score == results$Away_Score
  
  away_games = away_teams == team
  away_wins = away_games & results$Away_Score > results$Home_Score
  away_losses = away_games & results$Away_Score < results$Home_Score
  away_ties = away_games & results$Home_Score == results$Away_Score
  
  team_data$Team[i] = team
  team_data$Games[i] = sum(c(home_games, away_games))
  team_data$Wins[i] = sum(c(home_wins, away_wins))
  team_data$Losses[i] = sum(c(home_losses, away_losses))
  team_data$Ties[i] = sum(c(home_ties, away_ties))
}
