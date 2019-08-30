
## run_analysis.R
##
## Performs the cleaning/tidying and analysis of the UCI HAR Dataset 
## in completion of the final project for
## Getting and Cleaning Data course Project description.  

  
  
#Setup
knitr::opts_chunk$set(tidy.opts= list( width.cutoff = 60), tidy=TRUE)
library(tidyverse)



#read in the data
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_labels <-  read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors	= FALSE)
features <- read.table("UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)



#merge the test and train datasets
sub <- rbind(sub_test,sub_train)
data <- rbind(X_test, X_train)
activity <- rbind(y_test, y_train)



#find the rows that have mean or sd in them and store them in the dataframe data1
split_feat <- (strsplit(features$V2, "-") )

len <- lengths(split_feat)
l <- length(lengths(split_feat))

first = TRUE
j <- 1
for (i in 1:l) {
  if(len[i]!=1){
    if(split_feat[[i]][2]=="mean()"|split_feat[[i]][2]=="std()"){
      if(first== TRUE){
        first <- FALSE
        data1 <- as.data.frame(data[,i])
        names(data1)[j] <- features[i,2]
        j <- j+1
      }else{
        data1 <- cbind(data1,data[,i])
        names(data1)[j] <- features[i,2]
        j <- j+1
      }
    } 
  }  
}


#Include activities and subjects in the merged dataset. Store in data2
data2 <- cbind(Activity = activity_labels[activity$V1,2], Subject = sub$V1, data1)

#Form descriptive variable names
data2 <- data2 %>% 
  # Change leading "t" to "time"
  setNames(gsub("^t", "time", names(.))) %>%
  # Change leading "f" to "freq"
  setNames(gsub("^f", "freq", names(.)))  %>%
  # Change "Acc" to "Linear"
  setNames(gsub("Acc", "Linear", names(.))) %>%
  # Change "Gyro" to "Angular"
  setNames(gsub("Gyro", "Angular", names(.))) %>%  
  # Change "Mag" to "Magnitude"
  setNames(gsub("Mag", "Magnitude", names(.))) %>%
  # Remove the repeated word typo: BodyBody -> Body
  setNames(gsub("BodyBody", "Body", names(.)))




#form tidy data
tidy_data <- 
  data2 %>% gather(colnames(data2[,3:ncol(data2)]) ,
                   key = "Variable",
                   value = "Measurement" )

#summerize tidy data
summerized_tidy_data <- tidy_data %>% group_by(Subject, Activity, Variable) %>%
  summarise("Mean of Variable"= mean(Measurement))



#write the summerized_tidy_data to a .txt file
write.table(summerized_tidy_data, "summerized_tidy_data.txt", row.names = FALSE)





