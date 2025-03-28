library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Enhanced Linear Regression Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", choices = c("mtcars", "iris")),
      uiOutput("var_select_x"),
      uiOutput("var_select_y"),
      sliderInput("conf_level", "Confidence Interval Level:", min = 0.80, max = 0.99, value = 0.95),
      checkboxInput("show_summary", "Show Model Summary", FALSE)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Regression Output",
                 verbatimTextOutput("model_eq"),
                 conditionalPanel(condition = "input.show_summary == true",
                                  verbatimTextOutput("model_summary")),
                 plotOutput("scatterPlot")),
        tabPanel("Help", 
                 h3("How to Use the App"),
                 p("1. Select a dataset."),
                 p("2. Choose predictor and response variables."),
                 p("3. Adjust the confidence interval if needed."),
                 p("4. View regression equation and scatter plot."),
                 p("5. Enable 'Show Model Summary' for detailed results.")
        )
      )
    )
  )
)

# Define Server Logic
server <- function(input, output, session) {
  
  datasetInput <- reactive({
    get(input$dataset)
  })
  
  output$var_select_x <- renderUI({
    selectInput("xvar", "Choose Predictor Variable:", 
                choices = names(datasetInput()), selected = names(datasetInput())[1])
  })
  
  output$var_select_y <- renderUI({
    selectInput("yvar", "Choose Response Variable:", 
                choices = names(datasetInput()), selected = names(datasetInput())[2])
  })
  
  model <- reactive({
    req(input$xvar, input$yvar)
    lm(as.formula(paste(input$yvar, "~", input$xvar)), data = datasetInput())
  })
  
  output$model_eq <- renderText({
    coef_vals <- coef(model())
    paste("Regression Equation: ", input$yvar, "=", 
          round(coef_vals[1], 2), "+", round(coef_vals[2], 2), "*", input$xvar)
  })
  
  output$model_summary <- renderPrint({
    summary(model())
  })
  
  output$scatterPlot <- renderPlot({
    data <- datasetInput()
    plot(data[[input$xvar]], data[[input$yvar]], main="Scatter Plot with Regression Line",
         xlab=input$xvar, ylab=input$yvar, pch=19, col="blue")
    abline(model(), col="red", lwd=2)
    
    # Add confidence interval
    conf <- predict(model(), interval="confidence", level=input$conf_level)
    lines(data[[input$xvar]], conf[, "lwr"], col="grey", lty=2)
    lines(data[[input$xvar]], conf[, "upr"], col="grey", lty=2)
  })
}

# Run the application
shinyApp(ui = ui, server = server)

>
