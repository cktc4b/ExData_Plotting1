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

##Change Global active power, voltage, global reactive power, and sub metering columns to numeric
hpcsub$Global_active_power<-as.numeric(as.character(hpcsub$Global_active_power))
hpcsub$Sub_metering_1<-as.numeric(as.character(hpcsub$Sub_metering_1))
hpcsub$Sub_metering_2<-as.numeric(as.character(hpcsub$Sub_metering_2))
hpcsub$Sub_metering_3<-as.numeric(as.character(hpcsub$Sub_metering_3))
hpcsub$Voltage<-as.numeric(as.character(hpcsub$Voltage))
hpcsub$Global_reactive_power<-as.numeric(as.character(hpcsub$Global_reactive_power))

##Create plot 4 in a png file
png('plot4.png', width=480, height=480)
par(mfrow=c(2,2))
plot(hpcsub$Time, hpcsub$Global_active_power, type="l", ylab="Global Active Power", xlab="")
plot(hpcsub$Time, hpcsub$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(hpcsub$Time, hpcsub$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", )
        lines(hpcsub$Time, hpcsub$Sub_metering_2, type="l", col="red")
        lines(hpcsub$Time, hpcsub$Sub_metering_3, type="l", col="blue")
        legend("topright", bty="n", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(hpcsub$Time, hpcsub$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()