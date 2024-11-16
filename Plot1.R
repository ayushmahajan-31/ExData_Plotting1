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


# Plot 1: Histogram of Global Active Power
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()

