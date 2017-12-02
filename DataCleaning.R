library(dplyr)

mental_health_data <- read.csv("data/survey.csv")
options(scipen = 999)
filtered_data_set <- mental_health_data %>% filter(!Age < 0) %>% filter(tech_company=="Yes")  
write.csv(filtered_data_set, "data/FilteredData.csv", row.names = FALSE)
View(filtered_data_set)



