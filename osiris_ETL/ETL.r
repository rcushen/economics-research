library(tidyr)
library(readxl)

# Import and clean data

datafile <- '../_data/'
raw_data <- read_excel(datafile)

cleaned_data <- raw_data %>%
  


# Specify desired banks and variables

banks <- c(
  '',
  '',
  ''
)

vars <- c(
  '',
  '',
  ''
)

# Select and output the relevant data

selected_data <- cleaned_data %>%
  select(vars) %>%
  filter(WVB %in% banks)

write_csv(selected_data, 'output/selected_data.csv')
