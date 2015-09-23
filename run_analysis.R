#loading readr package (for reading large data sets faster)
#loadin dplyr and plyr packages (for data manipulation)
library(readr)
library(plyr)
library(dplyr)

# Set the working directory
# You need to change that to the folder where the data set is located
# on your local machine (if you want to run the code)
setwd("E:/Engineering/Programming/R/Data Science Specialization/3. Getting and Cleaning Data/UCI HAR Dataset")


# Read the X_test.txt file, indicating that the data set has no header
# by setting col_names argument to FALSE
test <- tbl_df(read_table("test/X_test.txt", col_names = FALSE))


# Read the X_train.txt file
train <- tbl_df(read_table("train/X_train.txt", col_names = FALSE))

# Read the features.txt file, take each whole row as one element (by setting the separator
# character as '\n')
# extract the variable from the data frame and store it in a vector
features <- read.table("features.txt", sep = '\n', stringsAsFactors = F)[, 1]

# Assign (features) as column names for both (test) and (train) data sets 
names(test) <- features
names(train) <- features


# Read the subject_test.txt file as a data frame, extract 
# the resulting data frame variable, store it in a vector
# Do the same withe subject_train.txt
# Combine the two in one vector called (subject)
subject_test <- read.table("test/subject_test.txt")[, 1]
subject_train <- read.table("train/subject_train.txt")[, 1]
subject <- c(subject_test, subject_train)


# Read the y_test.txt file, extract the variable into a vector
# Do the same for the y_train.txt
# combine test_labels and train_labels into one vector
test_labels <- read.table("test/y_test.txt")[, 1]
train_labels <- read.table("train/y_train.txt")[, 1]

labels <- c(test_labels, train_labels)


# Read the activity_labels.txt file, extract only the names
activity_labels <- read.table("activity_labels.txt",
                              sep = ' ', stringsAsFactors = FALSE)[, 2]


# Mapping the values in (labels) so that each number from 1:6 will be 
# mapped to its corresponding activity label
activity_labels_mapped <- mapvalues(labels, c(1, 2, 3, 4, 5, 6), activity_labels)


# Now we will combine the two large data sets (test) and (train) by row
# and select only the variables containing 'mean' or 'std'
# and add two variables for the (subject) and (activity_labels_mapped)
data <- rbind(test, train)

unique(names(data))

data <- data %>%
  select(contains("mean()"), contains("std()")) %>%
  mutate(subject = subject, activity = activity_labels_mapped)


# Now we will do the following:
# 1- Group the resulting data frame by both subject and activity
# 2- Then apply the function (mean) to all variables (except the grouping ones)
tidy_data <- data %>%
  na.omit() %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# format the names of the variables to be syntactically correct 
names(tidy_data) <- make.names(names(tidy_data))

  
# Finally, write the tidy_data to a file called "tidy_data.txt"
# This is the attached file on Courser webpage
write.table(tidy_data,'tidy_data.txt', row.names = FALSE)
