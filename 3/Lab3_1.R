library(neuralnet)
library(ggplot2)

function_ <- function(x) (sin(x) ^ cos(x));
stat_point <- 0
end_point <- pi
n <- 1000

inputs <- runif(n, stat_point, end_point)
outputs <- function_(inputs)
plot(inputs, outputs)
scaled_inputs = inputs / max(inputs)
scaled_outputs = outputs / max(outputs)
plot(scaled_inputs, scaled_outputs)

library(neuralnet)
dataset <- data.frame(inputs=scaled_inputs, outputs= scaled_outputs)
train_data_precent <- 0.7
train_data <- dataset[1:(n * train_data_precent),]
test_data <- dataset[1:(n * (1 -train_data_precent)),]
set.seed(2)
nn <- neuralnet(outputs ~ inputs, data=train_data, hidden=c(50, 30, 20), threshold=0.0001, linear.output = F)
plot(nn)
result <- compute(nn, test_data[1])
calculated_x <- as.numeric(test_data$inputs)
calculated_y <- result[["net.result"]]
plot(calculated_x, calculated_y)

error <- sqrt(sum((as.numeric(test_data$outputs)-calculated_y)^2)/length(calculated_y))

