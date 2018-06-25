# Course Project 1 for Week 1 of Exploratory Data Analysis:
# Plot 4

# Assignment uses data from UC Irvine Machine Learning Repository. 
# The data set is the "Individual household electric power consumption
# Data Set". The scope of analysis is limited to measurements taken on 
# 2007-02-01 and 2007-02-02. This script will get and load the data, 
# and create a series of plots and save the resulting plots to a png file. 
# Refer to readme file for more on the data set.
# 

# libraries
require(data.table)
require(lubridate)
require(dplyr)
require(ggplot2)
require (reshape2)
require(gridExtra)

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
epc$Date_Time <- ymd_hms(paste(epc$Date,epc$Time, sep = " "))

#Plot time series for Global Active Power and save to png file.
png(filename = "plot4.png", height = 480, width = 480)

#Time series plot for Global Active Power
GAP.ts <- ggplot(data = epc, aes(Date_Time,Global_active_power))+ 
          geom_line()+ xlab("")+ ylab("Global Active Power (kilowatts)")+
          scale_x_datetime(date_breaks = "1 day", date_labels = "%a")

#Time series for voltage measurements
Vol.ts <- ggplot(data = epc, aes(Date_Time,Voltage))+geom_line()+
          xlab("Date & Time") + ylab("Voltage")+
          scale_x_datetime(date_breaks = "1 day", date_labels = "%a")

#Time series for Energy Sub Metering measurements.
sub.data <- select(epc,Date_Time,Sub_metering_1:Sub_metering_3)
sub.data <- melt(sub.data,id = c("Date_Time"))

Sub.ts <- ggplot(data = sub.data,aes(Date_Time,value, color = variable))+ 
          geom_line()+ xlab("")+ylab("Energy sub metering")+
          scale_x_datetime(date_breaks = "1 day", date_labels = "%a")+
          scale_color_manual(values=c('black','red','blue'))+
          theme(legend.justification = c(1,1),legend.position = c(1,1), 
          legend.title = element_blank(),
          legend.background = element_rect(color = "black"))

#Time series for Global Reactive Power measurements.
GRP.ts <- ggplot(data = epc, aes(Date_Time,Global_reactive_power))+
          geom_line()+ xlab("Date & Time") + 
          ylab("Global Reactive Power (kilowatts)")+
          scale_x_datetime(date_breaks = "1 day", date_labels = "%a")

#Add all plots together.
grid.arrange(GAP.ts,Vol.ts,Sub.ts,GRP.ts,nrow = 2, ncol = 2)

dev.off()