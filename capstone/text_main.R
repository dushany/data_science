# file: text_process.R
# date: 7 November 2017
# author: Dushan Yovetich
# description:
# Main file for the Coursera Capstone Project.

# Load libraries
library(tidyverse)
library(tidytext)
library(stringi)
library(data.table)

# Load text corpora. Due to size of files, decided to sample each.
source("text_load.R",local = TRUE)
file_path <- file.path(getwd(),"Coursera-SwiftKey.zip")

news <- read_text_file(file_path,"final/en_US/en_US.news.txt")
blog <- read_text_file(file_path,"final/en_US/en_US.blogs.txt")

corpus <- rbind(news,blog)

# Process text corpora
source("text_process.R",local = TRUE)
tidy_corpus <- process_text(corpus)

trigram <- tidy_corpus %>%
  unnest_tokens(ngram,text,token = "ngrams", n=3) %>%
  separate(col = ngram,into = c("w1","w2","w3"), sep = " ") %>%
  setDT()

# N-gram model
source("text_model.R",local = TRUE)

trigram <- trigram %>% 
  modified_kneser_ney(c("w1","w2","w3"))
trigram <- unique(trigram, by = c("w1","w2","w3"))

saveRDS(trigram, file = "kn_corpus.rds", compress = TRUE)
