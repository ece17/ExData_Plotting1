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

#Plot 1
png(filename= "plot1.png", width=480, height=480)
hist(finalData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

