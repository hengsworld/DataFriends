library(shiny)
library(readr)


# Variables 
survey <- read.csv("data/FilteredData.csv")

# UI
fluidPage(
  h1("Mental Health in the Tech Industry"), p("DataFriends"),
  hr(),
  
  tabsetPanel(
    # Introduction tab. Reads text from 'intro.txt'.
    tabPanel("Introduction", includeMarkdown("INTRO.md")),
    
    # Displays 
    tabPanel("Bar Graphs", sidebarLayout(
                              # Input
                              sidebarPanel(selectInput("xInput", label = "Choose a variable to display on the x axis.", choices = names(survey), selected = 'supervisor')),
                              # Output
                              mainPanel(plotOutput("bar"))
                          )
    ),

    tabPanel("Dynamic user interface - RenderUI", sidebarLayout(
                              #Input
                              sidebarPanel(
                                uiOutput("vx"),
                                br(),
                                uiOutput("vy")),
                              mainPanel(
                                plotOutput("p")),
    )),

    
    # Sentiment Analysis

    
    # Sentiment Analysis

    tabPanel("Sentiment Analysis", "contents")),
    
  # GitHub link
  hr(), a(href="https://github.com/hengsworld/DataFriends", "GitHub: DataFriends")
)


