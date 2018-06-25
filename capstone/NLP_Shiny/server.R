# file: text_process.R
# date: 26 November 2017
# author: Dushan Yovetich
# description:
# back-end server executions of Shiny web application. 

shinyServer(function(input, output, session) {
  
  #takes text input and splits into words to be used for our 
  #next word prediction. using a trigram for our predictions so this returns
  #the last two words (or singleton if text length = 1), plus "".
  split_text <- reactive({
    t <- input$input_text %>% 
      stringr::str_to_lower(locale = "en") %>% 
      stringr::str_split(" ", simplify = TRUE) %>% 
      as.vector()
    
    if (length(t) > 2) {
      tail(t,3)
    } else {
      t
    }
  })
  
  #function to access the text corpus and get next word based on probability.
  #function should return a vector of n terms.
  get_word <- function(a,b,n=3) {
    
    if (missing(a) & missing(b)) {
      kn_corpus[,head(.SD,1),by = w3][,.SD[1:n]][,w3]
    }else if (missing(b)) {
      kn_corpus[w2 == a,.SD[which.max(p_mkn)],by = w3][,.SD[1:n]][,w3]
    } else {
      kn_corpus[w1 == a & w2 == b,.SD[which.max(p_mkn)],by = w3][
        ,.SD[1:n]][,w3]
    }
    
  }
  
  #gets the next word predictions based on the text input. evaluates what text
  #has been entered and makes the appropriate calls to get_word function.
  next_word <- reactive({
    
    if (length(split_text()) > 1 & tail(split_text(),1) == "") {
      
      if (length(split_text()) > 2) {
        
        w <- get_word(a = split_text()[1],b = split_text()[2])
      } else {
        w <- get_word(a = split_text()[1])
      }
    
      if (anyNA(w)) {
        
        num_words <- sum(is.na(w))
        
        if (split_text()[2] %in% kn_corpus[,w2]) {
          
          m <- get_word(a = split_text()[2],n = num_words)
          if (anyNA(m)) {
            num_words2 <- sum(is.na(m))
            m[is.na(m)] <- get_word(n = num_words2)
          }
          
        } else {
          m <- get_word(n = num_words)
        }
        w[is.na(w)] <- m
      }
      w
    }
  })
  
  #shiny outputs. shows text input on screen and the suggested words returned
  #from next word prediction.
  output$input_text <- renderUI(input$input_text)
  
  output$input1 <- renderUI(
    actionLink("choice1", label = HTML(next_word()[1]))
  )
  output$input2 <- renderUI(
    actionLink("choice2", label = HTML(next_word()[2]))
  )
  output$input3 <- renderUI(
    actionLink("choice3", label = HTML(next_word()[3]))
  )
  
  #shiny inputs to update text for suggested words returned from next word 
  #predictions, and accepted by user. 
  observeEvent(input$choice1,{
    txt <- paste0(input$input_text,next_word()[1]," ")
    updateTextInput(session,inputId = "input_text",value = txt)
  })
  
  observeEvent(input$choice2,{
    txt <- paste0(input$input_text,next_word()[2]," ")
    updateTextInput(session,inputId = "input_text",value = txt)
  })
  
  observeEvent(input$choice3,{
    txt <- paste0(input$input_text,next_word()[3]," ")
    updateTextInput(session,inputId = "input_text",value = txt)
  })
  
})
