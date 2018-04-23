library(httr)
library(rvest)
company_name <- read.csv("D:/R/論文/MA_allcompany/2017/name.csv")

for (i in 1:26) {
  url <- "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&company=companycode&type=10-k&dateb=20160101&owner=exclude&count=10"
  firsturl <- gsub("companycode",replacement = company_name$name[i] ,url)
  f <- read_html(firsturl) %>%  html_nodes("#seriesDiv td:nth-child(2) a") %>% html_attr('href')
  if(length(f) == 0){
    next
  }
  else{
    targeturl <- paste0("https://www.sec.gov" , f[1]) 
    t <- read_html(targeturl) %>% html_nodes("td:nth-child(3) a") %>% html_attr("href")
    article <- paste0("https://www.sec.gov" , t[1]) 
    x <- html_text(read_html(article))
    x <- gsub("\n" , "" ,x) 
    x <- gsub("\u00a0" ,"" ,x)
    Sys.sleep(runif(1,2,4))
    a1 = "D:/R/論文/年報/2017/"
    b1 = paste(company_name$name[i],"2014", sep = "_")
    c1 = ".txt"
    d1 = paste0(a1, b1, c1)
    write(x, file = d1)
  }

}

