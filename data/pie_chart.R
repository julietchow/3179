# Load the dplyr package if it's not already loaded
library(dplyr)
library(tidyr)

data <- read.csv("choropleth_map_new.csv")

# Assuming your data is in a data frame named 'df'
# Group the data by Year and calculate the sum of each column
result <- data %>%
  group_by(Year) %>%
  summarize(
    coal_consumption = sum(coal_consumption),
    ng_consumption = sum(ng_consumption),
    nr_consumption = sum(nr_consumption),
    p_consumption = sum(p_consumption)
  ) %>%
  ungroup()  # Remove grouping

# Reshape the data
result <- result %>%
  gather(key = "Energy_Source", value = "Consumption", -Year)

# Now, df_long contains the data in the desired format
result <- result %>%
  group_by(Year) %>%
  mutate(Percentage_of_Total = Consumption / sum(Consumption))


# Define the file name
output_file <- "pie_chart.csv"

# Save the dataframe as a CSV file
write.csv(result, file = output_file, row.names = FALSE)

