# Reproducible Research, Course Project 1 (Optional)
# Uses a subset of a United States medical expenditures dataset with information 
# on costs for different medical conditions and in different areas of the country.

#Load library(s)
library(dplyr)
library(ggplot2)

# load data
fileName <- "_e143dff6e844c7af8da2a4e71d7c054d_payments.csv"
payments <- read.csv(fileName)

# Question 1 - what is the relationship between mean 
# covered charges (Average.Covered.Charges) and mean 
# total payments (Average.Total.Payments) in New York?

NY <- filter(payments,Provider.State == "NY")

pdf("Plot1.pdf", paper = "USr")
g <- ggplot(NY,aes(Average.Covered.Charges/1000,Average.Total.Payments/1000))+
     geom_point(alpha = 1/5) + labs(x = "Mean Covered Charges (000s)", y = "Mean Total Payments (000s)")+
     geom_smooth(method = "lm",se = FALSE)+
     ggtitle("Mean Covered Charges vs. Mean Total Payments for NY State")
print(g)
dev.off()

# Question 2 - how does the relationship between mean 
# covered charges (Average.Covered.Charges) and mean 
# total payments (Average.Total.Payments) vary by medical 
# condition (DRG.Definition) and the state in which care 
# was received (Provider.State)?

payments <- mutate(payments,DRG.Code = substr(DRG.Definition,1,3))

pdf("Plot2.pdf", paper = "USr")
g <- ggplot(payments,aes(Average.Covered.Charges/1000,Average.Total.Payments/1000,color = DRG.Definition))+
     geom_point(alpha = 1/2)+
     facet_grid(Provider.State~DRG.Code)+
     scale_y_log10("(Log) Mean Total Payments (000s)")+
     scale_x_log10("(Log) Mean Covered Charges (000s)")+
     theme(legend.position = "bottom",legend.text = element_text(size = 8),legend.title = element_blank())+
     guides(colour=guide_legend(nrow=6))+
     ggtitle("Mean Covered Charges vs. Mean Total Charges by Medical Condition and State")
print(g)
dev.off()