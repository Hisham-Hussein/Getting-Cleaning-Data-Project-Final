# Getting-Cleaning-Data-Project-Final

==================================================================
Creating the tidy_data.txt file
==================================================================
a- Data Preprocessing:

1- Loading some packages for data reading and manipulation (plyr, dplyr, readr)
2- Setting the working directory on my local machine
3- Read the data sets (X_test.txt and X_train.txt)
4- Read the features.txt file
5- Assign (features) as column names for both (test) and (train) data sets 
6- Read subject_test.txt file and subject_train.txt. Extract the desired information from both, and combine them in one vector called "subject"
7- Read the y_test.txt and the y_train.txt. combine test_labels and train_labels into one vector called "labels"
8- Mapping the values in (labels) so that each number from 1:6 will be mapped to its corresponding activity label

==================================================================
b- Data manipulation

1- combine the two large data sets (test) and (train) by row
2- select only the variables containing 'mean()' or 'std()'
3- add two variables for the (subject) and (activity)
4- format the names of the variables to be syntactically correct 
5- Finally, write the tidy_data to a file called "tidy_data.txt"
