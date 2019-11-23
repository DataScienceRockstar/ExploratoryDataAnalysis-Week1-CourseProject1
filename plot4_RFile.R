
#reading data 

workingdirectory  <- getwd()


powerConsumption <- read.table("household_power_consumption.txt", 
                               header=TRUE, sep=";", na.strings = "?", 
                               colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))





## Format date Column to Type Date
powerConsumption$Date <- as.Date(powerConsumption$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
powerConsumption <- subset(powerConsumption,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
powerConsumption <- powerConsumption[complete.cases(powerConsumption),]

## Combine Date and Time column
dateTime <- paste(powerConsumption$Date, powerConsumption$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
powerConsumption <- powerConsumption[ ,!(names(powerConsumption) %in% c("Date","Time"))]

## Add DateTime column
powerConsumption <- cbind(dateTime, powerConsumption)

## Format dateTime Column
powerConsumption$dateTime <- as.POSIXct(dateTime)


## Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(powerConsumption, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Save file and close device
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()