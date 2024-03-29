run_analysis<-function(){

	#relative Path of the Samsung data.
	path="UCI HAR Dataset"
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
	features<-read.table(paste(path,"features.txt",sep="\\"),sep="")[,2]
	x1<-grep("mean()",as.character(features),fixed=TRUE)
	x2<-grep("std()",as.character(features),fixed=TRUE)
	indexes<-sort(rbind(x1,x2))
	data<-whole_data[,indexes]
	
	# 3. Uses descriptive activity names to name the activities in the data set
	activity<-read.table(paste(path,"activity_labels.txt",sep="\\"),sep="")
	activity_names<-factor(whole_label[,1],labels=activity[,2])

	# 4. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
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