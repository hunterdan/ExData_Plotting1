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



## PLOT 3
png(filename="plot3.png")
par(mar=c(6,4,4,2))
plot(hpc3$DateTime,as.numeric(hpc3$Sub_metering_1),type="l",
     xlab="",ylab="Energy sub metering ",col="Brown")
lines(hpc3$DateTime,as.numeric(hpc3$Sub_metering_2),col="Red")
lines(hpc3$DateTime,as.numeric(hpc3$Sub_metering_3),col="Blue")
legend("topright",legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_ 3"),
       lty=c(1,1),col=c("Brown","Red","Blue"))
mtext("2007-02-01 to 2007-02-02",side=1,line=4,col="Yellow")
dev.off()
