#read the training tables into R
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Read the testing tables into R
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Read the activity label into R         
activitylabel <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Read the features vector into R
features <- read.table("./UCI HAR Dataset/features.txt")

#Assigning column names to data tables
colnames(xtrain) <- features[,2]
colnames(ytrain) <- "activityId"
colnames(subtrain) <- "subjectId"
colnames(xtest) <- features[,2]
colnames(ytest) <- "activityId"
colnames(subtest) <- "subjectId"
colnames(activitylabel) <- c('activityId','activityType')

#merge training together on columns
train <- cbind(xtrain, ytrain, subtrain)
#merge tests together on columns
test <- cbind(xtest, ytest, subtest)
#merge together on rows
data <- rbind(train, test)

#reading the column names
columnnames <- colnames(data)

#use grepl to find logical values for id, mean, std 
mean_std <- (grepl("activityId", columnnames)|grepl("subjectId", columnnames)
             |grepl("mean..", columnnames) | grepl("std..", columnnames))

#make subset using grepl data
mean_std_data <- data[, mean_std == TRUE]

data_activity <- merge(mean_std_data, activitylabel, by='activityId', all.x=TRUE)

#make the second tidy data set that has averages

data2 <- aggregate(. ~subjectId + activityId, data_activity, mean)
data2 <- data[order(data2$subjectId, data2$activityId),]

write.table(data2, "data2.txt", row.name=FALSE)