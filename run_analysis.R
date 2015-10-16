#get all test data
X_test<-read.table("UCI HAR Dataset//test/X_test.txt")
Y_test<-read.table("UCI HAR Dataset//test/Y_test.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

#get all training data that ties reading to activity
subject_training<- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test<- read.table("./UCI HAR Dataset/test/subject_test.txt")

#get list of all features
features<-read.table("./UCI HAR Dataset/features.txt")[,2]
# get all activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

#set feature lables name
names(X_test)=features
names(X_train)=features


#add lables for corrosponding activity
Y_test[,2]=activity_labels[Y_test[,1]]
Y_train[,2]=activity_labels[Y_train[,1]]

#add proper column
names(Y_test)=c("Activity_ID", "Activity_Label")
names(Y_train)=c("Activity_ID", "Activity_Label")
names(subject_training) = "reading"
names(subject_test) = "reading"


#get features which have mean and std
features_extract<-grepl("mean|std",features)




# Extracts only the measurements on the mean and standard deviation 
# for each measurement.
X_test_extract = X_test[,features_extract]
X_train_extract = X_train[,features_extract]



# Merges the training and the test sets to create one data set.
train_data <- cbind(as.data.table(subject_training), Y_train, X_train_extract)
test_data <- cbind(as.data.table(subject_test), Y_test, X_test_extract)

merge_data = rbind(train_data,test_data)

merge_data_tidy<- melt(data=merge_data,
                       id=1:3,
                       variable.names="measure",
                       value.name="value")
head(merge_data_tidy)



