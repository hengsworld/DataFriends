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
        sidebarPanel(selectInput("xInput", label = "Choose a variable to display on the x axis:", choices = names(survey[,7:27]), selected = 'supervisor'),
                     selectInput("xInputColors", label = "Choose a variable for colors to represent:", choices = names(survey[,7:27]), selected = 'mental_health_consequence')),
        # Output
        mainPanel(plotOutput("bar"))
    ), hr(), h3("Qualitative data trends in the Tech Workspace"),
      sidebarLayout(
        #Input
        sidebarPanel(
          uiOutput("vx"),
          br(),
          uiOutput("vy")),
        mainPanel(plotOutput("p"))
    ))),
  
    tabPanel("Maps", verticalLayout(
      #Input
      h3("Ratio of 'Yes' to 'No' Responses by State" ),
      sidebarLayout(sidebarPanel(selectInput("mapInput", label = "Choose a column to calculate ratio for:", choices = names(survey[,7:27]), selected = 'tech_company')),
                    mainPanel(plotOutput("mental_health_map"))), hr(), tableOutput("proportion_table")
    
      )),
    tabPanel("Findings", includeMarkdown("FINDINGS.md")),
    tabPanel("Sentiment Analysis", hr(), a(href="https://app.powerbi.com/groups/me/dashboards/a8af9c92-2520-4e35-bdb8-fda51253afb0", "Microsoft Text Analytics using text extraction and sentiment analysis ")),
    tabPanel("Data", verticalLayout(
      #Inputs
      h3("Mental Health in Tech Survey"),
      h4("Open Sourcing Mental Illness, LTD"), hr(),
      tableOutput("data_table")
    )),
    tabPanel("Comment", 
             #Title
             h3("Leave a comment about our project below"),
             textInput("nameInput", label="Enter your name"),
             textInput("commentInput", label="Enter your comment"),
             actionButton("commentButton", label="Submit"),
             actionButton("refreshButton", label="Refresh"),
             textOutput("textOutput"),
             tableOutput("comment_table")
    )),
  
  # GitHub link
  hr(), a(href="https://github.com/hengsworld/DataFriends", "GitHub: DataFriends")
)