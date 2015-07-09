##plot2
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   stringsAsFactors=FALSE)
##contains a header and is seperated by ";"

data[,1] <- as.Date(data[,1], "%d/%m/%Y")
##need to set date column to date format, "Y" sets years to lenght of 4 instead of 2 with "y"

data <- data[as.Date("2007/01/31")<data[,1],]
##remove dates before lower limit, use summary to check
data <- data[data[,1]<as.Date("2007/02/03"),]
##remove dates after upper limit, use summary to check

data[,3] <- as.numeric(data[,3])
##data must be numeric

data <- transform(data, fulldate = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
##After much trial, error and searching the way to get the x axis to show as Thu:Sat
##is to combine the date and time columns, then list that column when calling plot.


png("plot2.png", width=480, height=480)
with(data, plot(fulldate, Global_active_power, 
                type = "l", ##line graph
                ylab = "Global Active Power(kilowatts)", ## y-axis title
                xlab = "" ## remove x axis title
    ))
dev.off()