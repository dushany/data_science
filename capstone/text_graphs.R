# file: text_graphs.R
# date: 17 July 2017
# author: Dushan Yovetich
# description:
# Graphing text data for the Coursera Capstone Project.

# Load libraries
# library(ggplot2)
# library(wordcloud)
# library(igraph)
# library(ggraph)

# Bar graphs
bar_graph <- function(dt_tbl){
  data("stop_words")
  dt_tbl%>%
    anti_join(stop_words) %>%
    count(word,sort=TRUE) %>%
    top_n(10) %>%
    mutate(word = reorder(word,n)) %>%
    ggplot(aes(word,n)) +
    geom_col() +
    xlab(NULL) +
    coord_flip()
}

# Word cloud
word_cloud <- function(dt_tbl) {
  data("stop_words")
  dt_tbl %>%
    anti_join(stop_words) %>%
    count(word) %>%
    with(wordcloud(word,n,max.words = 100))
  
}

# N nodes graph
ngram_nodes <- function(n_gram){
  
  data("stop_words")
  
  set.seed(199)
  
  ngram_count <- n_gram %>%
    filter(!w1 %in% stop_words$word,
           !w2 %in% stop_words$word,
           !w3 %in% stop_words$word)
  
  ngram_graph <- ngram_count %>%
    filter(n > 50) %>%
    graph_from_data_frame()
  
  ggraph(ngram_graph,layout = "fr")+
    geom_edge_link()+
    geom_node_point()+
    geom_node_text(aes(label = name),vjust = 1, hjust=1)
  
}


