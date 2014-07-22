README

This folder contains the following three files:

1) README.md
2) run_analysis.R
3) CodeBook.md

The purpose of the README is to explain the second and third file.

To use run_analysis.R, first open R studio, and set your working directory to the folder containing the test and train folders. The working directory should contain the following files

1)features.txt
2)features_info.txt
3)activity_labels.txt
4)README.txt

5)test folder - subject_test.txt
     - X_test.txt
     - y_test.txt
     - Inertial Signals folder

6)train folder - subject_train.txt
      - X_train.txt
      - y_train.txt
      - Inertial Signals folder

DO NOT RENAME ANY OF THESE FILES. Ignore the Inertial Signals folders.

After setting your working directory, open run_analysis.R in R studio and run it through R Studio with the "Run" function that is located on the top right of the first quadrant of R studio (highlight all of the code before pressing "Run"). It( The “Run” function) should be really close to a "Source" function as well. 

-------------------------------------------------------------------------------------
CodeBook.md

CodeBook.md provides a step by step walkthrough of the code in run_analysis.R. It details the different variables that are created in run_analysis.R as well as the different transformations that are made to the variables. CodeBook.md is split into six sections: Introduction, Goal 1, Goal 2, Goal 3, Goal 4 and Goal 5. In order to understand the code in run_analysis.R properly, it is advisable to have CodeBook.md and run_analysis.R opened and read concurrently.

---------------------------------------------------------------
run_analysis.R

run_analysis.R uses all .txt files listed above except this README and features_info.txt. It merges the training and the test set to create one data set titled "Big_Dataset" Think about X_test.txt and X_train.txt as a dataset who's column names are found in features.txt. y_train/test.txt and subject_train/test provide information about each row in X_train/test respectively.The file activity_labels tells us the activity that each integer value in y_train/test corresponds to.

run_analysis.R also extracts the measurements on the mean and std deviation for each measurement. The data set with the mean and std deviation measurements extracted is titled "mean_std_dtframe"

lastly, run_analysis.R creates a second independent tidy dataset with the average of each variable for each activity and each subject titled "Tidy_Data". Since there are thirty subjects and six activities, there will be 180 rows in Tidy_Data. For more information about the experiment, please read README.TXT and features_info.txt

This is the end of the README.




