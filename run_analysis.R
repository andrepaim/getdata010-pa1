library(dplyr)

# Download and unzip file if the data directory does not exist
if (!file.exists('UCI HAR Dataset'))
{
	download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 
								'dataset.zip', method='curl')
	unzip('dataset.zip')
}

# Load original datasets
subject.id.train  <- read.table('UCI HAR Dataset/train/subject_train.txt')
x.train  <- read.table('UCI HAR Dataset/train/X_train.txt')
y.train  <- read.table('UCI HAR Dataset/train/y_train.txt')
subject.id.test  <- read.table('UCI HAR Dataset/test/subject_test.txt')
x.test  <- read.table('UCI HAR Dataset/test/X_test.txt')
y.test  <- read.table('UCI HAR Dataset/test/y_test.txt')


# Load auxiliary data containing features and activities labels
feature.labels <- read.table('UCI HAR Dataset/features.txt', 
                              colClasses=c('integer', 'character'))
activity.labels <- read.table('UCI HAR Dataset/activity_labels.txt',
                              colClasses=c('integer', 'factor'))

num.features = nrow(feature.labels)

# Merge the training and the test sets to create one data set
data <- data.frame(subject_id = rbind(subject.id.train, subject.id.test), 
                        x = rbind(x.train, x.test),
                        activity = rbind(y.train, y.test))

# Appropriately labels the data set with descriptive variable names
names(data)[1] <- 'subject.id'
for (i in 1:num.features)
{
  var.name <- gsub('-', '',feature.labels[i, 2])

  var.name <- gsub('\\(', '', var.name)
  var.name <- gsub('\\)', '', var.name)
  var.name <- gsub(',', '.and.', var.name)

  var.name <- gsub('tBody','time.domain.body.', var.name)
  var.name <- gsub('fBody','frequency.domain.body.', var.name)
  var.name <- gsub('tGravity','time.domain.gravity.', var.name)

  var.name <- gsub('Acc','acceleration.', var.name)
  var.name <- gsub('Gyro','gyroscope.', var.name)
  var.name <- gsub('Jerk','jerk.', var.name)
  var.name <- gsub('Mag','magnitude.', var.name)

  var.name <- gsub('X','.x', var.name)
  var.name <- gsub('Y','.y', var.name)
  var.name <- gsub('Z','.z', var.name)

  var.name <- gsub('meanFreq', 'mean.freq', var.name)
  var.name <- gsub('gravityMean', 'gravity.mean', var.name)
  var.name <- gsub('Body', 'body.', var.name)

  var.name <- gsub('angle', 'angle.between.', var.name)
  var.name <- gsub('Mean','mean.', var.name)

  var.name <- gsub('\\.\\.','.', var.name)

   names(data)[(i+1)] <- var.name
}
names(data)[(num.features+2)] = 'activity'


# Extract only the measurements on the mean and standard deviation for each
# measurement.
selected.measurements.indices <- grep('mean|std', feature.labels[, 2], ignore.case=T) + 1
data <- data[, c(1, selected.measurements.indices, num.features+2)]

# Use descriptive activity names to name the activities in the data set
data$activity <- activity.labels[data$activity, 2]

# From the data set in step 4, creates a second, independent data set with the average 
# of each variable for each activity and each subject.
by.subject.activity <- group_by(data, subject.id, activity)
tidy.data <- summarise_each(by.subject.activity, funs(mean))

# Save the resulting dataset as a txt file
write.table(tidy.data, 'tidy_dataset.txt', row.name=FALSE)

