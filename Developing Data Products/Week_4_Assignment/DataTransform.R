#R script to convert original data to prepared dataset.

library(dplyr)
library(lubridate)

# Load and transform dataset
eq <- read.csv("EarthquakeData.csv", header = TRUE)
eq <- mutate(eq,DATE = mdy(paste(MONTH,DAY,YEAR)))
eq <- mutate(eq,CASUALTIES = TOTAL_DEATHS + TOTAL_INJURIES)
eq <- mutate(eq,PROPERTY_DAMAGE = TOTAL_HOUSES_DESTROYED + TOTAL_HOUSES_DAMAGED)
eq <- select(eq,I_D,DATE,FOCAL_DEPTH,EQ_PRIMARY,INTENSITY,COUNTRY,
             LOCATION_NAME,LATITUDE,LONGITUDE,CASUALTIES,PROPERTY_DAMAGE)
colnames(eq) <- c("id","date","focal.depth","magnitude","intensity","country",
                 "location.name","latitude","longitude","casualties","property.damage")
eq$factor <- cut(eq$magnitude,breaks = 5:10, include.lowest = TRUE, right = FALSE)
write.csv(eq,file = "eqdata.csv",row.names = FALSE)
