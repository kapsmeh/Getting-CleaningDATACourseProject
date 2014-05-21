run_analysis<-function(path){

	# 1. Merges the training and the test sets to create one data set.
	##reading train data and train label
	train_data<-read.table(paste(path,"train\\X_train.txt",sep="\\"),sep="")
	train_label<-read.table(paste(path,"train\\y_train.txt",sep="\\"),sep="")
	
	##reading test data and test label
	test_data<-read.table(paste(path,"test\\X_test.txt",sep="\\"),sep="")
	test_label<-read.table(paste(path,"test\\y_test.txt",sep="\\"),sep="")

	#merging train and test data
	whole_data<-rbind(train_data,test_data)
	
	#merging train and test label
	whole_label<-rbind(train_label,test_label)
	
	# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	#extracting the feature indexes of mean and standard deviation
	indexes<-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)	
	data<-whole_data[,indexes]
	
	# 3. Uses descriptive activity names to name the activities in the data set
	activity<-read.table(paste(path,"activity_labels.txt",sep="\\"),sep="")
	activity_names<-factor(whole_label[,1],labels=activity[,2])

	# 4. Appropriately labels the data set with descriptive activity names. 
	features<-read.table(paste(path,"features.txt",sep="\\"),sep="")[,2]
	

	# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
	subject_train<-read.table(paste(path,"train\\subject_train.txt",sep="\\"),sep="")
	subject_test<-read.table(paste(path,"test\\subject_test.txt",sep="\\"),sep="")
	#merging train and test subjects
	subject<-factor(rbind(subject_train,subject_test)[,1])

	X<-aggregate(x = data, by = list(subject,activity_names), FUN = "mean")
	rownames(X)<-paste(X[,1],X[,2],sep="-")
	X<-X[,3:68]
	colnames(X)<-features[indexes]	
	write.table(x=X,file="tidy data set.txt")
	return(X)
}	