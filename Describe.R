library("rmarkdown")
source("./Picks.R")

fout <- "Results.Rmd"

write("# Results", fout)
write("## League Trends", fout, append=TRUE)
write(c("- Favorite Covers: ", fav_covers), fout, append=TRUE)
write(c("- Home Favorite Covers: ", home_fav_covers), fout, append=TRUE)
write(c("- Away Favorite Covers: ", away_fav_covers), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("## Your Trends", fout, append=TRUE)
write(c("- Correct Picks: ", correct_picks_pct), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Favorites*", fout, append=TRUE)
write(c("- Favorite Pick Frequency: ", pick_fav_pct), fout, append=TRUE)
write(c("- Favorite Pick Accuracy: ", pick_fav_correct_pct), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Underdogs*", fout, append=TRUE)
write(c("- Underdog Pick Frequency: ", pick_dog_pct), fout, append=TRUE)
write(c("- Underdog Pick Accuracy: ", pick_dog_correct_pct), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Home*", fout, append=TRUE)
write(c("- Home Pick Frequency: ", pick_home_pct), fout, append=TRUE)
write(c("- Home Pick Accuracy: ", pick_home_correct_pct), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Away*", fout, append=TRUE)
write(c("- Away Pick Frequency: ", pick_away_pct), fout, append=TRUE)
write(c("- Away Pick Accuracy: ", pick_away_correct_pct), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Home Favorites*", fout, append=TRUE)
write(c("- Home Favorite Pick Frequency: ", pick_home_fav_pct), fout, append=TRUE)
write(c("- Home Favorite Pick Accuracy: ", pick_home_fav_correct_pct), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Away Favorites*", fout, append=TRUE)
write(c("- Away Favorite Pick Frequency: ", pick_away_fav_pct), fout, append=TRUE)
write(c("- Away Favorite Pick Accuracy: ", pick_away_fav_correct_pct), fout, append=TRUE)
write("\n", fout, append=TRUE)

rmarkdown::render("Results.Rmd")