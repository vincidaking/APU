library(caret)
file_data <- read.csv("monitors.csv")

dataset <- file_data
train_data_precent <- 0.7
ind <- createDataPartition(dataset, p = train_data_precent, list = F)
train_data <- dataset[ind,]
test_data<- dataset[-ind,]


dataset$Ocena <- as.factor(dataset$Ocena)

#create rpart tree
library(rpart)
library(rpart.plot)
train_data_rpart <- rpart(Ocena  ~Cena, data = train_data)
test_data_rpart <- rpart(Ocena ~Cena, data = test_data)
rpart.plot(train_data_rpart)
train_data_rpart


#create binary tree
#library(party)
#train_data_ctree <- ctree(cena ~ ., data = train_data)
#test_data_ctree <- ctree(cena ~ ., data = test_data)
#plot(train_data_ctree)

dataset$Ocena <- as.factor(dataset$Ocena)

library(mlr)
listLearners()
#create task for dataset
task <- makeClassifTask(id = 'dataset', data = dataset, target = "Ocena");
lrn <- makeLearner("classif.rpart", predict.type = "prob")
rdesc = makeResampleDesc("Bootstrap", iters = 100)
r = resample(learner = lrn, task = task, resampling = rdesc, show.info = T)

library(C50)
library(rFerns)
library(randomForestSRC)
lrns <- makeLearners(c("rpart", "C50","rFerns","randomForestSRC"), type = "classif")
benchmark_result <- benchmark(learners = lrns, tasks = task, resampling = cv5)

plt = plotBMRBoxplots(benchmark_result, measure = mmce, order.lrn = getBMRLearnerIds(benchmark_result))
levels(plt$data$task.id) = c("genotype")
levels(plt$data$learner.id) = c("rpart", "C50","rFerns","randomForestSRC")

plt + ylab("Error rate")

