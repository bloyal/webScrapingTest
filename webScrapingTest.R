#test using rvest package

library(rvest);
lego_movie <- html("http://www.imdb.com/title/tt1490017/")

lego_movie %>% 
  html_node("strong span") %>% 
  html_text() %>% 
  as.numeric()

