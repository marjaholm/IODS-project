#1.
"Marja Holm, 31.1.2017, this is create-learning2014 file for task 1"
#----------------------------------------------------------------------------
#2.
#read the the full learning2014(=lrn14) data into memory 
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
#print the data
lrn14
# look at the structure of the data
str(lrn14)
# look at the dimensions of the data
dim(lrn14)
#Strucuture: Variables values are often integers and one gender factor
#Dimension: 183 observations and 60 variables
#-----------------------------------------------------------------------------------
#3. 
# Create an analysis dataset with the variables 
#gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data
# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset le2014
le2014 <- select(lrn14, one_of(keep_columns))

# print le2014
le2014

# Exclude observations where the exam points variable is zero. 
le2014 <- filter(le2014, Points > 0)

#The data should then have 166 observations and 7 variables
dim(le2014)

#4. Set the working directory of you R session the iods project folder.
# Save the analysis dataset to the 'data' folder, using for example write.csv() 
#or write.table() functions.Demonstrate that 
#you can also read the data again by using read.table() or read.csv().

x <- data.frame(a = I("a \" quote"), b = pi)
write.csv(x, file = "learning2014.csv")
read.csv("learning2014.csv", row.names = 1)
