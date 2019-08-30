
Getting and Cleaning Data Final Project 
(Coursera - Data Science Specialization)


From Project description:

One of the most exciting areas in all of data science right now is wearable computing - see for example this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone

This project uses the messy data above to prepare a tidy data for later analysis. 

Files in this repository:
1. README.txt - this file, an overview of the data set, procedures and output
2. summarized_tidy_data.txt : Contains the required data set
3. run_analysis.R : Contains the R script used to create the tidy data set.  Details below
4. Codebook.txt : A markdown file that describes variables and procedures used to create the summarized_tidy_data.txt file

Details regarding the R script run_analysis.R

The following steps were taken to produce the tidy data set. Zipped input files were downloaded and unzipped

An R script performs the following:
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names.
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.




