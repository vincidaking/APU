#a
a <- 2 / (3 ** 2)
b <- 2 * a
max(a, b)
a > b
b < a

#b
? median
help(median)

#c
vector <- c(80:175)
vector
avg <- mean(vector)
avg

#e
a <- "monitor LED"
fileName <- "output.txt"
fileConn <- file(fileName)
writeLines(a, fileConn)
close(fileConn)

remove(a)
a <- read.table(fileName)
a

#f
gridExtra::grid.table(women[1:10,])

#g
vecSeq <- seq(100, 20, -8)

#h
first <- c(500:30)
sec <- c(40:50)
sum <- append(sec, first)
sum

#i
names <- c("monitor 1", "monitor 2",
           "monitor 3", "monitor 4", 
           "monitor 5", "monitor 6", 
           "monitor 7", "monitor 8", 
           "monitor 9", "monitor 10")
matryca <- c(10, 10, 10, 30, 30, 20, 20, 14, 14, 13)
jasnosc <- c(1:10)
czas <- c(10:1)
cena <- seq(0, 27, 3)
opinie <- seq(100, 10, -10)

monitory <- data.frame(Matryca = names,
                       wielkosc = matryca, 
                       jasnosc, czas, cena, opinie)
monitory

mean(monitory$cena)

#j
newMonitorRecord <- data.frame("Monitor 11", 10, 11, 
                               0, 30, 0)
names(newMonitorRecord)<-names(monitory)
monitory <- rbind(monitory, newMonitorRecord)
mean(monitory$cena)

#k
ocenaKlientów<- seq(0, 5, 0.5)
monitory$ocenaKlientow = ocenaKlientów
monitory
aggregate(monitory, by=list(monitory$ocenaKlientow),
          FUN=mean)

#l
newMonitorRecord2 <- data.frame("Monitor 12",
                                10, 12, 0, 10, 0, 0)
names(newMonitorRecord2)<-names(monitory)
newMonitorRecord3 <- data.frame("Monitor 13",
                                10, 13, 0, 30, 0, 2)
names(newMonitorRecord3)<-names(monitory)
newMonitorRecord4 <- data.frame("Monitor 14", 
                                10, 14, 0, 20, 0, 2)
names(newMonitorRecord4)<-names(monitory)
newMonitorRecord5 <- data.frame("Monitor 15", 
                                10, 15, 0, 30, 0, 3)
names(newMonitorRecord5)<-names(monitory)

monitory <- rbind(monitory, newMonitorRecord2)
monitory <- rbind(monitory, newMonitorRecord3)
monitory <- rbind(monitory, newMonitorRecord4)
monitory <- rbind(monitory, newMonitorRecord5)
monitory

#m
ocenyGrupy <- aggregate(monitory, 
                        by=list(monitory$ocenaKlientow), 
                        FUN = length)
ocenyGrupy
library(plotrix)
plotrix <- barp(ocenyGrupy$ocenaKlientow)  

#n
pie3D(ocenyGrupy$Group)

#p
write.csv(monitory,"monitors.csv")

