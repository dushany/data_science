# file: text_process.R
# date: 7 November 2017
# author: Dushan Yovetich
# description:
# Processing of text provided from Swiftkey for the 
# Coursera Capstone Project.

# Libraries:
# library(tidyverse)
# library(stringi)

#remove profane words from Corpus. List obtained from 
#http://www.frontgatemedia.com/a-list-of-723-bad-words-to-blacklist-
#and-how-to-use-facebooks-moderation-tool/
if (!exists("swear_words")){
  swear_words <- read_csv("terms_to_block.csv",col_names = FALSE, skip = 4) %>% 
    select(X2)
  swear_words <- stri_replace_all(swear_words$X2, "",fixed = ",")
}

#Pre-process text file.
process_text <- function(dt_tbl){
  dt_tbl %>%
    filter(stri_detect_regex(text,paste(swear_words,collapse = "|"),negate = TRUE)) %>% 
    mutate(text = stri_replace_all(text,regex = "[^[:ascii:]]","")) %>%
    mutate(text = stri_replace_all(text,regex = "[[:digit:]]","")) %>%
    mutate(text = stri_replace_all(text,regex = "[^[:print:]]","")) %>%
    mutate(text = stri_replace_all(text,fixed = "_"," ")) %>% 
    mutate(text = stri_trans_tolower(text,locale = "en"))
}