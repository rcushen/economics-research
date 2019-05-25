# FAO Cleaning
> A script intended to pull out data from a Bloomberg dataset

This script pulls out a selected subset of a Bloomberg futures dataset, according to the variables and banks specified in the ```Selected_Banks``` Excel sheet.

**User Guide**

1. Nominate the desired banks in the ```Selected_Banks.xlsx``` file by providing their PID number.
3. Ensure that the raw datafile is correctly specified in the ```FAO_cleaning.R``` file.
3. Specify whether dummy data or the real data is being used.
4. Run the script. Results will be output as ```selected_data.csv```
