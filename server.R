library(UsingR)
library(shiny)
library(e1071)
library(earth)
library(MASS)
library(pls) 
library(caret)

housing<-read.csv("Housing.csv", header = TRUE)

Linear_model <- lm(MEDV~CRIM+ZN+INDUS+CHAS+NOX+RM+AGE+DIS+RAD+TAX+PTRATIO+LSTAT,data=housing)
RLM_model <- rlm(MEDV~CRIM+ZN+INDUS+CHAS+NOX+RM+AGE+DIS+RAD+TAX+PTRATIO+LSTAT,data=housing)
EARTH_model <- earth(MEDV~CRIM+ZN+INDUS+CHAS+NOX+RM+AGE+DIS+RAD+TAX+PTRATIO+LSTAT,data=housing)
MVR_model <- mvr(MEDV~CRIM+ZN+INDUS+CHAS+NOX+RM+AGE+DIS+RAD+TAX+PTRATIO+LSTAT,data=housing)
SVM_model <- svm(MEDV~CRIM+ZN+INDUS+CHAS+NOX+RM+AGE+DIS+RAD+TAX+PTRATIO+LSTAT,data=housing)

lmtest_pred <- predict(Linear_model, housing)
lmRMSE <- RMSE(lmtest_pred, housing$MEDV)

rlmtest_pred <- predict(RLM_model, housing)
rlmRMSE <- RMSE(rlmtest_pred, housing$MEDV)

earthtest_pred <- predict(EARTH_model, housing)
earthRMSE <- RMSE(earthtest_pred, housing$MEDV)

mvrtest_pred <- predict(MVR_model, housing)
mvrRMSE <- RMSE(mvrtest_pred, housing$MEDV)

svmtest_pred <- predict(SVM_model, housing)
svmRMSE <- RMSE(svmtest_pred, housing$MEDV)

shinyServer(
  function(input, output) {
    
    Rawdata <- reactive({ 
      input$refresh  
      
      CRIM <- input$CRIM
      ZN <- input$ZN
      INDUS <- input$INDUSL
      CHAS <- input$CHAS
      NOX <- input$NOX
      RM <- input$RM
      AGE <- input$AGE
      DIS <- input$DIS
      RAD <- input$RAD
      TAX <- input$TAX
      PTRATIO <- input$PTRATIO
      LSTAT <- input$LSTAT
      
      data.frame(CRIM = CRIM,ZN = ZN,INDUS = INDUS, CHAS = CHAS,NOX = NOX,RM = RM,AGE = AGE,DIS = DIS,RAD = RAD,TAX = TAX,PTRATIO = PTRATIO,LSTAT = LSTAT)
      })

    output$Linearpredict <- renderPrint(predict(Linear_model, newdata = Rawdata())[[1]])
    output$RLMpredict <- renderPrint({predict(RLM_model, newdata = Rawdata())[[1]]})
    output$Earthpredict <- renderPrint({predict(EARTH_model, newdata = Rawdata())[[1]]})
    output$MVRpredict <- renderPrint({predict(MVR_model, newdata = Rawdata())[[1]]})
    output$SVMpredict <- renderPrint({predict(SVM_model, newdata = Rawdata())[[1]]})

    output$lmRMSE <- renderPrint(lmRMSE)
    output$rlmRMSE <- renderPrint(rlmRMSE)
    output$earthRMSE <- renderPrint(earthRMSE)
    output$mvrRMSE <- renderPrint(mvrRMSE)
    output$svmRMSE <- renderPrint(svmRMSE)
    
   })
