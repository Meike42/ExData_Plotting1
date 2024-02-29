#Load libraries
library(dplyr)

#Download file

getwd()

zipfileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <-  download.file(zipfileUrl, destfile = "./ElectricPowerConsumption.zip")
outdir = getwd()
ElectricPowerConsumption <- unzip("./ElectricPowerConsumption.zip", exdir = outdir)
dateDownloaded_EPC <- date()
dateDownloaded_EPC

list.files(outdir)

#read in data
ECPtotal <- read.table("./household_power_consumption.txt", header = TRUE, 
                       sep = ";", na.strings = "?")
dim(ECPtotal)
names(ECPtotal)
head(ECPtotal)

#subset by date
table(ECPtotal$Date)
ECPdata <- filter(ECPtotal, Date == "1/2/2007" | Date == "2/2/2007")
dim(ECPdata)
table(ECPdata$Date)

#convert Date and Time to Date and Time classes
ECPdata$DateTime <- paste(ECPdata$Date,ECPdata$Time)
head(ECPdata)
ECPdata$DateTime <- strptime(ECPdata$DateTime, format = "%d/%m/%Y %H:%M:%S")
class(ECPdata$DateTime)
str(ECPdata)
head(ECPdata)

#create plot
png(filename = "plot2.png", width = 480, height = 480)

with(ECPdata, plot(DateTime, Global_active_power, type='l', 
              xlab = "", ylab='Global active power (kilowatts)',
              xaxt = "n"))

axis.POSIXct(1,at=pretty(ECPdata$DateTime, n=2),
             labels=c("Thu", "Fri", "Sat"))

dev.off()



     