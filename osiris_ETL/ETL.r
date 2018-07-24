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

# Select and output the relevant data

selected_data <- cleaned_data %>%
  filter(`OSIRIS Identification Number` %in% desired_banks) %>%
  select(desired_fields)

write_csv(selected_data, 'selected_data.csv')
