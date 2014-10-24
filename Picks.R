nfl = read.csv("NFL_Picks.csv")
results = nfl[complete.cases(nfl),]

any_pick <- function(g) { g$Year == g$Year }
correct_pick <- function(g) { g$Correct }
home_fav <- function(g) { g$Favorite == 'H' }
away_fav <- function(g) { g$Favorite == 'A' }
home_fav_covers <- function(g) { g$Home_Score > (g$Away_Score + g$Spread) & home_fav(g) }
away_fav_covers <- function(g) { g$Away_Score > (g$Home_Score + g$Spread) & away_fav(g) }
fav_covers <- function(g) { home_covers(g) | away_covers(g) }
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
home_fav_covers_pct <- condition_percentage(results, set_condition = home_fav, subset_condition = home_covers)

away_fav_pct <- condition_percentage(results, subset_condition = away_fav)
away_fav_covers_pct <- condition_percentage(results, set_condition = away_fav, subset_condition = away_covers)

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
