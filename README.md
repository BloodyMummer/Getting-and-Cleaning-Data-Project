# Getting and Cleaning Data Project
To perform the work required on this data I had to 
	-Read all the data into R using read.table
	-assign the appropiate column names using the colnames function in R.  
	-merge together the training data sets using Cbind
	-merge together the test data sets using Cbind
	-merge together those data sets using Rbind
	-pull the column names out and assign to a variable so I can use grepl to extract all mean and std values
	-subset the mean and std values using the combined data set and the variable created above
	-assign activity label by activityId to mean and std data table. 
	-create second data table that has averages 