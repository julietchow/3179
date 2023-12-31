# Load the tidyverse package if it's not already loaded
# install.packages("tidyverse") and ("dplyr")  # Uncomment and run if not installed
library(tidyverse)
library(dplyr)

#Coal
coal <- read.csv("Consumption_Coal.csv", strip.white = TRUE)

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(coal) <- new_column_names

# Assuming your data frame is named coal, you can subset it to get columns from X2000 to X2021:
coal <- coal[, c("Continent", "Country", paste0(2000:2021))]

# Assuming your data frame is named coal, you can clean up the "Country" column
coal <- coal %>%
  mutate(Country = str_trim(Country, side = "both"))

# Reshape the data as before
reshaped_coal <- coal %>%
  pivot_longer(cols = -c(Continent, Country), names_to = "Year", values_to = "count") %>%
  mutate(Year = as.numeric(Year))

reshaped_coal
# Delete the "Country" column using subset()
reshaped_coal <- subset(reshaped_coal, select = -Country)

# Assuming your data frame is named 'reshaped_coal' and the column is named 'COAL_consumption'
reshaped_coal$count <- ifelse(reshaped_coal$count == "--", 0, reshaped_coal$count)

reshaped_coal <- reshaped_coal %>%
  group_by(Continent, Year) %>%
  mutate(count = as.numeric(count)) %>%
  summarise(count = sum(count, na.rm = TRUE))

# Add a new column "Energy Source" with all values set to "coal"
reshaped_coal['Energy Source'] = 'Coal'

# Reorder the columns
reshaped_coal <- reshaped_coal %>%
  select("Energy Source", everything())

#Natural Gas
ng <- read.csv("Consumption_NaturalGas.csv", strip.white = TRUE)

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(ng) <- new_column_names

# Assuming your data frame is named coal, you can subset it to get columns from X2000 to X2021:
ng <- ng[, c("Continent", "Country", paste0(2000:2021))]

# Reshape the data as before
reshaped_ng <- ng %>%
  pivot_longer(cols = -c(Continent, Country), names_to = "Year", values_to = "count") %>%
  mutate(Year = as.numeric(Year))

# Delete the "Country" column using subset()
reshaped_ng <- subset(reshaped_ng, select = -Country)

# Assuming your data frame is named 'reshaped_ng' and the column is named 'COAL_consumption'
reshaped_ng$count <- ifelse(reshaped_ng$count == "--", 0, reshaped_ng$count)
reshaped_ng$count <- ifelse(reshaped_ng$count == "ie", 0, reshaped_ng$count)

reshaped_ng <- reshaped_ng %>%
  group_by(Continent, Year) %>%
  mutate(count = as.numeric(count)) %>%
  summarise(count = sum(count, na.rm = TRUE))

# Add a new column "Energy Source" with all values set to "coal"
reshaped_ng['Energy Source'] = 'Natural Gas'

# Reorder the columns
reshaped_ng <- reshaped_ng %>%
  select("Energy Source", everything())

#Neuclear+renewables
nr <- read.csv("Consumption_Neuclear+renewables.csv")

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(nr) <- new_column_names

# Assuming your data frame is named coal, you can subset it to get columns from X2000 to X2021:
nr <- nr[, c("Continent", "Country", paste0(2000:2021))]

# Reshape the data as before
reshaped_nr <- nr %>%
  pivot_longer(cols = -c(Continent, Country), names_to = "Year", values_to = "count") %>%
  mutate(Year = as.numeric(Year))

# Delete the "Country" column using subset()
reshaped_nr <- subset(reshaped_nr, select = -Country)

# Assuming your data frame is named 'reshaped_nr' and the column is named 'count'
reshaped_nr$count <- ifelse(reshaped_nr$count == "--", 0, reshaped_nr$count)

reshaped_nr <- reshaped_nr %>%
  group_by(Continent, Year) %>%
  mutate(count = as.numeric(count)) %>%
  summarise(count = sum(count, na.rm = TRUE))

# Add a new column "Energy Source" with all values set to "coal"
reshaped_nr['Energy Source'] = 'Nuclear & Renewables'

# Reorder the columns
reshaped_nr <- reshaped_nr %>%
  select("Energy Source", everything())

#Petroleum
p <- read.csv("Consumption_Petroleum.csv")

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(p) <- new_column_names

# Assuming your data frame is named coal, you can subset it to get columns from X2000 to X2021:
p <- p[, c("Continent", "Country", paste0(2000:2021))]

# Reshape the data as before
reshaped_p <- p %>%
  pivot_longer(cols = -c(Continent, Country), names_to = "Year", values_to = "count") %>%
  mutate(Year = as.numeric(Year))

# Delete the "Country" column using subset()
reshaped_p <- subset(reshaped_p, select = -Country)

# Assuming your data frame is named 'reshaped_p' and the column is named 'count'
reshaped_p$count <- ifelse(reshaped_p$count == "--", 0, reshaped_p$count)
reshaped_p$count <- ifelse(reshaped_p$count == "ie", 0, reshaped_p$count)

reshaped_p <- reshaped_p %>%
  group_by(Continent, Year) %>%
  mutate(count = as.numeric(count)) %>%
  summarise(count = sum(count, na.rm = TRUE))

# Add a new column "Energy Source" with all values set to "coal"
reshaped_p['Energy Source'] = 'Petroleum'

# Reorder the columns
reshaped_p <- reshaped_p %>%
  select("Energy Source", everything())

# Combine the two tables row-wise
final_table <- rbind(reshaped_coal, reshaped_ng, reshaped_nr, reshaped_p)

write.csv(final_table, file = "stacked_area_chart2.csv", row.names = FALSE)
