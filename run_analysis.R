#load plyr - This script requires plyr
library(plyr)
#load reshape2 - This script requires reshape2
library(reshape2)
# Read the learning dataset
print("Reading data...")
train_measurements <- read.table("train/X_train.txt", stringsAsFactors=FALSE)
train_activities <- read.table("train/y_train.txt")
train_subjects <- read.table("train/subject_train.txt")
train_measurements$Activity.Label <- train_activities$V1
train_measurements$Subject.ID <- train_subjects$V1
rm(train_activities)
rm(train_subjects)
test_measurements <- read.table("test/X_test.txt", stringsAsFactors=FALSE)
test_activities <- read.table("test/y_test.txt")
test_subjects <- read.table("test/subject_test.txt")
test_measurements$Activity.Label <- test_activities$V1
test_measurements$Subject.ID <- test_subjects$V1
rm(test_activities)
rm(test_subjects)
print("Completed reading data.")
# Merge the datasets
print("Merging data...")
total <- rbind(train_measurements, test_measurements)
var_names <- read.table("features.txt", stringsAsFactors = FALSE) 
# Remove brackets and commas from variable names
var_names$V2 <- lapply(var_names$V2, function(x) gsub("\\(|\\)|\\,", "", x))
colnames(total) <- c(var_names$V2, "Activity.ID", "Subject.ID")
# Extract the mean & std for each measurement
mean_names <- names(total)[which(grepl("mean", names(total), ignore.case = FALSE) & !grepl("Freq", names(total)))]
std_names <- names(total)[which(grepl("std", names(total), perl = TRUE, ignore.case = FALSE))]
extracted <- total[,c("Activity.ID", "Subject.ID", mean_names, std_names)]
# Apply descriptive names to activities in the extracted data set
activity_labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
colnames(activity_labels) <- c("Activity.ID", "Activity")
activity_data <- join(extracted, activity_labels, by = "Activity.ID")
activity_data <- subset(activity_data, select = -Activity.ID)
# Reorder columns for clarity
activity_data <- activity_data[c(1,68,2:67)]
# Produce tidy data set that has averages of all variables for each activity and subject
melted_data <- melt(activity_data, id=c("Subject.ID","Activity"))
tidy_data <- dcast(melted_data, Subject.ID + Activity ~ variable, mean)
print("Completed processing data...")
# Write tidy data set to disk
print("Writing data to disk...")
write.table(tidy_data, file="tidy_data.txt", row.names=FALSE)
print("Completed writing data to disk.")