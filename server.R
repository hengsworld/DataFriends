library(shiny)
library(ggplot2)

# Variables
survey <- read.csv("data/FilteredData.csv")
states <- survey %>%  filter(!is.na(state)) %>% select(state) 
state_prefs <- survey %>% select(self_employed, family_history, treatment, remote_work, benefits) %>% na.omit()   
server <- function(input, output){
  # Bar graph output for bar tab
  
  output$intro <- renderText({""})
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
  output$vx <- renderUI({
    selectInput("vx", "select the first (x) variable", choices = distinct(states))
  })
  
  output$vy <- renderUI({
    selectInput("vy", "select the first (y) variable", choices = c("Self-employed"="self_employed", "Family history"="family_history", "Treatment"="treatment", "Remote Work"="remote_work", "Benefits"="benefits"))
  })

  output$p <- renderPlot({
    ggplot(survey, aes(x=survey[,input$vy], fill=survey[,input$vy])) + geom_bar() + labs(x=input$vy) + coord_flip()
  })
}