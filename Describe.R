library("rmarkdown")
source("./Picks.R")

fout <- "Results.Rmd"

write("# Results", fout)
write("## League Trends", fout, append=TRUE)
write(c("- Games: ", games), fout, append=TRUE)
write(c("- Weeks: ", weeks), fout, append=TRUE)
write(c("- Favorite Covers: ", percent(fav_covers_pct)), fout, append=TRUE)
write(c("- Home Favorite Covers: ", percent(home_fav_covers_pct)), fout, append=TRUE)
write(c("- Away Favorite Covers: ", percent(away_fav_covers_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("## Your Trends", fout, append=TRUE)
write(c("- Correct Picks: ", percent(correct_picks_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Favorites*", fout, append=TRUE)
write(c("- Favorite Pick Frequency: ", percent(pick_fav_pct)), fout, append=TRUE)
write(c("- Favorite Pick Accuracy: ", percent(pick_fav_correct_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Underdogs*", fout, append=TRUE)
write(c("- Underdog Pick Frequency: ", percent(pick_dog_pct)), fout, append=TRUE)
write(c("- Underdog Pick Accuracy: ", percent(pick_dog_correct_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Home*", fout, append=TRUE)
write(c("- Home Pick Frequency: ", percent(pick_home_pct)), fout, append=TRUE)
write(c("- Home Pick Accuracy: ", percent(pick_home_correct_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Away*", fout, append=TRUE)
write(c("- Away Pick Frequency: ", percent(pick_away_pct)), fout, append=TRUE)
write(c("- Away Pick Accuracy: ", percent(pick_away_correct_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Home Favorites*", fout, append=TRUE)
write(c("- Home Favorite Pick Frequency: ", percent(pick_home_fav_pct)), fout, append=TRUE)
write(c("- Home Favorite Pick Accuracy: ", percent(pick_home_fav_correct_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Away Favorites*", fout, append=TRUE)
write(c("- Away Favorite Pick Frequency: ", percent(pick_away_fav_pct)), fout, append=TRUE)
write(c("- Away Favorite Pick Accuracy: ", percent(pick_away_fav_correct_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Home Underdogs*", fout, append=TRUE)
write(c("- Home Underdog Pick Frequency: ", percent(pick_home_fav_pct)), fout, append=TRUE)
write(c("- Home Underdog Pick Accuracy: ", percent(pick_home_fav_correct_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

write("### *Away Underdogs*", fout, append=TRUE)
write(c("- Away Underdog Pick Frequency: ", percent(pick_away_dog_pct)), fout, append=TRUE)
write(c("- Away Underdog Pick Accuracy: ", percent(pick_away_dog_correct_pct)), fout, append=TRUE)
write("\n", fout, append=TRUE)

rmarkdown::render("Results.Rmd")