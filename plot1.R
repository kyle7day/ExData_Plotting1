##plot1
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
  ## histograms require a numeric input

png("plot1.png", width=480, height=480)
hist(data$Global_active_power, ##data source
     col = "red", ## color is red
     main = paste("Global Active Power"), ## Title of chart
     xlab = "Global Active Power(kilowatts)", ## x-axis title
)
dev.off()

