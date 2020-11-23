# Ville Turppo, 15.11.2020. Creating new R script for week 5 exercises. "create_human.R"

#Reading the datasets to R

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Next checkin the structure, dimensions and summaries of the datasets.

str(hd)
dim(hd)
str(gii)
dim(gii)

# There are 195 rows in the "hd" dataset and 8 variables. The dataset seems to be about GNI, HDI, life expectency and education.
# The "gii" dataset has also 195 rows, but 10 variables. This data seems to tell about gender inequalities, education and labour participation of men and women.

# summaries of the datasets' variables:mean,median,25th and 75th quartiles,min,max
summary(hd)
summary(gii)

# Checking the current variablenames
colnames(hd)
colnames(gii)

# Activating dplyr library for renaming variables.
library(dplyr)

# Renaming variables, could have done this whit 1 command just using "," when seperating the names
hd <- hd %>% rename(HDI = Human.Development.Index..HDI.)
hd <- hd %>% rename(lifex = Life.Expectancy.at.Birth)
hd <- hd %>% rename(eduex = Expected.Years.of.Education)
hd <- hd %>% rename(edumean = Mean.Years.of.Education)
hd <- hd %>% rename(GNI = Gross.National.Income..GNI..per.Capita)
hd <- hd %>% rename(grmhr = GNI.per.Capita.Rank.Minus.HDI.Rank)
colnames(hd)

# Same nameswap for "gii"
colnames(gii)
gii <- gii %>% rename(GII = Gender.Inequality.Index..GII., mmr = Maternal.Mortality.Ratio, abr = Adolescent.Birth.Rate, parli = Percent.Representation.in.Parliament, edu2f = Population.with.Secondary.Education..Female., edu2m = Population.with.Secondary.Education..Male., labf = Labour.Force.Participation.Rate..Female., labm = Labour.Force.Participation.Rate..Male.)
colnames(gii)

# Creating 2 new variables to "gii" dataset (F/M secondary education, F/M labour force participation)

gii <- mutate(gii, eduratio = edu2f / edu2m)
gii <- mutate(gii, labouratio = labf / labm)
colnames(gii)

#joining the datasets as one using Country as identifier.
#Created the identifier.
join <- c("Country")

#joining the sets, using inner_join.
hd_gii <- inner_join(hd, gii, by = join)

#As seen using the following commands, there are 195 observations and 19 variables.
colnames(hd_gii)
str(hd_gii)
dim(hd_gii)

getwd()
write.table(hd_gii, file = "C:/Users/ville/OneDrive/Työpöytä/Open science kurssi 2020/IODS-project/data/human.csv")




# Week 5 Datawrangling

##reading the data via internet link and exploring structure and dimension.

x <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)
str(x)
dim(x)
## There are 195 observations and 19 variables. Human development index (HDI)= index calculated using life expectancy, schooling and gross national income (GNI).
## This index takes in account more variables than just economic growth.
## Data includes also variables for work participation, amount of females in parliament, birth and mortality ratios.

## accessing libraries.
library(tidyr)
library(stringr)
library(dplyr)
str(x$GNI)

# 1) Transformin GNI variable
str_replace(x$GNI, pattern=",", replace ="")

# 2) Removing unwanted varibales.
keepx <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
x <- dplyr::select(x, one_of(keepx))

# 3) Removing rows with missing values. 
complete.cases(x)
data.frame(x[-1], comp = complete.cases(x))
x1 <- filter(x, complete.cases(x))

# 4) Excluding observations which are related to regions. As seen in results, the last 7 are combinations, not countries.
tail(x1, 10)
# "last"= last variable to keep
last1 <- nrow(x1) - 7
last1
x1_ <- x1[1:last1, ]
x1_

# 5) Countries to rownames and then removing country column. "Ready" = data without country column.

rownames(x1_) <- x1_$Country
x1_
Ready = subset(x1_, select = -Country)
## "dim(Ready)" 155 obs and 8 variables.
Ready
dim(Ready)

## Saving the "Ready" to human.csv and overwriting the old data.
write.table(Ready, file = "C:/Users/ville/OneDrive/Työpöytä/Open science kurssi 2020/IODS-project/data/human.csv", row.names = TRUE)
