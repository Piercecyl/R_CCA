library(stringr)
library(jsonlite)
library(curl)
library(rvest)
library(XML)
library(httr)
# rm(list = ls())
company_code <- read.csv("D:/R/論文/MA_allcompany/2016/2016_1.csv", header = T)

for (i in 153:158) {
  url <- "https://www.reuters.com/assets/searchArticleLoadMoreJson?blob=conpanycode&bigOrSmall=big&articleWithBlog=true&sortBy=&dateRange=&numResultsToShow=10&pn=pierce&callback=addMoreNewsResults"
  targeturl <- gsub("conpanycode",replacement = company_code$code[i] ,url)
  for (y in 1:200) {
    target_url <- gsub("pierce",replacement = y ,targeturl)
    # Sys.sleep(runif(1,2,4))
    url1 <- readLines(curl(target_url))
    if(is.na(url1[23])) 
    {break}
    else{
      a <- grep("href" ,url1)
      url1[a] <- gsub("            href: ",replacement = "" ,url1[a])
      url1[a] <- gsub("\"",replacement = "" ,url1[a])
      url1[a] <- gsub(",",replacement = "" ,url1[a])
      url1 <- as.list(url1[a])
      for(k in 1:length(url1[a])){
        if(length(grep("^http:" ,url1[k])) != 0){
          next
        }
        else{
          content_article = read_html(paste("https://www.reuters.com", url1[k], sep="")) %>% html_nodes(".ArticleHeader_date_V9eGk , .StandardArticleBody_body_1gnLA p") %>% html_text()
          Sys.sleep(runif(1,2,4))
          a1 = "D:/R/論文/routers news/2016/"
          b1 = paste(company_code$code[i], y, k, sep = "_")
          c1 = ".txt"
          d1 = paste0(a1, b1, c1)
          write(content_article, file = d1)
        }
        
      }
    }
  }
}





