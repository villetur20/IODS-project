
# Week 6 Data wrangling, Ville Turppo

# Reading the datasets

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RAT <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)


# 1) checking the data
variable.names(BPRS); str(BPRS) ; summary(BPRS); head(BPRS); glimpse(BPRS)
variable.names(RAT); str(RAT) ; summary(RAT); head(RAT); glimpse(RAT)

# The BPRS data is about evaluating two psychiatric treatments. The study population is divided to treatment groups 1 and 2.
# The brief psychiatric rating scale (BPRS) is repeated at baseline (week 0) and the following 8 weeks for all 40 subjects.
# The RATS data is about measuring the weight of the rats in different diet groups.
# Both datasets are in the wide form. Thus, every measure of a single participant is on a same row.

library(dplyr)
library(tidyr)


# 2)  Converting categorical variables in BPRS (treatment, subject) and RAT (ID, group) to factors

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RAT$ID <- factor(RAT$ID)
RAT$Group <- factor(RAT$Group)

# 3) Converting the data to long form and creating Week and Time varibales

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject) %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <- RAT %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

glimpse(BPRSL); glimpse(RATSL)

# 4) Checking the datasets in wide form.
# The number of variables is now reduced in both sets. Also BPRS-score and weights at different times are now found in one variable.
# Even though, e.g. all weights are compressed to one "Weight" variable, the individual measurements can be distinguished by using "Time" variable.

variable.names(BPRSL); str(BPRSL) ; summary(BPRSL); head(BPRSL); glimpse(BPRSL); summary(BPRSL$week)
variable.names(RATSL); str(RATSL) ; summary(RATSL); head(RATSL); glimpse(RATSL); summary(RATSL$Time)

# 5) Saving the data
getwd()

write.table(BPRSL, file = "C:/Users/ville/OneDrive/Työpöytä/Open science kurssi 2020/IODS-project/Data/BPRSL.csv")
write.table(RATSL, file = "C:/Users/ville/OneDrive/Työpöytä/Open science kurssi 2020/IODS-project/Data/RATSL.csv")
