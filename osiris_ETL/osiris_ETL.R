library(readxl)

# Import and clean data

datafile <- 'input/Bank_Financials_Downloaded_22Jul2018.xlsx'
raw_data <- read_excel(datafile)
cleaned_data <- raw_data

# Import desired banks and varnames

desired_fields <- read_excel('input/fieldnames.xlsx')
desired_fields <- desired_fields[!is.na(desired_fields$`Select?`),]
desired_fields <- desired_fields$`Field Name`

desired_banks <- read_excel('input/lookuptable.xlsx')
desired_banks <- desired_banks[!is.na(desired_banks$`Select?`),]
desired_banks <- desired_banks$`OSIRIS Identification Number`

# Select the relevant data

selected_data <- cleaned_data[cleaned_data$`OSIRIS Identification Number` %in% desired_banks,]
selected_data <- selected_data[,desired_fields]

# Add in null rows for missing years

selected_data$Year <- substring(selected_data$`Company Fiscal Year End (SAS Date Format)`,1,4)
unique_years <- sort(unique(substring(cleaned_data$`Company Fiscal Year End (SAS Date Format)`,1,4)))

full_grid <- expand.grid(
  Year=unique_years, 
  `OSIRIS Identification Number`=unique(selected_data$`OSIRIS Identification Number`)
  )

selected_data <- merge(selected_data, full_grid, all=TRUE)

# Output

write.csv(selected_data, 'output/selected_data.csv', row.names=FALSE)
