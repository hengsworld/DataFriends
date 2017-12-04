library(shiny)
library(readr)


# Variables 
survey <- read.csv("data/survey.csv")

# UI
fluidPage(
  h1("Mental Health in the Tech Industry"), p("DataFriends"),
  hr(),
  
  tabsetPanel(
    # Introduction tab. Reads text from 'intro.txt'.
    tabPanel("Introduction", includeMarkdown("INTRO.md")),
    
    # Displays 
    tabPanel("Bar Graphs", verticalLayout(h3("Survey Categories and Mental Health Consequences"),
      sidebarLayout(
        # Input
        sidebarPanel(selectInput("xInput", label = "Choose a variable to display on the x axis.", choices = names(survey), selected = 'supervisor')),
        # Output
        mainPanel(plotOutput("bar"))
    ))),

    tabPanel("Age Graphs", sidebarLayout(
                              #Input
                              sidebarPanel(),
                              mainPanel()
    )),
    
    tabPanel("Maps", verticalLayout(
      #Input
      h3("Percentage of Responders that Experience Mental Health Consequences"),
      plotOutput("mental_health_map")
    )),

    tabPanel("Sentiment Analysis", hr(), a(href="https://github.com/hengsworld/DataFriends", "Microsoft Text Analytics using text extraction and sentiment analysis ")),
    tabPanel("Data", verticalLayout(
      #Input
      h3("Mental Health in Tech Survey"),
      h4("Open Sourcing Mental Illness, LTD"), hr(),
      tableOutput("data_table")
    ))),
  
  # GitHub link
  hr(), a(href="https://github.com/hengsworld/DataFriends", "GitHub: DataFriends")
)


