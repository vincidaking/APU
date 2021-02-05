library(MASS)


#split database for train i test
library(caret)
data(genotype)
train_data_precent <- 0.8
ind <- createDataPartition(genotype$Mother, p = train_data_precent, list = FALSE)
train_data <- genotype[ind,]
test_data<- genotype[-ind,]
#n <- nrow(dataset)
#train_data <- dataset[1:(n * train_data_precent),]
#test_data <- dataset[1:(n * (1 -train_data_precent)),]

#create rpart tree
library(rpart)
library(rpart.plot)
train_data_rpart <- rpart(Wt ~ ., data = train_data)
test_data_rpart <- rpart(Wt ~ ., data = test_data)
rpart.plot(train_data_rpart)

#create binary tree
#library(party)
#train_data_ctree <- ctree(Wt ~ ., data = train_data)
#test_data_ctree <- ctree(Wt ~ ., data = test_data)
#plot(train_data_ctree)


listLearners()
#create task for dataset
task <- makeClassifTask(id = 'dataset', data = genotype, target = "Mother");
lrn <- makeLearner("classif.rpart", predict.type = "prob")
rdesc = makeResampleDesc(method = "CV", stratify = TRUE)
r = resample(learner = lrn, task = task, resampling = rdesc, show.info = T)

library(C50)
library(rFerns)
library(randomForestSRC)
lrns <- makeLearners(c("lda","rpart", "C50","rFerns","randomForestSRC"), type = "classif")
benchmark_result <- benchmark(learners = lrns, tasks = task, resampling = cv5)

plt = plotBMRBoxplots(benchmark_result, measure = mmce, order.lrn = getBMRLearnerIds(benchmark_result))
head(plt$data[, -ncol(plt$data)])
levels(plt$data$task.id) = c("genotype")
levels(plt$data$learner.id) = c("lda","rpart", "C50","rFerns","randomForestSRC")

plt + ylab("Error rate")

