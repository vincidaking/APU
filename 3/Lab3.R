library(neuralnet)
library(ggplot2)

dataset <- read.csv("monitors.csv");
#train_data <- file_data['wielkosc':'ocenaKlientow'];

normalize <- function(x) return (x / max(x));
dataset_normalized <- as.data.frame(lapply(dataset, normalize))
dataset_normalized <- dataset_normalized[sample(1:nrow(dataset_normalized)), ]

library(neuralnet)
n <- nrow(dataset_normalized)
train_data_precent <- 0.7
train_data <- dataset_normalized[1:(n * train_data_precent),]
test_data <- dataset_normalized[1:(n * (1 -train_data_precent)),]
set.seed(2)
nn <- neuralnet(Cena ~., data=train_data, hidden=c(100, 50 ,25), threshold=0.001, linear.output = F)
plot(nn)

result <- compute(nn, test_data)
calculated_x <- as.numeric(test_data$Cena)
calculated_y <- result[["net.result"]]
plot(calculated_x, calculated_y)

error <- sqrt(sum((as.numeric(test_data$Cena)-calculated_y)^2)/length(calculated_y))
