library(dplyr)

nfl <- read.csv("data/Brad.csv")
results <- nfl[complete.cases(nfl[,c("Home_Score", "Away_Score")]),]

# add virtual columns
results$Home_Score_Adj <- numeric(nrow(results))
results$Away_Score_Adj <- numeric(nrow(results))
results$Winner <- character(nrow(results))
results$SpreadWinner <- character(nrow(results))

# create spread adjusted scores
hf <- results$Favorite == 'H'
af <- results$Favorite == 'A'

results[hf,]$Home_Score_Adj <- results[hf,]$Home_Score - results[hf,]$Spread
results[hf,]$Away_Score_Adj <- results[hf,]$Away_Score

results[af,]$Away_Score_Adj <- results[af,]$Away_Score - results[af,]$Spread
results[af,]$Home_Score_Adj <- results[af,]$Home_Score

# calculate winners
select_winner <- function(home_score, away_score, home_team, away_team) {
  if(home_score > away_score) return(as.character(home_team))
  if(away_score > home_score) return(as.character(away_team))
  return('TIE')
}

results$Winner <- mapply(select_winner, results$Home_Score, results$Away_Score, results$Home_Team, results$Away_Team)
results$SpreadWinner <- mapply(select_winner, results$Home_Score_Adj, results$Away_Score_Adj, results$Home_Team, results$Away_Team)

# calculate correct column
results$Correct <- mapply(function(winner, pick) {
                            as.character(winner) %in% c(as.character(pick), 'TIE')
                            }, results$SpreadWinner, results$Pick)


any_pick <- function(g) { g$Year == g$Year }
correct_pick <- function(g) { g$Correct }
home_fav <- function(g) { g$Favorite == 'H' }
away_fav <- function(g) { g$Favorite == 'A' }
home_fav_covers <- function(g) { g$Home_Score > (g$Away_Score + g$Spread) & home_fav(g) }
away_fav_covers <- function(g) { g$Away_Score > (g$Home_Score + g$Spread) & away_fav(g) }
fav_covers <- function(g) { home_fav_covers(g) | away_fav_covers(g) }
pick_home <- function(g) { as.character(g$Pick) == as.character(g$Home_Team) }
pick_away <- function(g) { as.character(g$Pick) == as.character(g$Away_Team) }
pick_favorite <- function (g) { (home_fav(g) & pick_home(g)) | (away_fav(g) & pick_away(g)) }
pick_underdog <- function (g) { !pick_favorite(g) }
pick_home_favorite <- function(g) { pick_home(g) & pick_favorite(g) }
pick_away_favorite <- function(g) { pick_away(g) & pick_favorite(g) }
pick_home_dog <- function(g) { pick_home(g) & pick_underdog(g) }
pick_away_dog <- function(g) { pick_away(g) & pick_underdog(g) }

condition_frequency <- function(data, subset_condition = any_pick) {
  sum(subset_condition(data))
}

condition_percentage <- function(data,
                                 set_condition = any_pick,
                                 subset_condition = correct_pick) {
  subset_filter <- function(g) { set_condition(g) & subset_condition(g) }
  condition_frequency(data, subset_filter) / condition_frequency(data, set_condition)
}

#league trends
games <- condition_frequency(results)
weeks <- length(unique(results$Week))

home_fav_pct <- condition_percentage(results, subset_condition = home_fav)
home_fav_covers_pct <- condition_percentage(results, set_condition = home_fav,
                                            subset_condition = home_fav_covers)

away_fav_pct <- condition_percentage(results, subset_condition = away_fav)
away_fav_covers_pct <- condition_percentage(results, set_condition = away_fav, subset_condition = away_fav_covers)

fav_covers_pct <- condition_percentage(results, subset_condition = fav_covers)

#your trends
correct_picks_pct <- condition_percentage(results)

pick_home_pct <- condition_percentage(results, subset_condition = pick_home)
pick_home_correct_pct <- condition_percentage(results, set_condition = pick_home)

pick_away_pct <- condition_percentage(results, subset_condition = pick_away)
pick_away_correct_pct <- condition_percentage(results, set_condition = pick_away)

pick_fav_pct <- condition_percentage(results, subset_condition = pick_favorite)
pick_fav_correct_pct <- condition_percentage(results, set_condition = pick_favorite)

pick_dog_pct <- condition_percentage(results, subset_condition = pick_underdog)
pick_dog_correct_pct <- condition_percentage(results, set_condition = pick_underdog)

pick_home_fav_pct <- condition_percentage(results, subset_condition = pick_home_favorite)
pick_home_fav_correct_pct <- condition_percentage(results, set_condition = pick_home_favorite)

pick_away_fav_pct <- condition_percentage(results, subset_condition = pick_away_favorite)
pick_away_fav_correct_pct <- condition_percentage(results, set_condition = pick_away_favorite)

pick_home_dog_pct <- condition_percentage(results, subset_condition = pick_home_dog)
pick_home_dog_correct_pct <- condition_percentage(results, set_condition = pick_home_dog)

pick_away_dog_pct <- condition_percentage(results, subset_condition = pick_away_dog)
pick_away_dog_correct_pct <- condition_percentage(results, set_condition = pick_away_dog)
