# file: text_process.R
# date: 26 November 2017
# author: Dushan Yovetich
# description:
# user-interface of Shiny web application.

library(shiny)

shinyUI(fluidPage(
  titlePanel(div(img(src = "Logo.tiff", 
                     style = "height: 50px; 
                     width: 50px")
                 ,"Next Word")),
  tabsetPanel(
    
    #Application Tab
    tabPanel("Application",
             
      column(width = 3),
      column(width = 6,
             
        #Buffer
        fluidRow(
                 column(width=1),
                 column(width=10,
                    h6("Enter a word, or phrase in the input box. Your text or
                        phrase will be displayed. A set of three choices will
                        be presented once a space is entered for the next word. 
                        Click on one of the choices to update your text with the
                        desired word, or simply continue typing.")
                        ),
                 column(width=1)
                 
                 ),
        
        wellPanel(
          # Output
          fluidRow(
            column(width=1),
            column(width=10, height = 10,
                   style = "padding:20px;
                   background-color:#FFFFFF;
                   border-style:solid; 
                   border-width: 0.5px;",
                   align ="center",htmlOutput("input_text")),
            column(width=1)
          ),
          
          # Word predictions
          fluidRow(
            column(width=4, align="right", uiOutput("input1")),
            column(width=4, align="center", uiOutput("input2")),
            column(width=4, align="left", uiOutput("input3"))
          ),
          
          # Input
          fluidRow(
            column(width=2,"-->",style = "padding:25px"),
            column(width=8, align="center",
                   textInput(inputId = "input_text", 
                             label = "", value = "")),
            column(width=2)
          )
        )
             
      ),
      column(width = 3)
             
    ),
    
    #About Tab
    tabPanel("About",
             
      fluidRow(style = "height:50px"),
      
      fluidRow(
        column(width = 2),
        column(width = 5,
               h4(div(img(src = "Logo.tiff", 
                          style = "height: 50px; 
                          width: 50px")
                      ,"Next Word")),
               h6("Version 1.1 (1.1.00000) - Dushan Yovetich, February 2018"),
               h6("Shiny Application built as part of the John Hopkins Data 
                   Science Capstone. Designed to mimic predictive texting on 
                   mobile phone devices."), 
               br(),
               h6(div("For more information, refer to:",
               a(href = "https://github.com/dushany/NLP_Capstone","GitHub Page")))
        ),
        column(width = 5)
      )
    
    )
  )
 )
)