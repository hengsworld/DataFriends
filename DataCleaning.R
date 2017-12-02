library(dplyr)
library(ggplot2)
library(scales)

mental_health_data <- read.csv("data/survey.csv")
View(mental_health_data)
age <- mental_health_data$Age
supervisor <- mental_health_data$supervisor
print(supervisor)
print(age)
View(age)
#plot 1: x=age, y=supervisor

plot1 <- ggplot(mental_health_data, aes(x=mental_health_data$Age, y=mental_health_data$supervisor)) + geom_col() + coord_flip() + scale_colour_gradient2(low = "blue", mid = "green", high = "red")
print(plot1)

plot2 <- ggplot(mental_health_data, aes(x=mental_health_data$Gender, y=mental_health_data$supervisor)) + geom_col() + coord_flip() + scale_colour_gradient2(low = "blue", mid = "green", high = "red")
print(plot2)

plot3 <- ggplot(mental_health_data, aes(x=mental_health_data$state, y=mental_health_data$supervisor)) + geom_col() + coord_flip() + scale_colour_gradient2(low = "blue", mid = "green", high = "red")
print(plot3)



