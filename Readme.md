

## Script Description

In order to create the requested tidy dataset, the following steps
were performed:

1. Checks if the Samsung dataset is in the working directory. If not,
downloads the dataset and unzips it.

2. Loads the original datasets. For the train and test subdirectories
the input (*train/X\_train.txt* and *test/X\_test.txt*), output 
(*train/Y\_train.txt* and *test/Y\_test.txt*)
and subject id files (*train/subject\_train.txt* and *test/subject\_test.txt*)
are loaded.

3. Load auxiliary datasets containing feature names (*features.txt*) and 
activities labels (*activity.txt*)

4. Merge all datasets into a single data frame. The inputs, output and subject ids
for the train and test data are merged using the *rbind* command.

5. Appropriately labels the data set with descriptive variable names. The first
column representing the subject ids is named as *subject*. The last column representing
the corresponding to the output is named as *activity*. The remaining columns were
renamed using the corresponding feature names loaded in the step 3. However, the
following characters were replaced by '\_' to improve readability: ')', '(', '-', and ','. 

