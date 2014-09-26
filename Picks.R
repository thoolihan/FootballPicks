library("scales")
setwd("C:/Workspace/FootballPicks")

nfl = read.csv("C:/Workspace/FootballPicks/NFL_Picks.csv")
results = nfl[complete.cases(nfl),]
n_results = nrow(results)

n_correct = sum(results$Correct)
correct_picks_pct = percent(n_correct / n_results)

v_away_covers = results$Away_Score > (results$Home_Score + results$Spread)
v_home_covers = results$Home_Score > (results$Away_Score + results$Spread)

n_home_fav_covers = sum(v_home_covers & results$Favorite == 'H')
n_away_fav_covers = sum(v_away_covers & results$Favorite == 'A')

# how many home teams that are favored cover
home_fav_covers = percent(n_home_fav_covers / sum(results$Favorite == 'H'))
# how many away teams that are favored cover
away_fav_covers = percent(n_away_fav_covers / sum(results$Favorite == 'A'))
#how many favored teams cover
fav_covers = percent((n_home_fav_covers + n_away_fav_covers) / n_results)

#plot results
results_2014 = results[results$Year == 2014,]
games_by_week = aggregate(results_2014$Pick, by=list(Week = results$Week), FUN=length)
res_by_wk = aggregate(results_2014$Correct, by=list(Week = results$Week), FUN=sum)
frame()
par(new=T)
plot(res_by_wk, axes=F, type="b", xlim=c(1,21), ylim=c(0,16),
     main="Tim's 2014 NFL Pick results By Week", xlab="Week", ylab="Correct", col="Green")
lines(games_by_week, col="Blue", type="b")
axis(side=1, at=c(1:21))
axis(side=2, at=c(0:16))
legend(x=18, y=16, legend=c('Games', 'Correct'), fill=c('Blue', 'Green'))
box()