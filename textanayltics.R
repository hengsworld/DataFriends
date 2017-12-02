library(httr)
library(jsonlite)
library(data.table)
library(dplyr)
library(mscstexta4r)


cogapikey<-"Key"
cogapi<-"https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0"

text <-  read.csv("survey.csv")
takingComment <- text %>% select(ID,comments)
# Prep data

mydata<-list(documents= takingComment)


response<-POST(cogapi, 
               add_headers(`Ocp-Apim-Subscription-Key`=cogapikey),
               body=toJSON(mydata))
# Process response
textaDetectLanguages(
  documents,                      # Input sentences or documents
  numberOfLanguagesToDetect = 1L  # Default: 1L
)
textaKeyPhrases(
  documents,                  # Input sentences or documents
  languages = rep("en", length(documents))
  # "en"(English, default)|"de"(German)|"es"(Spanish)|"fr"(French)|"ja"(Japanese)
)