##plot3
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   stringsAsFactors=FALSE)
##contains a header and is seperated by ";"

data[,1] <- as.Date(data[,1], "%d/%m/%Y")
##need to set date column to date format, "Y" sets years to lenght of 4 instead of 2 with "y"

data <- data[as.Date("2007/01/31")<data[,1],]
##remove dates before lower limit, use summary to check
data <- data[data[,1]<as.Date("2007/02/03"),]
##remove dates after upper limit, use summary to check

data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
##data must be numeric

data <- transform(data, fulldate = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
##These data fields must once again be combined.

png("plot3.png", width=480, height=480)
with(data, plot(fulldate, Sub_metering_1, 
                type = "l", ##line graph
                ylab = "Energy sub metering", ## y-axis title
                xlab = "" ## remove x axis title
))
                
lines(data$fulldate,data$Sub_metering_2,col="red")
lines(data$fulldate,data$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), lwd=c(1,1))

dev.off()