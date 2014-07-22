Codebook and Transformations

----------------------------------------------------------------------------------------------
Introduction

This Codebook is written in order of the variables that appear in the script 'run_analysis.R'. It would help to have the codebook and 'run_analysis.R' open side by side and read concurrently.

Variables that will undergo transformations after initial description will be noted with ** in their description.

There are a total of 28 transformations in ‘run_analysis.R’ Each transformation begins with the title 'Transformation, followed by an integer, followed by the name of an object in R.For example, 

Transformation 1: columns            - created by converting 'tmp1' converted into a matrix. This transformation allows us to use the variable names as column names for 'xtrain' and 'xtest'.          

columns is the object of description in Transformation 1.   

The rest of the codebook is divided into five sections, each with a goal in mind. Goal 4 is unique in as such that all of goal 4 was accomplished through the processes of goal 1-3. A detailed list of the transformations used to accomplished goal 4 is given in section 4.

End of Introduction.

———————————————————————————————————————————————————————————————————————————————————————————
Goal 1: Merge the training and test sets to create one data set. 

Variables and Transformations

features           - a '561 by 2' dataset where the second column contains all the names of the features. Read from 'features.txt' using read.table

tmp1               -  The second column of ‘features’ alone

Transformation 1: columns            - created by converting 'tmp1' converted into a matrix. This transformation allows us to use the variable names as column names for 'xtrain' and 'xtest'.

xtrain **          -  a '7352 by 561' dataset. Data from the training set. Read from 'X_train.txt'. 
xtest  **          -   a '2947 by 561' dataset  Data from the test set. Read from 'X_test.txt'.


Note—— The names of the columns of 'xtrain' and 'xtest' are the characters in 'columns'. For example, 'tBodyAcc-mean()-X'corresponds to the first column of 'xtrain' and 'xtest'


Transformation 2: xtrain and xtest   -  The codes 'colnames(xtrain)<-columns' & 'colnames(xtest)<-columns' are used to rename the column names of xtrain' and 'xtest’ to the characters in ‘columns’.

ytrain             - Provides the activity label that is associated with each row in 'xtrain'. Read from 'y_train.txt'

ytest              - Provides the activity label that is associated with each row in 'xtest'.  Read from 'y_test.txt'


Transformation 3:mtrain and mtest**    -  created by column binding ‘ytrain’ with 'xtrain'. The same process is applied to 'ytest' and 'xtest'.


Transformation 4:mtrain and mtest**    -  The 'ytrain' column of 'mtrain' is given the name 'Activity'. The same process is applied to 'ytest' column in 'mtest.


subjecttrain      - Provides the subject ID that is associated with each row in ‘xtrain’ and by extension ‘mtrain’. Read from 'subject_train.txt'


subjecttest       - Simillar to ‘subjecttrain’. Read from 'subject_test.txt'


Transformation 5: mtrain and mtest**   - 'subjecttrain' is attached to 'mtrain' as the first column. The same transformation is applied to 'subjecttest' and 'mtest'. 


Transformation 6: mtrain and mtest**   - The 'subjecttrain' column of 'mtrain' is given the name 'SubjectID'. The same process is applied to 'subjecttest' column in 'mtest.


Transformation 7: main                 - 'main' is created by rbinding 'mtrain' and 'mtest' together. 


test_labels **    - a 9 by 1 data frame with the subjectID’s that are associated with the test group. 

     
Transformation 8: test_labels          - An extra column is added to test_labels. Every entry in that column is the word ‘test’ and the column name is ‘Group’


train_labels**    - a 21 by 1 data frame with the subjectID’s that are associated with the train group.


Transformation 9: train_labels         - An extra column is added to train_labels. Every entry in that column is the word ’train’ and the column name is ‘Group’


main_labels**     - created by row binding ‘test_labels’ and ‘train_labels’ together.

Transformation 10: main_labels         - The first column of main_labels ( the column that has all the integers) is renamed ‘SubjectID’


Transformation 11: Big_Dataset**         - created by merging ‘main_labels’ and ‘main’ by ‘SubjectID’. Essentially, we’re adding another column to main that has the appropriate group labels for each row. It helps us identify which group (test or train) each row comes from.


Transformation 12: Big_Dataset            - The first two columns of Big_Dataset are switched.

Big_Dataset contains all 561 measurements for each subject and each activity associated with the subject. It also provides the group labels(train or test) of each subject.

End of Goal 1

—————————————————————————————————————————————————————————————————————————————————————

