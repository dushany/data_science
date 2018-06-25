# back-end server file
library(shiny)
library(dplyr)
library(lubridate)
library(leaflet)
library(ggplot2)
library(htmlTable)

# Load and transform dataset
eq <- read.csv("eqdata.csv", header = TRUE)

# function to create popup table
myTable <- function(x){
    myVal <- c(x[2],x[4],x[7])
    myHeader <- c("Date","Magnitude","Location")
    htmlTable(myVal,header = myHeader)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    eq1 <- reactive ({eq %>% filter(year(date) == input$yearInput)})
    
    eq2 <- reactive ({
        eq %>% filter(year(date) == input$yearInput) %>% 
        filter(magnitude > input$rangeInput[1] & magnitude < input$rangeInput[2]) 
        })
    
    myPopup <- reactive ({
        apply(eq2(),1,myTable) })
    
    factpal <- reactive ({
        colorFactor(heat.colors(5),eq$factor, reverse = TRUE) })
    
    output$myMap <- renderLeaflet({
        leaflet(eq, options = tileOptions(minZoom = 1)) %>% 
            setMaxBounds(300,-85,-300,85)
   })
    
    observe ({
        pal <- factpal()
        leafletProxy("myMap",data = eq2()) %>%
            clearMarkers() %>% clearControls() %>%
            addCircleMarkers(color = ~pal(factor),popup = myPopup()) %>%
            addLegend(title = "Magnitude", pal = pal, values = ~factor) %>%
            fitBounds(~min(longitude), ~min(latitude), ~max(longitude), ~max(latitude))
    })
    
    observe({
        proxy <- leafletProxy("myMap", data = eq)
        
        if(input$mapLayer == "Topography") {
            proxy %>% clearTiles() %>%
            addProviderTiles(providers$OpenTopoMap)
        } else if (input$mapLayer == "Ocean Base") {
            proxy %>% clearTiles() %>%
            addProviderTiles(providers$Esri.OceanBasemap)
        } else {
            proxy %>% clearTiles() %>% addTiles()
        }
    })
    
    output$myPlot <- renderPlot({
        ggplot(eq1(), aes(month(date, label = TRUE))) +
        geom_histogram(stat = "count",fill = "blue") +
        labs(x = "",y = "")
    })

})
