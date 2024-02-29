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
png(filename = "plot3.png", width = 480, height = 480)

#Create empty plot
with(ECPdata, plot(DateTime, Sub_metering_1, type='n', 
                   xlab = "", ylab='Energy sub metering',
                   xaxt = "n"))

# Plot each line one by one
with(ECPdata, lines(DateTime, Sub_metering_1, type = "l", col = "black"))
with(ECPdata,lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(ECPdata,lines(DateTime, Sub_metering_3, type = "l", col = "blue"))

# Add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

axis.POSIXct(1,at=pretty(ECPdata$DateTime, n=2),
             labels=c("Thu", "Fri", "Sat"))

dev.off()



