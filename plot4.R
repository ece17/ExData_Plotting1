## download data file
setwd("C:/Users/tshealy - admin/Desktop/datasciencecoursera/Course4")
downloadURL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "./household_power_consumption.zip"
householdFile <- "./household_power_consumption.txt"

## load dataset
if (!file.exists(householdFile)) {
  download.file(downloadURL, downloadFile, method = "curl")
  unzip(downloadFile, overwrite = T)
}
plotData <- read.table(householdFile, header=T, sep=";", na.strings="?")

## set time variable
finalData <- plotData[plotData$Date %in% c("1/2/2007","2/2/2007"),]
SetTime <-strptime(paste(finalData$Date, finalData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
finalData <- cbind(SetTime, finalData)

#Plot 4
png(filename= "plot4.png", width=480, height=480)
par(mfrow=c(2,2))
#top left
plot(finalData$SetTime, finalData$Global_active_power, type= "l", ylab="Global Active Power (kilowatts)", xlab="")
#top right
plot(finalData$SetTime, finalData$Voltage, type= "l", ylab="Voltage", xlab="datetime")
#bottom left
plot(finalData$SetTime, finalData$Sub_metering_1, type= "l", col= "black", ylab="Energy sub metering", xlab="")
lines(finalData$SetTime, finalData$Sub_metering_2, col="red")
lines(finalData$SetTime, finalData$Sub_metering_3, col="blue")
color<- c("black", "red", "blue")
labels<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3" )
legend("topright", legend=labels, col=color, lty="solid")
#bottom right
plot(finalData$SetTime, finalData$Global_reactive_power, type= "l", ylab="Global_rective_power", xlab="datetime")
dev.off()