# Marja Holm, 7.2.2017
# my file for Data wrangling 2 concerning data of the Student Alcohol consumption
# loaded from here https://archive.ics.uci.edu/ml/machine-learning-databases/00356/
#---------------------------------------------------------------------------------
# 3. Read both student-mat.csv and student-por.csv into R (from the data folder) 
# and explore the structure and dimensions of the data.

# the working directory has been changed to IODS-project/data; files are in this data folder 
#read the data

math<-read.csv("student-mat.csv", sep =";" , header=TRUE)
por<-read.csv("student-por.csv", sep = ";" , header=TRUE)
#structure and dimensions
str(math)
str(por)
dim(math)
dim(por)
#-------------------------------------------------------------------------------------------
# 4. Join the two data sets using the variables 
#"school", "sex", "age", "address", "famsize", "Pstatus", 
# "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" 
#as (student) identifiers. Keep only the students present in both data sets. 
# Explore the structure and dimensions of the joined data. 

# access the dplyr library
library(dplyr)
# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, suffix=c(".math", ".por"), by=join_by)
str(math_por)
dim(math_por)
#------------------------------------------------------------------------------------------
#5. Either a) copy the solution from the DataCamp exercise The if-else structure to 
#combine the 'duplicated' answers in the joined data, or 
#b) write your own solution to achieve this task.

# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}


#------------------------------------------------------------------------------
#6. Take the average of the answers related to weekday and weekend alcohol consumption 
#to create a new column 'alc_use' to the joined data. Then use 'alc_use' to create a 
#new logical column 'high_use' which is TRUE for students for which 'alc_use' 
#is greater than 2 (and FALSE otherwise).

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

#-----------------------------------------------------------------------------------------------
#7. Glimpse at the joined and modified data to make sure everything is in order. 
#The joined data should now have 382 observations of 35 variables. 
#Save the joined and modified data set to the 'data' folder, 
#using for example write.csv() or write.table() functions. 

#The joined data have 382 observations of 35 variables
glimpse(alc)

#Saving the R.file into txt format. Before this the working 
write.table(alc, file="alcohol_consumption.csv")

#Checking that txt file can be read and same dimensions are present 
test<-read.table("alcohol_consumption.csv")
str(test)
head(test)
