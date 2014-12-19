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
  
  #Remove cutoff words at end of sentences
  ckf_items[,2]<-str_replace_all(ckf_items[,2],"\\s+\\w*\\W+$","")
  
  #Remove duplicate records
  ckf_items<-unique(ckf_items);
  ckf_items;
}

#Process menu title and descriptions into keywords
generateKeyWords <- function(menu){
  library(tm);
  
  titles<-menu[,1];
  descriptions<-menu[,2];
  
  #stem descriptions
  #descriptions<-stemDocument(descriptions);
  
  #convert to lower case
  titles<-tolower(titles);
  descriptions<-tolower(descriptions);
  
  #remove IP symbols from titles
  titles<-str_replace_all(titles,"[™®]","");
  
  #append titles to front of descriptions to make key word list
  keyWordList<-paste(titles,descriptions);
  
  #Remove punctuation
  keyWordList<-removePunctuation(keyWordList);
  
  #Remove stop words
  stopWords <- readLines(system.file("stopwords", "english.dat",package = "tm"));
  keyWordList<-removeWords(keyWordList,stopWords);

  #Stem and Tokenize
  keyWordList<-lapply(keyWordList,scan_tokenizer);
  keyWordList<-lapply(keyWordList,unique);
  keyWordList;
}