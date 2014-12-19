#Extract and analyse menu items from the cheesecake factory menu
getMenuItems <- function(){
  library(rvest);
  library(stringr);
  
  #Save html from cheescake factory menu page
  ckf_menu <- html("http://www.thecheesecakefactory.com/menu");
  
  #Extract menu item titles based on css class
  menu_titles <- ckf_menu %>%
    html_nodes(".item-title") %>%
    html_text();
  
  #Extract menu item descriptions based on css class
  menu_descriptions <- ckf_menu %>%
    html_nodes(".item-description") %>%
    html_text();
  
  #Save titles and descriptions to data frame
  ckf_items <- cbind(Titles=menu_titles, Descriptions=menu_descriptions);
  
  #Remove whitespace from descriptions
  ckf_items[,2]<-str_replace_all(ckf_items[,2],"[\t\r\n]","");
  #Remove duplicate records
  ckf_items<-unique(ckf_items)
  return ckf_items
}