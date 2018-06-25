library(dplyr)
library(plotly)

# temp <- tempfile()
# download.file("")

# Load dataset
myData <- read.csv(unz("STC_2015_00A1.zip","STC_2015_00A1.csv"), 
                   header = TRUE, skip = 1)

# Data Transformation
myData <- myData[,-c(1:2,4:6)]
colnames(myData) <- c("state","tax","amount")
myData$code <- state.abb[match(myData$state,state.name)]
myData <- myData[complete.cases(myData),]

# Choropleth Mapping
borders <- list(color = toRGB("white"))
map_options <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB("white")
)

myData %>% filter(tax == 'Total Taxes') %>% 
    plot_ly(z = ~amount,locations=~code, type = 'choropleth', 
        locationmode = 'USA-states',color = ~amount, colors = 'Blues') %>%
  colorbar(title = '000s USD', thickness = 15) %>%
  layout(geo = map_options)

# Stack Bar Chart
myData %>% filter(code == 'AL' & tax != 'Total Taxes') %>%
    top_n(5,amount) %>%
    plot_ly(x = ~amount, y= ~reorder(tax, amount), type = "bar", orientation = "h") %>%
    layout(yaxis = list(title = ""), text = "inside")
