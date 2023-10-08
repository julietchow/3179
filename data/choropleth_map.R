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
  pivot_longer(cols = -c(Continent, Country), names_to = "Year", values_to = "coal_consumption") %>%
  mutate(Year = as.numeric(Year))

# Clean up the "Country" column to remove leading spaces
reshaped_coal$Country <- str_trim(reshaped_coal$Country, side = "both")

reshaped_coal <- as.data.frame(reshaped_coal)

#Natural Gas
ng <- read.csv("Consumption_NaturalGas.csv")

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(ng) <- new_column_names

# Assuming your data frame is named ng, you can subset it to get columns from X2000 to X2021:
ng <- ng[, c("Continent", "Country", paste0(2000:2021))]

# Assuming your data frame is named coal, you can clean up the "Country" column
ng <- ng %>%
  mutate(Country = str_trim(Country, side = "both"))

# Reshape the data as before
reshaped_ng <- ng %>%
  pivot_longer(cols = -c(Continent, Country), names_to = "Year", values_to = "ng_consumption") %>%
  mutate(Year = as.numeric(Year))

reshaped_ng <- as.data.frame(reshaped_ng)
reshaped_ng

# Merge the last column of reshaped_ng into reshaped_coal based on "Country" and "Year"
final_table <- merge(reshaped_coal, reshaped_ng[, c("Country", "Year", "ng_consumption")], by = c("Country", "Year"), all.x = TRUE)

# If you want to fill missing values with 0 in the ng_consumption column, you can use the following line:
final_table$ng_consumption[is.na(final_table$ng_consumption)] <- 0

# View the resulting data frame
final_table

#Neuclear+renewables
nr <- read.csv("Consumption_Neuclear+renewables.csv")

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(nr) <- new_column_names

# Assuming your data frame is named ng, you can subset it to get columns from X2000 to X2021:
nr <- nr[, c("Continent", "Country", paste0(2000:2021))]

# Assuming your data frame is named coal, you can clean up the "Country" column
nr <- nr %>%
  mutate(Country = str_trim(Country, side = "both"))

# Reshape the data as before
reshaped_nr <- nr %>%
  pivot_longer(cols = -c(Continent, Country), names_to = "Year", values_to = "nr_consumption") %>%
  mutate(Year = as.numeric(Year))

reshaped_nr <- as.data.frame(reshaped_nr)

# Merge the last column of reshaped_nr into final_table based on "Country" and "Year"
final_table <- merge(final_table, reshaped_nr[, c("Country", "Year", "nr_consumption")], by = c("Country", "Year"), all.x = TRUE)

# If you want to fill missing values with 0 in the nr_consumption column, you can use the following line:
final_table$nr_consumption[is.na(final_table$nr_consumption)] <- 0

#Petroleum
p <- read.csv("Consumption_Petroleum.csv")

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(p) <- new_column_names

# Assuming your data frame is named ng, you can subset it to get columns from X2000 to X2021:
p <- p[, c("Continent", "Country", paste0(2000:2021))]

# Assuming your data frame is named coal, you can clean up the "Country" column
p <- p %>%
  mutate(Country = str_trim(Country, side = "both"))

# Reshape the data as before
reshaped_p <- p %>%
  pivot_longer(cols = -c(Continent, Country), names_to = "Year", values_to = "p_consumption") %>%
  mutate(Year = as.numeric(Year))

reshaped_p <- as.data.frame(reshaped_p)

# Merge the last column of reshaped_p into final_table based on "Country" and "Year"
final_table <- merge(final_table, reshaped_p[, c("Country", "Year", "p_consumption")], by = c("Country", "Year"), all.x = TRUE)

# If you want to fill missing values with 0 in the ng_consumption column, you can use the following line:
final_table$p_consumption[is.na(final_table$p_consumption)] <- 0

final_table <- final_table %>%
  mutate(
    coal_consumption = ifelse(trimws(coal_consumption) == "NA", 0, as.numeric(coal_consumption)),
    ng_consumption = ifelse(trimws(ng_consumption) == "NA", 0, as.numeric(ng_consumption)),
    nr_consumption = ifelse(trimws(nr_consumption) == "NA", 0, as.numeric(nr_consumption)),
    p_consumption = ifelse(trimws(p_consumption) == "NA", 0, as.numeric(p_consumption))
  )

final_table$total_consumption <- rowSums(final_table[, c("coal_consumption", "ng_consumption", "nr_consumption", "p_consumption")])

# View the updated data frame
head(final_table)

write.csv(final_table, file = "choropleth_map.csv", row.names = FALSE)

