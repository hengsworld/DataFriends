library(shiny)
library(ggplot2)
library(dplyr)
source("wrangleStateData.R")


# Variables
survey <- read.csv("data/survey.csv")

# Map data wrangling
usaSubset <- survey %>% filter(Country == "United States")
usaSubset <- usaSubset %>% select(mental_health_consequence, state) %>% filter(mental_health_consequence != 'Maybe') 
usaSubset <- remove_missing(usaSubset)
usaSubset <- usaSubset %>% mutate(mentalHealth = (mental_health_consequence == 'Yes'))
usaSubset <- usaSubset %>% group_by(state) %>% count(mentalHealth == TRUE) %>% group_by(state) %>% mutate('total' = sum(n))
colnames(usaSubset) <- c("state", "mental_health_consequence", "n", "total")
usaSubset <-  usaSubset %>% filter(mental_health_consequence == TRUE)
usaSubset <- usaSubset %>% mutate('mental_health_ratio' = n / total)
usaSubset <- usaSubset %>% select(-mental_health_consequence)
usaSubset <- usaSubset %>% mutate('region' = tolower(state.name[match(state, state.abb)]))
# Adding states will no data to table
nullStates <- cbind('state'=NA, 'n'=NA, 'total'=NA, 'mental_health_ratio'=NA, 'region'=state.name) %>% tolower()
nullStates <- nullStates %>% as_data_frame(stringsAsFactors=FALSE)
nullStates<- filter(nullStates, !(nullStates$region %in% usaSubset$region))
# Combining tables
usaSubset <- bind_rows(usaSubset, nullStates)

# Define map data
st <- map_data("state")

server <- function(input, output){
  
  # Bar graph output for bar tab
  
  output$bar <- renderPlot({
    
    # Plot graph
    ggplot(survey, aes(survey[,input$xInput])) + 
      geom_bar(aes(fill = survey[,input$xInputColors]), position = "stack") + 
      xlab(paste(input$xInput, "?", sep = "")) + 
      ggtitle(paste(input$xInput, "in survey dataset")) + 
      labs(fill=paste(input$xInputColors, "?", sep = "")) + 
      theme_classic() + 
      theme(text = element_text(size=14),axis.text.x = element_text(angle=30, hjust=1)) 
  })
  
  output$mental_health_map <- renderPlot({
    ggplot() + 
      geom_map(data=st, map=st, aes(x=long, y=lat, map_id=region), fill="#ffffff", color="#ffffff", size=0.15) + 
      geom_map(data=wrangleStateData(input$mapInput), map=st, aes(fill=ratio, map_id=region), color="#ffffff", size=0.15) +
      scale_fill_continuous(low='thistle2', high='darkred', guide='colorbar', na.value="grey48") +
      labs(x=NULL, y=NULL) +
      coord_map("albers", lat0 = 39, lat1 = 45) +
      theme(panel.border = element_blank()) +
      theme(panel.background = element_blank()) +
      theme(axis.ticks = element_blank()) +
      theme(axis.text = element_blank())
  })
  
  output$data_table <- renderTable({head(survey, 20)})
  
  output$vx <- renderUI({
    selectInput("vx", "Choose a variable to display on the x-axis:", choices = c("Self-employed"="self_employed", "Remote Work"="remote_work", "Work interference"="work_interfere", "Benefits"="benefits", "Care options"= "care_options", "Wellness program"="wellness_program", "Resources to seek help?"="seek_help", "Anonymity protected?"="anonymity", "Leave"="leave", "Mental health consequences?"="mental_health_consequence", "Physicla health consequences?"="phys_health_consequence", "Coworkers"="coworkers", "Supervisor"="supervisor", "Mental health interview?"="mental_health_interview", "Physical health interview?"="phys_health_interview", "Mental vs. Physcial"="mental_vs_physical", "Observed consequences?"="obs_consequence"))
  })
  
  output$vy <- renderUI({
    selectInput("vy", "Choose a variable for colors to represent:", choices = c("Self-employed"="self_employed", "Work interference"= "work_interfere", "Remote Work"="remote_work", "Benefits"="benefits", "Care options"="care_options", "Wellness program"="wellness_program", "Resources to seek help?"="seek_help",  "Anonymity protected?"="anonymity", "Leave"="leave", "Mental health consequences?"="mental_health_consequence", "Physical health consequences?"="phys_health_consequence", "Coworkers"="coworkers", "Supervisor"="supervisor", "Mental health interview?"="mental_health_interview", "Physical health interview?"="phys_health_interview", "Mental vs. Physcial"="mental_vs_physical", "Observed consequences?"="obs_consequence"))
  })
  
  output$p <- renderPlot({
    ggplot(survey) + 
      geom_bar(mapping = aes(x=survey[,input$vx], fill = survey[,input$vy]), position = "dodge") + 
      labs(x=input$vx, fill=paste0(input$vy,"?")) + 
      ggtitle(paste(input$vy, "in", input$vx, "dataset")) +
      theme_classic() + 
      theme(text = element_text(size=14),axis.text.x = element_text(angle=30, hjust=1)) 
  })
}

