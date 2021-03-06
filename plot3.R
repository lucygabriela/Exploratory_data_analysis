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
#    BUILDING PLOT 3
#---------------------------------------------
if(!file.exists("plot")) {dir.create("plot")}

Sys.setlocale("LC_TIME", "English")  
DateTime<- strptime(paste(dataSub$Date, dataSub$Time), "%d/%m/%Y %H:%M:%S")


png(file="./plot/plot3.png", width = 480, height = 480, units = "px")

op<-par(mar=c(2,6,2,2))
yrange<-range(c(as.numeric(dataSub[,7]), as.numeric(dataSub[,8], dataSub[,9])))
plot(DateTime, dataSub[,7], ylim=yrange, xlab="", ylab="Energy sub metering", 
      type="l", cex.lab=1.2)
lines(DateTime, dataSub[,8], col="red")
lines(DateTime, dataSub[,9], col="blue")
legend("topright", paste("Sub_metering_", 1:3, sep=""), lty=1, cex=0.90,
         col=c("black", "red", "blue"))
par(op)

dev.off()


