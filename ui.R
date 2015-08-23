library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Compare modelling methods"),
  
  sidebarPanel(selectInput(inputId = "method", label = "Select your prediction method and see how it performs", choices = c("rpart", "rf", "xyf")), "There are three choices: rpart(Classification and regression trees), rf(Random Forest) and xyf(Self-Organizing Maps). The data is the data from the coursera practical machine learning task for prediction and shows the correct execution of sport with attributes measured through fitness watches and beltsThe training data for this project are available here:
               https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv
               The test data are available here:
               https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv
               The data for this project comes from this original source: http://groupware.les.inf.puc-rio.br/har. If you use the document you create for this class for any purpose please cite them as they have been very generous in allowing their data to be used for this kind of assignment. 
               modeling is only done on training data, not even on test data."),
  
  mainPanel(verbatimTextOutput("modeltext"), plotOutput("modelplot"), verbatimTextOutput("vi"))
  #,textOutput("modeltext")
  
))
#"Start with an exploration, then using caret, rpart and random forest for the prediction and doParallel for lower waiting times."