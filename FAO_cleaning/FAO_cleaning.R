library(tidyverse)
library(readxl)

# Set script parameters

data_filename <- 'input/fvs.pids.dates.csv'
banks_filename <- 'input/Selected_Banks.xls'
output_destination <- 'output/selected_data.csv'
its_the_actual_data = FALSE
maturity <- 'fvcds2'

# Read in raw data

raw_data <- read_csv(data_filename, skip=1) %>%
  mutate(date=as.Date(date))

# Generate fictional data

if (!its_the_actual_data){

  rownames <- read_csv('input/fvs.colnames.csv', skip=1, col_types='cDdddddd')
  raw_data <- bind_rows(rownames, raw_data)
  
  for (col in colnames(raw_data)[3:8]){
    raw_data[, col] <- rnorm(nrow(raw_data), 0, 1)
  }
  
  rm(col, rownames)

}
  
# Read in selected banks

selected_banks <- read_excel(banks_filename) %>%
  mutate(PID=str_pad(PID, 6, side='left', pad='0')) %>%
  select(pid=PID, bankname=`Bank Name`, ticker=Ticker)

# Select the relevant data

selected_pids <- selected_banks$pid

selected_data <- raw_data %>%
  filter(pid %in% selected_pids) %>%
  left_join(selected_banks, by='pid') %>%
  select(pid, bankname, ticker, date, everything())

if (!all(selected_banks$pid %in% selected_data$pid)){
  stop('Not all selected banks succesfully extracted from data')
}

# Replace missing observations with NA

min_date <- as.Date('2006-01-01')
max_date <- as.Date('2015-12-31')

expanded_data <- selected_data %>%
  expand(pid, date=full_seq(c(min_date, max_date), 1))

result <- expanded_data %>%
  left_join(selected_banks, by='pid') %>%
  left_join(selected_data, by=c('pid'='pid', 'date'='date', 
                                'bankname'='bankname', 'ticker'='ticker')) %>%
  select(pid, bankname, ticker, date, everything())

rm(expanded_data, selected_data, min_date, max_date)

# Select desired maturity

result <- result %>%
  select(pid, bankname, ticker, date, maturity)

# Write out the data

write_csv(result, output_destination)
