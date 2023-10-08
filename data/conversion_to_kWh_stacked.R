library(tidyverse)
data <- read.csv("stacked_area_chart.csv")

# Define the conversion factors
# Define the conversion factor
quad_to_kWh <- 293.0711

# Convert multiple columns to kWh
data <- data %>%
  mutate(
    count = count * quad_to_kWh
  )

# Define the file name
output_file <- "stacked_area_chart_new.csv"

# Save the dataframe as a CSV file
write.csv(data, file = output_file, row.names = FALSE)

