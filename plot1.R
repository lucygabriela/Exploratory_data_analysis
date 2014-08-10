#----------------------------------------------------
#  CLEANING WORKSPACE
#-----------------------------------------------------
rm(list=ls())

#----------------------------------------------------
#  READING FILE FROM THE WEB
#-----------------------------------------------------
install.packages("downloader")
library(downloader)

if(!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileUrl, "./data/household_power_consumption.zip", mode = "wb")


#----------------------------------------------------
#  UNZIP FILE HOUSEHOLD_POWER_CONSUMPTION.ZIP
#-----------------------------------------------------
unzip("./data/household_power_consumption.zip", exdir="./data")


#----------------------------------------------------
#  READING FILE USING fread(...)
#-----------------------------------------------------
install.packages("data.table")
library(data.table)

data<-suppressWarnings(fread("./data/household_power_consumption.txt"))


#---------------------------------------------
#    FILTERING DATA (2007-02-01 and 2007-02-02)
#---------------------------------------------
dataSub<-subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")


#---------------------------------------------
#    BUILDING PLOT 1
#---------------------------------------------
if(!file.exists("plot")) {dir.create("plot")}

png(file="./plot/plot1.png", width = 480, height = 480, units = "px")
op<-par(mar=c(4,6,4,0))
hist(as.numeric(dataSub$Global_active_power), col="red", 
       xlab="Global Active Power (kilowatts)", main="Global Active Power", )
par(op)
dev.off()


