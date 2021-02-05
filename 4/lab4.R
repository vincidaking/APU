library(MASS)


#split database for train i test
library(caret)
file_data <- read.csv("monitors.csv")

train_data_precent <- 0.7
ind <- createDataPartition(file_data, p = train_data_precent, list = F)
train_data <- dataset[ind,]
test_data<- dataset[-ind,]

library(C50)
oneTree <- C5.0(formula = Ocena ~ ., data = train_data)
summary(oneTree)
plot(oneTree)

library(e1071)
bstTreePred <- predict(oneTree, test_data)
postResample(bstTreePred, test_data$Ocena)
