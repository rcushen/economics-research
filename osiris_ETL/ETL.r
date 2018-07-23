library(tidyverse)
library(readxl)

# Import and clean data

datafile <- '../_data/Bank_Financials_Downloaded_22Jul2018.xlsx'
raw_data <- read_excel(datafile)

cleaned_data <- raw_data

# Create a lookup table

companies <- cleaned_data %>%
  group_by(`Company name`, `OSIRIS Identification Number`) %>%
  summarise(count_records=n())

write_csv(companies, path='lookuptable.csv')

# Specify desired banks and variables

banks <- c(
  'AE21860',
  'AE30958',
  'AE33331'
)

vars <- c(
  'ISIN No',
  'Company name',
  'Main exchange'
)

# Select and output the relevant data

selected_data <- cleaned_data %>%
  filter(`OSIRIS Identification Number` %in% banks) %>%
  select(vars)

write_csv(selected_data, 'selected_data.csv')
