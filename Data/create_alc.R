#Ville Turppo 9.11.2020, Time for week 3 exercises.

getwd()

# Reading the datasets and exploring head and dim.

por <- read.table("C:/Users/ville/OneDrive/Työpöytä/Open science kurssi 2020/IODS-project/Data/student-por.csv", sep = ";", header = TRUE)
mat <- read.table("C:/Users/ville/OneDrive/Työpöytä/Open science kurssi 2020/IODS-project/Data/student-mat.csv", sep = ";", header = TRUE)
head(por)
dim(por)
head(mat)
dim(mat)

# There are 33 variables in both datasets. Por has 649 row whereas Mat has 395

#joining and exploring the two sets

library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(mat, por, by = join_by, suffix = c(".math", ".por"))

dim(math_por)
str(math_por)

# Only joined columns
alc <- select(math_por, one_of(join_by))

# The other columns
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# Else and IF commands

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

glimpse(alc)

# Taking the average from weekday and weekend alcohol use.
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# Next high consumption.
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse of joined and mutated data.
glimpse(alc)
 # Resulting 382 obs. and 35 var.

getwd()

# Writing table
write.table(alc, file = "C:/Users/ville/OneDrive/Työpöytä/Open science kurssi 2020/IODS-project/Data/alc.csv", sep =";")
