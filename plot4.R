# Download File

if(!file.exists("./CourseProject")){dir.create("./CourseProject")}
## assume that if the archive exists it has been unzipped.
fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./CourseProject/archive.zip")){
    download.file(fileUrl,destfile = "./CourseProject/archive.zip")
# Unzip
    unzip("./CourseProject/archive.zip") }

library(dplyr)
# List the files to verify the name of unzipped file
list.files()
hpc2 <- read.table("household_power_consumption.txt",header=TRUE,sep=";",nrows=69516,colClasses=
           c("character","character","character","character","character","character","character"
                       ,"character","character"),na.strings = "?." )
date2 <- as.Date(hpc2$Date,"%d/%m/%Y")
hpc2 <- mutate(hpc2,Date = date2)
hpc3 <- hpc2[hpc2$Date > as.Date("2007-01-31"),]
x <- paste(as.character(hpc3$Date),hpc3$Time)
dtx <- strptime(x, "%Y-%m-%d %H:%M:%S")
hpc3$DateTime <- dtx



## NOW TO PLOT the 4 plots in one window.
png(filename="plot4.png")
par(mfrow=c(2,2))
par(mar=c(6,4,3,2))
## PLOT 4.1
plot(hpc3$DateTime,hpc3$Global_active_power,type="l",xlab="",
     ylab="Global active power (kilowatts)",main="PLOT 4.1")
## PLOT 4.2
plot(hpc3$DateTime,hpc3$Voltage,type="l",xlab="datetime",
     ylab="Voltage ",main="PLOT 4.2")

## PLOT 4.3

plot(hpc3$DateTime,as.numeric(hpc3$Sub_metering_1),type="l",
     xlab="",ylab="Energy sub metering ",main="PLOT 4.3",col="Brown")
lines(hpc3$DateTime,as.numeric(hpc3$Sub_metering_2),col="Red")
lines(hpc3$DateTime,as.numeric(hpc3$Sub_metering_3),col="Blue")
legend("topright",legend= c("Sub_metering_1","Sub_metering_2",
                            "Sub_metering_3"),
       lty=c(1,1),col=c("Brown","Red","Blue"),cex=0.7)
##mtext("2007-02-01 to 2007-02-02",side=1,line=4,col="Yellow")

## PLOT 4.4
plot(hpc3$DateTime,hpc3$Global_reactive_power,type="l",xlab="datetime",
     ylab="Global re-active power",main="PLOT 4.4")
##dev.copy(png,file="PLOT4.png")
dev.off()