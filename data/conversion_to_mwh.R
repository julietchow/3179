library(tidyverse)
data <- read.csv("choropleth_map.csv")

# Define the conversion factors
# Define the conversion factor
quad_to_kWh <- 293.0711

# Convert multiple columns to kWh
data <- data %>%
  mutate(
    coal_consumption = coal_consumption * quad_to_kWh,
    nr_consumption = nr_consumption * quad_to_kWh,
    ng_consumption = ng_consumption * quad_to_kWh,
    p_consumption = p_consumption * quad_to_kWh,
    total_consumption = total_consumption * quad_to_kWh
  )

# Define the file name
output_file <- "choropleth_map_new.csv"

# Save the dataframe as a CSV file
write.csv(data, file = output_file, row.names = FALSE)

