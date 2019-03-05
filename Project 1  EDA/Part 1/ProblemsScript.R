# Problem 1

sales1<-c(12,14,16,29,30,45,19,20,16, 19, 34, 20)
sales2<-rpois(12,34) 

par(bg="cornsilk")

plot(sales1, col="blue", type="o", ylim=c(0,100), xlab="Month", ylab="Sales" )
title(main="Sales by Month")
lines(sales2, type="o", pch=22, lty=2, col="red")
grid(nx=NA, ny=NULL)
legend("topright", inset=.05, c("Sales1","Sales2"), fill=c("blue","red"), horiz=TRUE)


# Problem 2
sales<-read.table(file.choose(), header=T)
sales  # to verify that data has been read
barplot(as.matrix(sales), main="Sales Data", ylab= "Total",beside=T, col=rainbow(5))

# Problem 6

library("ggmap")
library("ggplot2")
library("maptools")
library(maps)
apiKey <- Sys.getenv("API_KEY")
apiKey
