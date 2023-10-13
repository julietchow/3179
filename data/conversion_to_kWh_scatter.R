library(tidyverse)
data <- read.csv("scatter.csv")

# Define the conversion factors
# Define the conversion factor
quad_to_kWh <- 293.0711

# Convert multiple columns to kWh
data <- data %>%
  mutate(
    Total_Consumption = Total_Consumption * quad_to_kWh,
    Total_production = Total_production * quad_to_kWh
  )

# Define the file name
output_file <- "scatter.csv"

# Save the dataframe as a CSV file
write.csv(data, file = output_file, row.names = FALSE)

