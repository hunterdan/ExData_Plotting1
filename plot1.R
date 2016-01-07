## If plotI.R (I in 1:4) is run first then there is no need to download the zip file 
## containing household_power_consumption.txt for the remaining plot*.R files
## a subdirectory is created with the zip file in it, and the file is
## unzipped to the working directory

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


par(mfrow = c(1,1))
## PLOT 1
png(filename="plot1.png")
hist(as.numeric(hpc3$Global_active_power),col="Red",
     xlab="Global Active Power (kilowatts)" ,main="Global Active Power  ")

dev.off()
