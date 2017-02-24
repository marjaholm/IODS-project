## Marja Holm, The Data wrangling 5, 
#the 'human' data originates from the United Nations Development Programme:
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1


#Read the data into R from the url
human<- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep=",", header=T)
names(human)
#the structure of the data
str(human)
#the dimensions of the data
dim(human)
human$GNI
# 1.Mutate the data: transform the Gross National Income (GNI) variable to numeric 


# access the stringr package

library(stringr)
library(dplyr)
# look at the structure of the GNI column in 'human'
print(human$GNI)

# transform the Gross National Income (GNI) variable to numeric
human<-mutate(human, GNI=str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric)


print(human$GNI)

#2. Exclude unneeded variables: keep only the columns matching the following variable names 
#(described in the meta file above):  "Country", 
#"Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" 

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))
dim(human)

#3. Remove all rows with missing values 

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human<- filter(human, complete.cases(human)==TRUE)
human
dim(human)

# 4.Remove the observations which relate to regions instead of countries. 

# look at the last 10 observations of human
tail(human, n=10L)

# define the last indice we want to keep
last <- nrow(human) - 7
last

# choose everything until the last 7 observations relating to regions not country
human <- human[1:last,]
human
dim(human)

#5.Define the row names of the data by the country names and remove the country name 
#column from the data. The data should now have 155 observations and 8 variables.
#Save the human data in your data folder including the row names. 
#You can overwrite your old 'human' data. 

# add countries as rownames
rownames(human) <- human$Country

# remove the Country variable
human <- select(human, -Country)
dim(human)

#save the human data
#Saving the R.file into csv format. 
write.table(human, file="human.csv")

#Checking that scv file can be read and same dimensions are present 
test<-read.table("human.csv")
str(test)
head(test)