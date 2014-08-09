##Identify file location and download
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "HPC.zip")

##Unzip the file
unzip("HPC.zip")

##Load the data from the unzipped file
hpc<-read.table("household_power_consumption.txt", header=TRUE, sep=";")

##Convert the Date column to the date class, and reformat the Time column to include the complete date and time
hpc$Time<-strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")
hpc$Date<-as.Date(hpc$Date, "%d/%m/%Y")

##Subset to include only data from 2/1/2007, and 2/2/2007
hpcsub<-subset(hpc, Date=='2007-02-01' |
        Date=='2007-02-02')

##Change Global active power column to numeric
hpcsub$Global_active_power<-as.numeric(as.character(hpcsub$Global_active_power))

##Create plot 2 in a png file
png('plot2.png', width=480, height=480)
plot(hpcsub$Time, hpcsub$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()