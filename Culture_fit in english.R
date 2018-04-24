library(tm)
library(jiebaR)


codelist <- as.integer()
codelist1 <- as.integer()
codelist2 <- as.integer()
codelist3 <- as.integer()
codelist4 <- as.integer()
dic_coll <- readLines("D:/R/論文/Textual variables/processed/collaborate.txt")
dic_control <- readLines("D:/R/論文/Textual variables/processed/control.txt")
dic_create <- readLines("D:/R/論文/Textual variables/processed/create.txt")
dic_supply <- readLines("D:/R/論文/Textual variables/processed/supply.txt")
dic_complete <- readLines("D:/R/論文/Textual variables/processed/compete.txt")
engine <- worker()
dir.list = list.files("D:/R/論文/年報/2017/process" , full.name = TRUE)

for(i in 1:length(dir.list)){
  file1 = dir.list[i]
  s1 =readLines(file1,encoding="ANSI")
  s1 = toString(s1)
  segment <- engine[s1]
  temp <- which(segment %in% dic_coll)
  codelist[i] <- length(temp)
  temp <- which(segment %in% dic_control)
  codelist1[i] <- length(temp)
  temp <- which(segment %in% dic_create)
  codelist2[i] <- length(temp)
  temp <- which(segment %in% dic_supply)
  codelist3[i] <- length(temp)
  temp <- which(segment %in% dic_complete)
  codelist4[i] <- length(temp)
}
a <- cbind(dir.list ,codelist ,codelist1 ,codelist2 ,codelist3 ,codelist4)
write.csv(a ,"D:/R/論文/output/2017/Degree.csv")
