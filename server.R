library(shiny)

training <- read.csv("pml-training.csv")
testing <- read.csv("pml-testing.csv")

set.seed(123)
#reduce the number of samples to reduce the computing time
trainingind <- sample(x = 1:nrow(training), size = 2000, replace = F)
training <- training[trainingind,]

cntr <- colnames(training)
cnte <- colnames(testing)

cntr[which(!cntr %in% cnte)]
cnte[which(!cnte %in% cntr)]

training <- training[, -seq(from = 1, to = 8, by = 1)]
testing <- testing[, -seq(from = 1, to = 8, by = 1)]

training <- training[,colSums(is.na(testing)) < nrow(testing)]
testing <- testing[,colSums(is.na(testing)) < nrow(testing)]

library(caret)

library(doParallel)
cl <- makeCluster(2)
registerDoParallel(cl)

fitControl <- trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  ## repeated ten times
  repeats = 10)


training <- training[,c("pitch_forearm","yaw_belt","magnet_dumbbell_z","pitch_belt","magnet_dumbbell_y","accel_belt_z","roll_forearm","magnet_belt_y","roll_dumbbell","accel_dumbbell_y","classe")]


shinyServer(function(input, output) {
  

  #trrf <- train(classe ~ ., data = training, method = input$method)
                #, trControl = fitControl
  
  output$modeltext <- renderPrint({
    trrf <- train(classe ~ ., data = training, method = input$method)
    trrf
  })
  output$modelplot <- renderPlot({
    plot(trrf)
    
    })
  
  output$vi <- renderPrint({varImp(trrf)})
  #```
  #Random Forest does implicit cross validation, so there is no additional effort for that.
  #With an Prediction Accuracy of 98% the Random Forest modell fits pretty good to this data
  #The Out of sample error will therefor in the best case be arround 2% but more likely a bit more.
  #```{r}
  
  #pr <- predict(trrf, newdata = testing)
  
})