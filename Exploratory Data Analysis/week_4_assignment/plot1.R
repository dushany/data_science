# Course Project 1 for Week 1 of Exploratory Data Analysis:
# Plot 1

# Assignment uses data from UC Irvine Machine Learning Repository. 
# The data set is the "Individual household electric power consumption
# Data Set". The scope of analysis is limited to measurements taken on 
# 2007-02-01 and 2007-02-02. This script will get and load the data, 
# and create a histogram for household global minute-averaged active 
# power, and save the resulting plot to a png file. 

# libraries
require(data.table)
require(lubridate)
require(dplyr)


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

#Plot Histogram for Global Active Power and save to png file.
png(filename = "plot1.png", height = 480, width = 480)
hist(epc$Global_active_power,col = "red",
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
