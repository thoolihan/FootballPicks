source("./Picks.R")

results_2014 = results[results$Year == 2014,]
games_by_week = aggregate(results_2014$Pick, by=list(Week = results$Week), FUN=length)
half <- games_by_week
half$x <- half$x * 0.5
res_by_wk = aggregate(results_2014$Correct, by=list(Week = results$Week), FUN=sum)
frame()
par(new=T, mfrow=c(1,1))
plot(res_by_wk, axes=F, type="b", xlim=c(1,21), ylim=c(0,16),
     main="Tim's 2014 NFL Pick Spread Results By Week", xlab="Week", ylab="Correct", col="Green")
lines(games_by_week, col="Blue", type="b")
lines(half, col="Gray", type="l")
axis(side=1, at=c(1:21))
axis(side=2, at=c(0:16))
legend(x=18, y=16, legend=c('Games', 'Correct', '50%'), fill=c('Blue', 'Green', 'Gray'))
box()
