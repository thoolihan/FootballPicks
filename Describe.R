library("rmarkdown")
library("scales")
source("./Picks.R")

fout <- "output/Results.Rmd"

write("# Results", fout)
write("## League Trends", fout, append=TRUE)
write(paste("- Games: ", games, sep=""), fout, append=TRUE)
write(paste("- Weeks: ", weeks, sep=""), fout, append=TRUE)
write(paste("- Favorite Covers: ", percent(fav_covers_pct), sep=""), fout, append=TRUE)
write(paste("- Home Favorite Covers: ", percent(home_fav_covers_pct), sep=""), fout, append=TRUE)
write(paste("- Away Favorite Covers: ", percent(away_fav_covers_pct), sep=""), fout, append=TRUE)
write("", fout, append=TRUE)

write("## Your Trends", fout, append=TRUE)

write("<table>", fout, append=TRUE)
write("<thead><tr><th>&nbsp;</th><th>Frequency</th><th>Accuracy</th></tr></thead>", fout, append=TRUE)
write("<tbody>", fout, append=TRUE)

describe <- function(category, frq, acc, file = fout) {
  w <- function(s) { write(s, file, append=TRUE) }
  w("<tr>")
  w(paste("<td>", category, "</td>", sep=""))
  w(paste("<td style='padding: 0 2em'>", percent(frq), "</td>", sep=""))
  w(paste("<td>", percent(acc), "</td>", sep=""))
  w("</tr>")
}

describe("All", 1, correct_picks_pct)
describe("Favorites", pick_fav_pct, pick_fav_correct_pct)
describe("Underdogs", pick_dog_pct, pick_dog_correct_pct)
describe("Home", pick_home_pct, pick_home_correct_pct)
describe("Away", pick_away_pct, pick_away_correct_pct)
describe("Home Favorites", pick_home_fav_pct, pick_home_fav_correct_pct)
describe("Away Favorites", pick_away_fav_pct, pick_away_fav_correct_pct)
describe("Home Underdogs", pick_home_dog_pct, pick_home_dog_correct_pct)
describe("Away Underdogs", pick_away_dog_pct, pick_away_dog_correct_pct)

write("</tbody></table>", fout, append=TRUE)

rmarkdown::render("output/Results.Rmd")