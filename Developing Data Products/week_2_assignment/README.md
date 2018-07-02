# Week 2 Assignment - R Markdown and Leaflet
## Red Light Camera Violations in the City of Chicago

The assignment is to create a web page using R Markdown and featuring a map created with Leaflet.
The webpage is to be hosted on either GitHub Pages, RPubs, or NeoCities, and contain the date
created.

## Red Light Cameras
I created a map which plots the location of the City of Chicago's red light cameras and the total number of violations for each for the current calendar year.

## Data
The data is a modified version of the City of Chicago's dataset of daily volume of violations created by the Red Light Program for each camera. The original dataset can be found on the City of Chicago's Data Portal (https://data.cityofchicago.org/Transportation/Red-Light-Camera-Violations/spqx-js37), and contains all violations regardless of whether a citation was actually issued. 

For the purpose of my analysis, we limited our scope to the period 01-01-2017 to present - the original dataset includes July 1, 2014 to present.  The violations are also summarized by camera ID. 

More information on the city's Red Light Camera Program can be found here: http://www.cityofchicago.org/city/en/depts/cdot/supp_info/red-light_cameraenforcement.html