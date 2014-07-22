## Creating one big dataset

##Copy train and test files to main directory first.


features<-read.table("features.txt")  # Read features document. It should be the column 
                                      # names for xtrain and xtest.
tmp1<-features[2]      # - "columns" has two columns. We only want the second one.
columns<-sapply(tmp1,as.character) # Convert the second one into a character string.

xtrain<-read.table(file.path(getwd(),"train/X_train.txt"))  # read x train and x test
xtest<-read.table(file.path(getwd(),"test/X_test.txt"))    # Each column is already a num_vector. 

colnames(xtrain)<-columns  # attached column names to xtrain and xtest
colnames(xtest)<-columns

ytrain<-read.table(file.path(getwd(),"train/y_train.txt")) # provides the types of activities for each row in x train
ytest<-read.table(file.path(getwd(),"test/y_test.txt"))    # provides the types of activities for each row in x test

mtrain<-cbind(ytrain,xtrain)  # adding the activity labels as the first column
mtest<-cbind(ytest,xtest)

colnames(mtrain)[1]<-"Activity" # Naming the activity column as Activity.
colnames(mtest)[1]<-"Activity"

subjecttrain<-read.table(file.path(getwd(),"train/subject_train.txt"))# Identifies the subject for each row
subjecttest<-read.table(file.path(getwd(),"test/subject_test.txt")) 

mtrain<-cbind(subjecttrain,mtrain) # attaching the subject id as the first column
mtest<-cbind(subjecttest,mtest)    # attaching the subject id as the first column

colnames(mtrain)[1]<-"SubjectID" # Naming the activity column as Activity.
colnames(mtest)[1]<-"SubjectID"

main<-rbind(mtrain,mtest) 

# going to add group identification
test_labels<-unique(subjecttest)
test_labels$Group<-"test"
train_labels<-unique(subjecttrain)
train_labels$Group<-"train"
main_labels<-rbind(test_labels,train_labels)
row.names(main_labels)<-1:30
names(main_labels)[1]<-"SubjectID"

## Big_Dataset is the merged dataset using 'train' and 'test'
Big_Dataset<-merge(main_labels,main,by="SubjectID")  
Big_Dataset<-Big_Dataset[,c(2,1,3:564)]

## Extracting the columns with mean and std deviation only.

tmp2<-grep("mean\\(\\)|std\\(\\)",colnames(main)) # column numbers that have mean or std in them
tmp2<-c(1,2,tmp2) # We still want to keep the first and second rows so we'll tag them one
mean_std_dtframe<-main[,tmp2]  # the dataframe with mean and std values extracted

## renaming the "Activity" column with appropriate activity label.
activity_labels<-read.table("activity_labels.txt") # Read the file with activity labels
names(activity_labels)[1]<-"Activity"  # rename the column with numeric values as "Activity"

# Creates a new column that matches the activity's name based on the number given.
m_std_frame<-merge(activity_labels,mean_std_dtframe,by="Activity")
m_std_frame<-m_std_frame[,-1] # Remove Activity Column that was represented by numeric values
names(m_std_frame)[1]<-"Activity"
m_std_frame<-m_std_frame[order(m_std_frame[,1],m_std_frame[,2]),]

## Create an independent tidy data set
m_std_frame[,2]<-as.factor(m_std_frame[,2]) 
tmp3<-split(m_std_frame,c(m_std_frame[,1:2])) # Splitting the dataframe by Activity and Name
tmp4<-lapply(tmp3,function(x){x[,-1:-2]})   # getting rid of the first two columns for each item in the list
                                            # because we don't need them anymore
means<-sapply(tmp4,colMeans)               # calculate the means of each column
means<-t(means)                           # transposing the matrix
means<-as.data.frame(means)        # converting it into a dataframe


## We took out the 'Activity' and 'SubjectID' column to calculate the column means. Now we'll put
## back in using the strsplit function on the row.names of 'means'. We'll take advantage of the
## the structure of the row names where every Activity is followed by a '.' followed by an integer.

tmp5<-strsplit(rownames(means),"\\.") #splits the rownames whenever it sees a '.'
firstElement <-function (x) {x[1]} 
secondElement<-function (x) {x[2]}

tmp6<-sapply(tmp5,firstElement) ## Picks out the first element- The Activity of the rowname for each row
tmp7<-sapply(tmp5,secondElement) ## Picks out the second element - The SubjectID of the rowname for each row

means<-cbind(tmp6,tmp7,means)
names(means)[1]<-'Activity'
names(means)[2]<-'SubjectID'

## Tidy_Data is the Independent Tidy Dataset that I'm uploading
Tidy_Data<-merge(main_labels,means,by='SubjectID')
Tidy_Data<-Tidy_Data[,c(2,1,3:69)]