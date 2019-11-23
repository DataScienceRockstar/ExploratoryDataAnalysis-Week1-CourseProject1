
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


## Create Plot 2
plot(powerConsumption$Global_active_power~powerConsumption$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")


## Save file and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()