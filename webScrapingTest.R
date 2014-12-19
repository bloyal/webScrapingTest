#test using rvest package

library(rvest);
library(stringr);
lego_movie <- html("http://www.imdb.com/title/tt1490017/");

lego_movie %>% 
  html_node("strong span") %>% 
  html_text() %>% 
  as.numeric();

ckf_menu <- html("http://www.thecheesecakefactory.com/menu");

menu_titles <- ckf_menu %>%
  html_nodes(".item-title") %>%
  html_text();

menu_descriptions <- ckf_menu %>%
  html_nodes(".item-description") %>%
  html_text();

ckf_items <- cbind(Titles=menu_titles, Descriptions=menu_descriptions);

ckf_items[,2]<-str_replace_all(ckf_items[,2],"[\t\r\n]","")
ckf_items[,2]<-str_trim(ckf_items[,2])