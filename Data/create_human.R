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
