library(shiny)
library(readr)


# Variables 
survey <- read.csv("data/survey.csv")
introText <- read_file("intro.txt")

# UI
fluidPage(
  h1("Mental Health in the Tech Industry"), p("DataFriends"),
  hr(),
  
  tabsetPanel(
    # Introduction tab. Reads text from 'intro.txt'.
    tabPanel("Introduction", h2("Introduction"), p(introText), 
             a(href="https://www.kaggle.com/osmi/mental-health-in-tech-survey", "Kaggle: Mental Health in Tech Survey"), br()
             ),
    
    # Displays 
    tabPanel("Bar Graphs", sidebarLayout(
                              # Input
                              sidebarPanel(selectInput("xInput", label = "Choose a variable to display on the x axis.", choices = names(survey), selected = 'supervisor')),
                              # Output
                              mainPanel(plotOutput("bar"))
                          )
    ),

    tabPanel("Age Graphs", sidebarLayout(
                              #Input
                              sidebarPanel(),
                              mainPanel(),
    )),

    
    # Sentiment Analysis

    
    # Sentiment Analysis

    tabPanel("Sentiment Analysis", "contents")),
    
  # GitHub link
  hr(), a(href="https://github.com/hengsworld/DataFriends", "GitHub: DataFriends")
)


