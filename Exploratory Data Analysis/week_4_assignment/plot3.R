# Course Project 1 for Week 1 of Exploratory Data Analysis:
# Plot 3

# Assignment uses data from UC Irvine Machine Learning Repository. 
# The data set is the "Individual household electric power consumption
# Data Set". The scope of analysis is limited to measurements taken on 
# 2007-02-01 and 2007-02-02. This script will get and load the data, 
# and create a time series plot for sub metering measurements1 to 3, and
# save the resulting plot to a png file. Refer to readme file for more on
# the sub metering measurements.

# libraries
require(data.table)
require(lubridate)
require(dplyr)
require(ggplot2)
require (reshape2)

# Download zip file with all data if not already completed.
fname <- "household_power_consumption.txt"

if (!file.exists(fname)) {
    temp <- tempfile()
    fileUrl <- paste0("https://d396qusza40orc.cloudfront.net/exdata",
                      "%2Fdata%2Fhousehold_power_consumption.zip")
    
    download.file(fileUrl, temp, quiet = TRUE, mode = "wb")
    downloadDate <- format(now(),"%Y-%m-%d %H:%M:%S")
    cat("Download completed ", downloadDate, "\n")
    unzip(temp)
    cat("File(s) unzipped to ", getwd(), "\n")
    
}

# read data set into data table.
epc <- fread(fname, na.strings = "?")

# Parse date and filter to get rows for dates in scope.
epc$Date <- dmy(epc$Date)
epc <- filter(epc, (Date == "2007-02-02" | Date == "2007-02-01"))

# merge date and time, then parse to get proper date/time format.
# Subset data for measurements and merge into a single column.
epc$Date_Time <- ymd_hms(paste(epc$Date,epc$Time, sep = " "))
sub.data <- select(epc,Date_Time,Sub_metering_1:Sub_metering_3)
sub.data <- melt(sub.data,id = c("Date_Time"))

#Plot time series for Sub metering and save to png file.
png(filename = "plot3.png", height = 480, width = 480)

base <- ggplot(data = sub.data,aes(Date_Time,value, color = variable))+ 
        geom_line()

base <- base + xlab("")+ylab("Energy sub metering")+
        scale_x_datetime(date_breaks = "1 day", date_labels = "%a")+
        ggtitle("Sub Metering Measures by Day")

print(base + scale_color_manual(values=c('black','red','blue'))+
      theme(legend.justification = c(1,1),legend.position = c(1,1), 
      legend.title = element_blank(),
      legend.background = element_rect(color = "black")))

dev.off()