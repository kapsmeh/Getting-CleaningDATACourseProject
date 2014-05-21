### Instructions for run_analysis.R

Input<- Function run_analysis takes no arguments
Output<-Tidy data frame with row names as "Subject-activities" and Column names as the selected feature name.
Condition<-"UCI HAR Dataset" dataset should be in working directory where run_analysis.R is present.

###Algorithm

##Step 1
	Read the train data and test data, append them as row-wise using rbind. Similarly do the same 
	for train and test label, now the total observation will be 10299.
##Step 2 
	From "features.txt", manually find those features which are caculated based on mean and Standard deviation, which 
	come out as 66. Now extract this subset(66 column) of data from the whole set(561 column).
##Step 3 
	Read "activity_labels.txt", mark all the 10299 observation (find above) activities in combined train 
	and test label using the labels read from the file.
##Step 4 
	Read "features.txt", extract the names of 66 features from the indexes found in step 2
##Step 5
	a.) Read the train and test data which contains subject information,similarly as in step 1, append them.
	b.) Using "aggregate", find the average of each variable for each activity and each subject, now it contains 180
		observations as there are 30 subjects and 6 activities.
	c.) As mentioned in Instructions->Output, we mark row names as combination of "subject-activities" and
		column names as feature names (66) extracted in step 4.
	d.) Write the data frame as "tidy data set.txt" and also return the same.