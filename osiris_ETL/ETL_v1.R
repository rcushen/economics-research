library(tidyverse)
library(readxl)

# Import and clean data

datafile <- '../_data/Bank_Financials_Downloaded_22Jul2018.xlsx'
raw_data <- read_excel(datafile)
cleaned_data <- raw_data

# Import desired banks and varnames

desired_fields <- read_excel('fieldnames.xlsx') %>%
  filter(!is.na(`Select?`)) %>%
  pull(`Field Name`)

desired_banks <- read_excel('lookuptable.xlsx') %>%
  filter(!is.na(`Select?`)) %>%
  pull(`OSIRIS Identification Number`)

# Select the relevant data

selected_data <- cleaned_data %>%
  filter(`OSIRIS Identification Number` %in% desired_banks) %>%
  select(desired_fields)

# Add in null rows for missing years

selected_data$yr <- substring(selected_data$`Company Fiscal Year End (SAS Date Format)`,1,4)
unique_years <- sort(unique(substring(cleaned_data$`Company Fiscal Year End (SAS Date Format)`,1,4)))

full_grid <- expand.grid(
  yr=unique_years, 
  `OSIRIS Identification Number`=unique(selected_data$`OSIRIS Identification Number`)
  )

selected_data <- merge(selected_data, full_grid, all=TRUE)

# Output

write_csv(selected_data, 'selected_data.csv')
