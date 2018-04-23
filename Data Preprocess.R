library(tm)
#tm
r<-VCorpus(DirSource(directory = "D:/R/論文/routers news/2015"
                     ,encoding = "UTF-8"))
r <- tm_map(r ,removeNumbers)
r <- tm_map(r ,stripWhitespace)
r <- tm_map(r ,removeWords ,stopwords("english"))
r <- tm_map(r ,stemDocument)
writeCorpus(r ,path = "D:/R/論文/routers news/2015/processed")




#文章縮詞
all_com <- read.csv("D:/R/論文/MA_allcompany/2015_2015/2015_2017.csv")
all_com <- all_com$code
all_com_space <- read.csv("D:/R/論文/MA_allcompany/2015_2015/2015_2017_1.csv")
all_com_space <- all_com_space$code


dir.list = list.files("D:/R/論文/routers news/2015/processed" , full.name = TRUE)
for (x in 1:length(dir.list)) {
  file1 = dir.list[x]
  s1 = readLines(file1 ,encoding = "UTF-8")
  s1 <- toString(s1)
  for (Y in 1:215) {
    A <- gsub(all_com[Y] ,replacement = all_com_space[Y] ,s1)
    s1 <- A
  }
  write.table(A, file = file1,
              sep = " ", quote = FALSE, na = "NA")
}