Goal 2: Extract only the measurements on the mean and standard deviation for each measurement.

tmp2**             - An integer vector. 'tmp2' is used to identify which columns of 'main’(not Big_Dataset) represent mean and std deviation measurements.


Transformation 13: tmp2                   - the numbers '1' and '2' are added to the start of tmp2. 


Note————   We are going to extract the columns that only have mean and std values in them but we need the first two columns as well because they tell us which subject and what activity our rows are recording.


Transformation 14: mean_std_dtframe       -  A data table that ONLY contains columns of 'main’(not Big_Dataset) with mean and std deviation measurements as well as the "SubjectID" column and the "Activity" column.

End of Goal 2.

—————————————————————————————————————————————————————————————————————————————————————
Goal 3: Uses descriptive activity names to name the activities in the data set.

activity_labels**   - An index that gives us the name of the activity based on the integer in the 'Activity' column'. Read from 'activity_labels.txt'


Transformation 15: activity_labels        - The first column of "activity_labels" is given the name 'Activity'


Trasnformation 16: m_std_frame**          - created by merging ‘activity_labels’ with ‘mean_std_frame’ by ‘Activity’. Essentially, an additional column is added to 'mean_std_dtframe’. The additional column provides the name of the activity based on the integer value in the 'Activity column'. 


Transformation 17: m_std_frame**          - The 'Activity' column with the integer index(colname:'Activity') is removed from the dataset. 


Transformation 18: m_std_frame**          - The current activity column(colname: V2) is renamed 'Activity'


Transformation 19: m_std_frame**          - 'm_std_frame' is reordered by 'Activity' first followed by 'SubjectID'.

End of Goal 3
————————————————————————————————————————————————————————————————————————————————————
Goal 4: Appropriately labels the dat set with the descriptive variables names

Goal 4: This was accomplished as part of the goal 1-3 process. See transformations 1 and 2,15,17,and 18.

———————————————————————————————————————————————————————————————————————————————————————
Goal 5: Create a second independent tidy data set with the average of each variable for each activity and each subject

Transformation 20: m_std_frame            - The 'SubjectID' column is converted from a numeric vector to a factor vector. This allows us to split 'm_std_frame' using 'SubjectID' 


tmp3                - A list of 180 elements created by splitting 'm_std_frame' by 'Activity' and 'SubjectID'(30 participants * 6 Activities).Laying 1 through Laying 30, Walking 1 to Walking 30, Sitting 1 through Sitting 30, etc.


Transformation 21: tmp4                   -  Created by removing the first two columns (The 'Activity' and 'SubjectID' column) from each element of 'tmp3'.


In order to use colMeans later, we have to eliminate all factor columns. We don’t lose any information about the rows because each element of the list tells us what it’s Activity and Subject ID is. 


means**            - Created by applying colMeans to each element in ‘tmp4’ using sappily. A '79 by 180' matrix that provides the means of each column for each element in tmp4. The columns represent the 180 different combinations of activities and participants while the rows represent the different types of measurements. 


Transformation 22: means**                - The matrix 'means' is transposed. It is now a '180 by 79' matrix.**


Transformation 23: means**                - The matrix 'means' is converted into a data frame.**


The goal is to end up with a data frame that identifies the group,subject, and activity of mean of the measurements for each row.

We are now going to split to row.names of ‘means’ using the strsplit function.The goal is to put back the ‘Activity’ and ‘Subject’ label for each row in means.


tmp5             - a list of 180 elements, where each element has two sub-elements. The first sub-element represents the activity of the row while the second sub-element represents the ‘Subject ID’ of the row.


firstElement     - a generic function design to pick out the first element of an object
secondElement    - a generic function designed to pick out the second element of an object


tmp6             - A list of all the first sub-elements of tmp5


tmp7              - A list of all the second sub-elements of tmp6


Transformation 24: means**               - Adding tmp6 and tmp7 as the first two columns of means. **


Transformation 25: means**               - the tmp6 column is given the name ‘Activity’. **


Transformation 26: means                 - the tmp7 column is given the name ‘SubjectID’


Transformation 27: Tidy_Data**            -Created by merging ‘main_labels’ with ‘means’.Essentially, an extra column is added to ‘means’. The extra column provides the group labels (test or train) for each row in ‘means’. 


Transformation 28:Tidy_Data               - The first two columns of Tidy_Data are switched.

End of Goal 5

This is the end of the CodeBook.








                    

