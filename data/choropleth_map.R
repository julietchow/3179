# Load the lubridate library for date manipulation
library(lubridate)
library(tidyr)
library(dplyr)

df <- read.csv("netflix1.csv")

# Convert "date_added" to a Date object and extract the year
df$date_added <- as.Date(df$date_added, format = "%m/%d/%Y")
df$year_added <- year(df$date_added)

# Group the data by "type," "country," and "year_added" and calculate the count
result_df <- df %>%
  group_by(type, country, year_added) %>%
  summarize(count_of_shows = n())

result_df <- result_df %>%
  pivot_wider(names_from = type, values_from = count_of_shows, names_prefix = "count_of_")

print(result_df)
# Rename the columns
result_df <- result_df %>%
  rename(country = country,
         year = year_added,
         movie = count_of_Movie,
         tv_show = 'count_of_TV Show')

# Replace NA values with 0 in both columns
result_df <- result_df %>%
  mutate(movie = replace(movie, is.na(movie), 0),
         tv_show = replace(tv_show, is.na(tv_show), 0))

result_df <- result_df %>%
  group_by(country, year) %>%
  mutate(total_count = sum(movie, tv_show))

# Convert tibble to a data frame
result_df <- as.data.frame(result_df)

# Save the data frame as a CSV file
write.csv(result_df, file = "choropleth_map_file.csv", row.names = FALSE)

