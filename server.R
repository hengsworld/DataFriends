library(shiny)

library(ggplot2)

survey <- read.csv("data/survey.csv")

server <- function(input, output){
  output$bar <- renderPlot({
    xColumns <- input$xInput
    
    # Plot graph
    ggplot(survey, aes(survey[,xColumns])) + geom_bar(aes(fill = mental_health_consequence), position = "stack")
    
  })
}

