library("scales")
source("./Picks.R")

check_whole <- function(description1, pct1, 
                        description2, pct2, 
                        description_expected = "all", pct_expected = 1) {
  writeLines(paste(description1, 
          " (", 
          percent(pct1),
          ") + ",
          description2,
          " (",
          percent(pct2),
          ") = ",
          percent(pct1 + pct2),
          " expected ",
          percent(pct_expected),
          " (",
          description_expected,
          ")")[1])
}

bad_rows = results[!(pick_home(results) | pick_away(results)),]
if(nrow(bad_rows) > 0) {
  print("BAD DATA!!!")
  print(bad_rows)
  print("\n")
}

#weighted
check_whole("Home Favorites", home_fav_pct, "Away Favorites", away_fav_pct)
check_whole("Home Favorites Cover", home_fav_pct * home_fav_covers_pct, 
            "Away Favorites Cover", away_fav_pct * away_fav_covers_pct, 
            "Favorites Cover", fav_covers_pct)
check_whole("Home Pick", pick_home_pct,
            "Away Pick", pick_away_pct)
check_whole("Favorite Pick", pick_fav_pct,
            "Underdog Pick", pick_dog_pct)
check_whole("Favorite Picks Correct", pick_fav_pct * pick_fav_correct_pct,
            "Underdog Picks Correct", pick_dog_pct * pick_dog_correct_pct,
            "Picks Correct", correct_picks_pct)