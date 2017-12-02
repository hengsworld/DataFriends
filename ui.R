library(shiny)

library(readr)

survey <- read.csv("data/survey.csv")
introText <- read_file("intro.txt")

fluidPage(
  h1("Mental Health in the Tech Industry"), p("DataFriends"),
  hr(),
  
  tabsetPanel(
    tabPanel("Introduction", h2("Introduction"), p(introText)),
    tabPanel("Bar Graphs", sidebarLayout(
                              # Input
                              sidebarPanel(selectInput("xInput", label = "Choose a variable to display on the x axis.", choices = names(survey), selected = 'remote_work')),
                              # Output
                              mainPanel(plotOutput("bar"))
                          )
    ),
    tabPanel("Sentiment Analysis", "contents")),
  
  # GitHub link
  a(href="https://github.com/hengsworld/DataFriends", "GitHub")
)


