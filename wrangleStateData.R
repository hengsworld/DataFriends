library(shiny)
library(ggplot2)
library(dplyr)

# Variables
survey <- read.csv("data/survey.csv")

wrangleStateData <- function(inputColumn){
  usaSubset <- survey %>% filter(Country == "United States")
  usaSubset <- usaSubset %>% select(inputColumn, state) %>% filter(usaSubset[[inputColumn]] == 'Yes' | usaSubset[[inputColumn]] == 'No')
  usaSubset <- remove_missing(usaSubset)
  usaSubset <- usaSubset %>% mutate('input' = (usaSubset[[inputColumn]] == 'Yes'))
  usaSubset <- usaSubset %>% group_by(state) %>% count(input == TRUE) %>% group_by(state) %>% mutate('total' = sum(n))
  colnames(usaSubset) <- c("state", "XXX", "n", "total")
  usaSubset <-  usaSubset %>% filter(XXX == TRUE)
  usaSubset <- usaSubset %>% mutate('ratio' = n / total)
  usaSubset <- usaSubset %>% select(-XXX)
  usaSubset <- usaSubset %>% mutate('region' = tolower(state.name[match(state, state.abb)]))
  nullStates <- cbind('state'=NA, 'n'=NA, 'total'=NA, 'ratio'=NA, 'region'=state.name) %>% tolower()
  nullStates <- nullStates %>% as_data_frame(stringsAsFactors=FALSE)
  nullStates<- filter(nullStates, !(nullStates$region %in% usaSubset$region))
  usaSubset <- bind_rows(usaSubset, nullStates)
  return(usaSubset)
}