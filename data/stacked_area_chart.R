#Coal
coal <- read.csv("Consumption_Coal.csv", strip.white = TRUE)

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(coal) <- new_column_names

# Assuming your data frame is named coal, you can subset it to get columns from X2000 to X2021:
coal <- coal[, c("Continent", "Country", paste0(2000:2021))]

# Add a new column "Energy Source" with all values set to "coal"
coal['Energy Source'] = 'Coal'

# Reorder the columns
coal <- coal %>%
  select("Energy Source", everything())

#Natural Gas
ng <- read.csv("Consumption_NaturalGas.csv", strip.white = TRUE)

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(ng) <- new_column_names

# Assuming your data frame is named coal, you can subset it to get columns from X2000 to X2021:
ng <- ng[, c("Continent", "Country", paste0(2000:2021))]

# Add a new column "Energy Source" with all values set to "coal"
ng['Energy Source'] = 'Natural Gas'

# Reorder the columns
ng <- ng %>%
  select("Energy Source", everything())

#Neuclear+renewables
nr <- read.csv("Consumption_Neuclear+renewables.csv")

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(nr) <- new_column_names

# Assuming your data frame is named coal, you can subset it to get columns from X2000 to X2021:
nr <- nr[, c("Continent", "Country", paste0(2000:2021))]

# Add a new column "Energy Source" with all values set to "coal"
nr['Energy Source'] = 'Nuclear & Renewables'

# Reorder the columns
nr <- nr %>%
  select("Energy Source", everything())

#Petroleum
p <- read.csv("Consumption_Petroleum.csv")

# Generate the new column names from 1980 to 2021
new_column_names <- c("Continent", "Country", as.character(1980:2021))

# Assign the new column names to your data frame
colnames(p) <- new_column_names

# Assuming your data frame is named coal, you can subset it to get columns from X2000 to X2021:
p <- p[, c("Continent", "Country", paste0(2000:2021))]

# Add a new column "Energy Source" with all values set to "coal"
p['Energy Source'] = 'Petroleum'

# Reorder the columns
p <- p %>%
  select("Energy Source", everything())

# Combine the two tables row-wise
final_table <- rbind(coal, ng, nr, p)
final_table["Energy Source"]

write.csv(final_table, file = "stacked_area_chart.csv", row.names = FALSE)
