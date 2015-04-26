#read activity data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
#combine test and train data
combined.data <- rbind(X_train,X_test)
#read variables names and strip out enumeration
feat <- readLines("./UCI HAR Dataset/features.txt")
feat2 <- strsplit(feat,split=" ")
feat <- character()
for(i in 1:length(feat2)){
  feat <- append(feat,feat2[[i]][2])
}
#set names
colnames(combined.data) <- feat
#choose containing mean() and std()
data.new <- cbind(combined.data[,grepl("mean()",feat)],combined.data[,grepl("std()",feat)])
#read subject data and create subject dataframe
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")
subjects <- rbind(subject_train,subject_test)
colnames(subjects) <- c("subject")
#read activity data and create activity dataframe
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
activity <- rbind(y_train,y_test)
colnames(activity) <- c("activity")
#merge observations data with activity and subjects IDs
final.raw.data <- cbind(data.new,subjects,activity)
tidy.data <- aggregate(. ~ subject + activity,data=final.raw.data,mean)
