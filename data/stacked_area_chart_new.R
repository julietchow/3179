# Load the dplyr package if you haven't already
library(dplyr)

df <- read.csv("stacked_area_chart.csv")

# Create a summary data frame with totals for each combination of Continent, Year, and Energy.Source
total_df <- df %>%
  group_by(Continent, Year, Energy.Source) %>%
  summarise(Total = sum(count))

# Create a new row with label "Total" for each combination of Continent, Year, and Energy.Source
total_row <- total_df %>%
  mutate(Continent = "Total") %>%
  group_by(Year, Energy.Source) %>%
  summarise(Total = sum(Total))

# Bind the total row to the original data frame
final_df <- bind_rows(df, total_row)

# Arrange the data frame as needed
final_df <- final_df %>%
  arrange(Energy.Source, Continent, Year)

# Print the final data frame
print(final_df)

write.csv(final_df, file = "final.csv",  row.names = FALSE)
