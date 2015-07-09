##plot4
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   stringsAsFactors=FALSE)
##contains a header and is seperated by ";"

data[,1] <- as.Date(data[,1], "%d/%m/%Y")
##need to set date column to date format, "Y" sets years to lenght of 4 instead of 2 with "y"

data <- data[as.Date("2007/01/31")<data[,1],]
##remove dates before lower limit, use summary to check
data <- data[data[,1]<as.Date("2007/02/03"),]
##remove dates after upper limit, use summary to check

data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)
##data must be numeric

data <- transform(data, fulldate = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
##These data fields must once again be combined.






png("plot4.png", width=480, height=480)

par(mfrow = c(2,2))

##part1
with(data, plot(fulldate, Global_active_power, 
                type = "l", ##line graph
                ylab = "Global Active Power", ## y-axis title
                xlab = "" ## remove x axis title
))
                
##part2  
with(data, plot(fulldate, Voltage, 
                type = "l", ##line graph
                ylab = "Voltage", ## y-axis title
                xlab = "datetime"
))             
                
##part3
with(data, plot(fulldate, Sub_metering_1, 
                type = "l", ##line graph
                ylab = "Energy sub metering", ## y-axis title
                xlab = "" ## remove x axis title
))

lines(data$fulldate,data$Sub_metering_2,col="red")
lines(data$fulldate,data$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), lwd=c(1,1), bty="n", cex=.9)
        ##remove box and shrink text

##part4
with(data, plot(fulldate, Global_reactive_power, 
                type = "l",
                xlab = "datetime"
))


dev.off()