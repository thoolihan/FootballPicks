source("Teams.R")

par(mfrow=c(1,2))
covers <- team_data
covers$FavCoverPct <- ifelse(is.na(covers$FavCoverPct), 0.0, covers$FavCoverPct)
covers <- covers[order(covers$FavCoverPct),]
with(covers, {
  dotchart(FavCoverPct * 100, labels = Team, 
           main="% Covering The Spread", xlab="Cover %",
           xaxt="n", col="red")
})

upsets <- team_data
upsets$UpsetPct <- ifelse(is.na(upsets$UpsetPct), 0.0, upsets$UpsetPct)
upsets <- upsets[order(upsets$UpsetPct),]
with(upsets, {
  dotchart(UpsetPct * 100, labels = Team, 
           main="% Upset When UnderDog", xlab="Upset %",
           xaxt="n", col="blue")
})