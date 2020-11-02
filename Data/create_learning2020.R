# Ville Turppo, 1.11.2020, This is the new Rscript for week 2.
test2 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(test2)
# row and columns
str(test2)
#str shows compactly the data
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
install.packages("dplyr")
library(dplyr)

deep_columns <- select(test2, one_of(deep_questions))
test2$deep <- rowMeans(deep_columns)

surface_columns <- select(test2, one_of(surface_questions))
test2$surf <- rowMeans(surface_columns)

strategic_columns <- select(test2, one_of(strategic_questions))
test2$stra <- rowMeans(strategic_columns)

# next keeping only 7 variables
columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
end33 <- select(test2, one_of(columns))

colnames(end33)

end33$attitude <- end33$Attitude / 10
end33$straX <- end33$stra / 8
end33$deepX <- end33$deep / 12
end33$surfX <- end33$surf / 12
end33 <- filter(end33, Points > 0)

tolpat <- c("gender","Age","attitude", "deepX", "straX", "surfX", "Points")
final4 <- select(end33, one_of(tolpat))
dim(final4)

final4
write.table(final4, file = "C:/Users/ville/OneDrive/Työpöytä/Open science kurssi 2020/IODS-project/data/week2.csv", sep = "\t")
XX <- read.table("C:/Users/ville/OneDrive/Työpöytä/Open science kurssi 2020/IODS-project/data/week2.csv", sep = "\t")
head(XX)
str(XX)
dim(XX)
