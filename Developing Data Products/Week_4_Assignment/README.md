# DDP_Assignment_Wk4
## Shiny App
1. Create a Shiny application and deploy it on Rstudio's servers. The application must include the following:

- Some form of input (widget: textbox, radio button, checkbox, ...)
- Some operation on the ui input in sever.R
- Some reactive output displayed as a result of server calculations
- Enough documentation so that a novice user could use your application.
- The documentation should be at the Shiny website itself.

2. Use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application. The presentation must include the following:

- Must be done in Slidify or Rstudio Presenter
- Must be 5 pages
- Must be hosted on github or Rpubs
- Must contain some embedded R code that gets run when slidifying the document

## Significant Earthquakes
Shiny App plots significant earthquakes around the world for the period 1978 to 2016. The Shiny App includes input controls to filter and modify the plot. Below are the final products.

https://dushany.shinyapps.io/Earthquakes/

http://rpubs.com/dyovet1/earthquakes

## Data Source
National Geophysical Data Center / World Data Service (NGDC/WDS): Significant Earthquake Database. National Geophysical Data Center, NOAA. doi:10.7289/V5TD9V7K
https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1

The Significant Earthquake Database contains information on destructive earthquakes from 2150 B.C. to the present that meet at least one of the following criteria: Moderate damage (approximately $1 million or more), 10 or more deaths, Magnitude 7.5 or greater, Modified Mercalli Intensity X or greater, or the earthquake generated a tsunami.

*File: EarthquakeData.csv*
The dataset used is a subset of the database. Parameters for dataset selected were earthquakes from 1978 to 2016 with a magnitude > 5.0. To see definition of variables, refer to the following link: https://www.ngdc.noaa.gov/nndc/struts/results?&t=101650&s=225&d=225

Original tab delimited file was converted to comma delimited file. Then, it was  transformed and exported.