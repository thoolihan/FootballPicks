library("scales")

nfl = read.csv("NFL_Picks.csv")
results = nfl[complete.cases(nfl),]
n_results = nrow(results)

n_correct = sum(results$Correct)
correct_picks_pct = percent(n_correct / n_results)

v_away_covers = results$Away_Score > (results$Home_Score + results$Spread) & results$Favorite == 'A'
v_home_covers = results$Home_Score > (results$Away_Score + results$Spread) & results$Favorite == 'H'
n_home_fav_covers = sum(v_home_covers)
n_away_fav_covers = sum(v_away_covers)

#your home picks
v_pick_home = (as.character(results$Pick) == as.character(results$Home_Team))
v_pick_home_correct = v_pick_home & v_home_covers
n_pick_home = sum(v_pick_home)
pick_home_pct = percent(n_pick_home / n_results)
pick_home_correct_pct = percent(sum(v_pick_home_correct) / n_pick_home)

#your away picks
v_pick_away = (as.character(results$Pick) == as.character(results$Away_Team))
v_pick_away_correct = v_pick_away & v_away_covers
n_pick_away = sum(v_pick_away)
pick_away_pct = percent(n_pick_away / n_results)
pick_away_correct_pct = percent(sum(v_pick_away_correct) / n_pick_away)

#your favorite picks
v_pick_home_fav = (results$Favorite == 'H') & v_pick_home
v_pick_away_fav = (results$Favorite == 'A') & v_pick_away
v_pick_fav = v_pick_home_fav | v_pick_away_fav
v_pick_fav_correct = v_pick_fav & (v_home_covers | v_away_covers)
n_pick_fav = sum(v_pick_fav)
pick_fav_pct = percent(n_pick_fav / n_results)
pick_fav_correct_pct = percent(sum(v_pick_fav_correct) / n_pick_fav)

#your home favorite picks
n_pick_home_fav = sum(v_pick_home_fav)
pick_home_fav_pct = percent(n_pick_home_fav / n_results)
pick_home_fav_correct_pct = percent(sum(v_pick_home_fav & v_home_covers) / n_pick_home_fav)

#your away favorite picks
n_pick_away_fav = sum(v_pick_away_fav)
pick_away_fav_pct = percent(n_pick_away_fav / n_results)
pick_away_fav_correct_pct = percent(sum(v_pick_away_fav & v_away_covers) / n_pick_away_fav)

#your underdog picks
v_pick_home_dog = (results$Favorite == 'A') & (as.character(results$Pick) == as.character(results$Home_Team))
v_pick_away_dog = (results$Favorite == 'H') & (as.character(results$Pick) == as.character(results$Away_Team))
v_pick_dog = v_pick_home_dog | v_pick_away_dog
v_pick_dog_correct = v_pick_dog & !(v_home_covers | v_away_covers)
n_pick_dog = sum(v_pick_dog)
pick_dog_pct = percent(n_pick_dog / n_results)
pick_dog_correct_pct = percent(sum(v_pick_dog_correct) / n_pick_dog)

# how many home teams that are favored cover
home_fav_covers = percent(n_home_fav_covers / sum(results$Favorite == 'H'))
# how many away teams that are favored cover
away_fav_covers = percent(n_away_fav_covers / sum(results$Favorite == 'A'))
#how many favored teams cover
fav_covers = percent((n_home_fav_covers + n_away_fav_covers) / n_results)
