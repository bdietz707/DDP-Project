library(shiny)
library(markdown)
shinyUI(pageWithSidebar(
    headerPanel("Boston Housing Data from UCI"),
    
    sidebarPanel(
        numericInput(inputId = "CRIM", label = h5("Crime Rate"), value = 0.005, min = 0, max = 100),
        numericInput(inputId = "ZN", label = h5("Zoned > 25k sf"), value = 15, min = 0, max = 100, step = 1),
        numericInput(inputId = "INDUSL", label = h5("Non-Residential %"), value = 2.5, min = 0, max = 100),
        numericInput(inputId = "CHAS", label = h5("Charles River Dummy Var"), value = 0, min = 0, max = 1, step = 1),
        numericInput(inputId = "NOX", label = h5("Nitric Oxides Conc."), value = 0.5, min = 0, max = 2.05, step = .05),
        numericInput(inputId = "RM", label = h5("Dwelling Rooms"), value = 7, min = 0),
        numericInput(inputId = "AGE", label = h5("% Older than 1940"), value = 50, min = 0, max = 100),
        numericInput(inputId = "DIS", label = h5("Distance to Employment"), value = 4, min = 0),
        numericInput(inputId = "RAD", label = h5("Highway Accessibility"), value = 1, min = 0),
        numericInput(inputId = "TAX", label = h5("Property Tax Rate"), value = 300, min = 0),
        numericInput(inputId = "PTRATIO", label = h5("Pupil-Teacher Ratio"), value = 15, min = 0, max = 200),
        numericInput(inputId = "LSTAT", label = h5("% Lower Status"), value = 5, min = 0, max = 100),
        actionButton(inputId = "refresh", label = "Run Regressions" ,  
                     icon = icon("fa fa-refresh")) 
    ),
    
    mainPanel(
        
        tabsetPanel(
            
            tabPanel("Regressions",
                     
                     h3('The Median Value of Homes'),
                     
                     h4('Partial Least Squares and Principal Component Regression Prediction'),
                     verbatimTextOutput("MVRpredict"),
                     h5('Partial Least Squares and Principal Component Regression RMSE'),
                     verbatimTextOutput("mvrRMSE"),
                     
                     h4('Robust Fitting of Linear Model Prediction'),
                     verbatimTextOutput("RLMpredict"),
                     h5('Robust Fitting of Linear Model RMSE'),
                     verbatimTextOutput("rlmRMSE"),
                     
                     h4('Linear Regression Predication'),
                     verbatimTextOutput("Linearpredict"), 
                     h5('Linear Regression RMSE'),
                     verbatimTextOutput("lmRMSE"),
                     
                     h4('Multivariate Adaptive Regression Splines Predication'),
                     verbatimTextOutput("Earthpredict"),
                     h5('Linear Regression RMSE'),
                     verbatimTextOutput("earthRMSE"),
                     
                     h4('Support Vector Machines Regression Predication'),
                     verbatimTextOutput("SVMpredict"),
                     h5('Support Vector Machines Regression RMSE'),
                     verbatimTextOutput("svmRMSE")
            ), 
            tabPanel("About", 
                     includeMarkdown("include.md"))              
        ))))
