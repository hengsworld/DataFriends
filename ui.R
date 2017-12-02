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
    tabPanel("Introduction", h2("Introduction"), introText),
    
    # Displays 
    tabPanel("Bar Graphs", sidebarLayout(
                              # Input
                              sidebarPanel(selectInput("xInput", label = "Choose a variable to display on the x axis.", choices = names(survey), selected = 'remote_work')),
                              # Output
                              mainPanel(plotOutput("bar"))
                          )
    ),
    
    # Sentiment Analysis
    tabPanel("Sentiment Analysis", "contents")),
  
  # GitHub link
  a(href="https://github.com/hengsworld/DataFriends", "GitHub")
)


