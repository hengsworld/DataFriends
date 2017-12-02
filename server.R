library(shiny)
library(ggplot2)

# Variables
survey <- read.csv("data/survey.csv")

server <- function(input, output){
  # Bar graph output for bar tab
  output$bar <- renderPlot({
    
    xColumns <- input$xInput
    # Plot graph
    ggplot(survey, aes(survey[,xColumns])) + 
      geom_bar(aes(fill = mental_health_consequence), position = "stack") + 
      xlab(paste(input$xInput, "?", sep = "")) + 
      ggtitle(paste(input$xInput, "in survey dataset")) + 
      labs(fill="Mental Health Consequences?") + 
      theme_classic() + 
      theme(text = element_text(size=14),axis.text.x = element_text(angle=30, hjust=1)) 
    
  })#, output$sentiment <- renderPlot({}), output$XXXX <- renderXXXX({})
  
}

