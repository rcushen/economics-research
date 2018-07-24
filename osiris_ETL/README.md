# Osiris ETL
> A script intended to pull out data from the Bureau van Dijk Osiris database

This script pulls out a selected subset of the Bureau van Dijk Osiris dataset, according to the variables and banks specified in the ```fieldnames``` and ```lookuptable``` excel sheets.

**User Guide**
1. Nominate the desired variables in the ```fieldnames.xlsx``` file by entering 'Yes' in the Select? column.
2. Nominate the desired banks in the ```lookuptable.xlsx``` file by entering 'Yes' in the Select? column.
3. Ensure that the raw datafile is correctly specified in the ```ETL.R``` file.
4. Run the script. Results will be output as ```selected_data.csv```
