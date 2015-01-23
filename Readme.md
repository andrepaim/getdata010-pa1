# Script Description

In order to create the requested tidy dataset, the following steps
are performed:

1. Checks if the Samsung dataset is in the working directory. If not,
downloads the dataset and unzips it.

2. Loads the original datasets. For the train and test subdirectories
the input (*train/X\_train.txt* and *test/X\_test.txt*), output 
(*train/Y\_train.txt* and *test/Y\_test.txt*)
and subject id files (*train/subject\_train.txt* and *test/subject\_test.txt*)
are loaded.

3. Loads auxiliary datasets containing feature names (*features.txt*) and 
activities labels (*activity.txt*)

4. Merge all datasets into a single data frame. The inputs, output and subject ids
for the train and test data are merged using the *rbind* function.

5. Appropriately labels the data set with descriptive variable names. The first
column representing the subject ids is named as *subject*. The last column representing
the corresponding to the output is named as *activity*. The remaining columns are
renamed using the corresponding feature names loaded in the step 3. However, the
following characters are replaced by '\_' to improve readability: ')', '(', '-', and ','. 
This last step is performed using the *gsub* function.

6. Extracts only the measurements on the man and standard deviation for each measurement.
The *grep* function is used to create an index vector of the feature columns with names 
containing the words *mean* or *std* (ignoring case). Next, the dataset is filtered
using the resulting index vector.

7. Uses descriptive activity names to name the activities in the data set. The
original *activity* column has indices which are used to extract the corresponding
activities descriptions loaded in the activities labels dataset (step 3).

8. From the dataset in step 7, creates a second, independent data set with the
average of each variable for each activity and each subject. First, the 
*dplyr::group_by* function is used to group the dataset by subject and activity.
Next, the *dplyr::summarise_each* function is used to generate the final tidy
dataset containing the mean value of each feature for each subject and each
activity

# Dataset description



