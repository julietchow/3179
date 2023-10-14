# Assuming your data is stored in a data frame named 'df'
library(dplyr)

data <- read.csv("stacked_area_chart.csv")

result <- data %>%
  group_by(Continent, Year) %>%
  summarise(Total_Energy_Consumption = sum(count))

write.csv(result, "line_chart.csv", row.names = FALSE)

