# User Interface
library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Earthquakes Around The World 1978 - 2016"),
  h6("Information regarding significant earthquake events around the world for each year. 
     Information is limited to earthquakes registering a magnitude of 5.0 or higher for the 
     period 1978 to 2016."),
  sidebarPanel(
      h6("Use dropdown to specify a year for earthquake events."),
      selectInput("yearInput",label = "Year", 
                  choices = 1978:2016,selected = 2016),
      br(),
      hr(),
      strong("Map Options"),
      h6("Use dropdown to change map layer, and see additional
         geographic detail"),
      selectInput("mapLayer",label = "Map Layer",
                  choice = c("Default","Topography", "Ocean Base")),
      h6("Use slider to filter for earthquake events based on their
         magnitude."),
      sliderInput("rangeInput","Magnitude",min(5.0),max(10.0), 
                  value = c(5.0,10.0), step = 0.1)
  ),
  mainPanel(
      h6("Click on map markers to see specific earthquake event information."),
      leafletOutput("myMap", height = "400px"),
      hr(),
      h5("Number of Earthquakes by Month"),
      h6("Count of earthquake events by month for year specified in 
         the Year dropdown."),
      plotOutput("myPlot", height = "150px")
  )
  
))
