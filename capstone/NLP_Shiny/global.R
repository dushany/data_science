library(shiny)
library(tidyverse)
library(data.table)

#load and sort processed corpus
kn_corpus <- readRDS("kn_corpus.rds")
kn_corpus <- kn_corpus[order(-p_mkn)]
