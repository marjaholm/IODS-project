#Create_human data wrangling for the next week's data, Marja Holm

#2. Read the "Human development" and  "Gender inequality" datas into R. 
#Here are the links to the datasets: 

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#3. Explore the datasets: see the structure and dimensions of the data. 
#Create summaries of the variables.

str(hd)
dim(hd)
summary(hd)
str(gii)
dim(gii)
summary(gii)

#4. Look at the meta files and rename the variables with  descriptive names.

# print out the column names of the hd data
colnames(hd)

# change the name of the 1. colum ("HDI.Rank")
colnames(hd)[1] <- "HDI_rank"

# change the name of 2. column ("Country" )
colnames(hd)[2] <- "cntr"

# change the name of 3. column ("Human.Development.Index..HDI.")
colnames(hd)[3] <- "HDI"

# change the name of 4. column ("Life.Expectancy.at.Birth")
colnames(hd)[4] <- "LEB"

# change the name of 5. column ("Expected.Years.of.Education")
colnames(hd)[5] <- "EYE"

# change the name of 6. column ("Mean.Years.of.Education")
colnames(hd)[6] <- "MYE"

# change the name of 7. column ("Gross.National.Income..GNI..per.Capita)
colnames(hd)[7] <- "GNI_cap"

# change the name of 8. column (""GNI.per.Capita.Rank.Minus.HDI.Rank")
colnames(hd)[8] <- "GNI_cap_mHDI"

# print out the new column names of the hd data
colnames(hd)

# print out the new column names of the gii data
colnames(gii)

# change the name of the 1. colum ("GII.Rank")
colnames(gii)[1] <- "GII_rank"

# change the name of 2. column ("Country")
colnames(gii)[2] <- "cntr"

# change the name of 3. column ("Gender.Inequality.Index..GII")
colnames(gii)[3] <- "GII"

# change the name of 4. column ("Maternal.Mortality.Ratio")
colnames(gii)[4] <- "MMR"

# change the name of 5. column ("Adolescent.Birth.Rate")
colnames(gii)[5] <- "ABR"

# change the name of 6. column ("Percent.Representation.in.Parliament")
colnames(gii)[6] <- "PRP"

# change the name of 7. column ("Population.with.Secondary.Education..Female")
colnames(gii)[7] <- "PSEF"

# change the name of 8. column ("Population.with.Secondary.Education..Male.")
colnames(gii)[8] <- "PSEM"

# change the name of 9. column ("Labour.Force.Participation.Rate..Female.")
colnames(gii)[9] <- "LFPRF"

# change the name of 10. column ("Labour.Force.Participation.Rate..Male.")
colnames(gii)[10] <- "LFPRM"

# print out the new column names of the data
colnames(gii)

#5. Mutate the "Gender inequality" data and create two new variables. 
#The first one should be the ratio of Female and Male populations with secondary 
#education in each country. (i.e. edu2F / edu2M). 
#The second new variable should be the ratio of labour force participation of 
#females and males in each country (i.e. labF / labM).

# access the dplyr library
library(dplyr)

#the ratio of Female and Male populations with secondary education in each country
gii <- mutate(gii, rat_sex_PSE = PSEF/PSEM)

#the ratio of labour force participation of females and males in each country
gii <- mutate(gii, rat_sex_LFPR = LFPRF/LFPRM)

gii

#6. Join together the two datasets using the variable Country as the identifier. 
#Keep only the countries in both data sets (Hint: inner join). 
#Call the new joined data human and save it in your data folder.

# access the dplyr library
library(dplyr)

# join the two datasets by the selected identifiers country
human <- inner_join(hd, gii, suffix=c(".hd", ".gii"), by="cntr")

#195 observations and 19 variables
str(human)
dim(human)

#Saving the R.file into csv format. 
write.table(human, file="human.csv")

#Checking that csv file can be read and same dimensions are present 
human<-read.table("human.csv")
str(human)
head(human)



