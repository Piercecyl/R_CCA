library(tm)
library(jiebaR)
library(sna)
library(igraph)
r<-VCorpus(DirSource(directory = "D:/R/論文/MA_allcompany/2017/test"
                               ,encoding = "UTF-8"))
r <- tm_map(r ,removeNumbers)
r <- tm_map(r ,stripWhitespace)
r <- tm_map(r ,removeWords ,stopwords("english"))
r <- tm_map(r ,stemDocument)
writeCorpus(r ,path = "D:/R/論文/MA_allcompany/2017/test")

all_code <- read.csv("D:/R/論文/MA_allcompany/2017/2017.csv" ,header = T)
all_code <- all_code$code
dic <- readLines("D:/R/論文/Textual variables/processed/collaborate.txt")
engine <- worker()
new_user_word(engine , dic)
dir.list = list.files("D:/R/論文/routers news/2017/processed/test" , full.name = TRUE)
codelist1 <- list()

for(i in 1:length(dir.list)){
  file1 = dir.list[i]
  s1 = readLines(file1,encoding="ASCII")
  s1 = toString(s1)
  segment <- engine[s1]
  temp <- which(segment %in% dic)
  if (length(temp) != 0) { 
    temp <- which(segment %in% all_code)
  }else {
    codelist1[[i]] <- NA
    next
  }
  codelist1[[i]] <- segment[temp] #codelist1 將文章中有出現在all_code的公司代碼儲存
}
codelist1 <- t(sapply(codelist1, '[', seq(max(lengths(codelist1)))))

#########################################change#################################################################
write.csv(codelist1,file = "D:/R/論文/output/collaborate/companycode1.csv")
#########################################change#################################################################
input <- read.csv("D:/R/論文/output/collaborate/companycode1.csv")


#########################################change#################################################################
#########################################open excel#############################################################
write.csv(input,file = "D:/R/論文/output/collaborate/companycode_input1.csv")

lines=scan(file="D:/R/論文/output/collaborate/companycode_input1.csv",what="character",sep="\n",skip=1) # read the csv file (skipping the header), line-by-line as character string.
lines=gsub(","," ",lines) # replace commas with spaces
lines=gsub("[ ]+$","",gsub("[ ]+"," ",lines)) # remove trailing and multiple spaces.
adjlist=strsplit(lines," ") # splits the character strings into list with different vector for each line
col1=unlist(lapply(adjlist,function(x) rep(x[1],length(x)-1))) # establish first column of edgelist by replicating the 1st element (=ID number) by the length of the line minus 1 (itself)
col2=unlist(lapply(adjlist,"[",-1)) # the second line I actually don't fully understand this command, but it takes the rest of the ID numbers in the character string and transposes it to list vertically
el1=cbind(col1,col2) # creates the edgelist by combining column 1 and 2.
write.csv(el1,file = "D:/R/論文/output/collaborate/el1.csv")

d <- read.csv("D:/R/論文/output/collaborate/el1.csv")
d <- graph_from_data_frame(d , directed = T)
c <- degree(d)
c <- as.data.frame(c)
write.csv(c,file = "D:/R/論文/output/collaborate/degree_collaborate.csv")
