library(data.table)

# URL of the dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Destination file path
destfile <- "household_power_consumption.zip"

# Download the file
download.file(url, destfile)

# Unzip the downloaded file
unzip(destfile)


file_path <- "household_power_consumption.txt"

# Read only the relevant dates
data <- fread(file_path, na.strings = "?", 
              colClasses = c("character", "character", rep("numeric", 7)))

data <- data[grep("^(1|2)/2/2007", Date), ]
# Convert Date and Time into a single DateTime column

data[, DateTime := as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))]

# Plot 3: Sub-Metering

png("plot3.png", width = 480, height = 480)
plot(data$DateTime, data$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
dev.off()

