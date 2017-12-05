library(dplyr)

mental_health_data <- read.csv("data/survey.csv")

View(mental_health_data)
age <- mental_health_data$Age
supervisor <- mental_health_data$supervisor
print(supervisor)
print(age)
View(age)
options(scipen = 999)
filtered_data_set <- mental_health_data %>% filter(!Age < 0) %>% filter(tech_company=="Yes")  
write.csv(filtered_data_set, "data/FilteredData.csv", row.names = FALSE)
View(filtered_data_set)




