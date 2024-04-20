
# Load file into memory
data <- read.csv2('household_power_consumption.txt')
# Format date/time columns
data$Date_Time <- as.POSIXct(as.character(paste(data$Date, data$Time)), 
                             format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Create days for filtering data to 2 days: 2/1/2007 and 2/2/2007
day_1 <- as.Date('01/02/2007', format="%d/%m/%Y")
day_2 <- as.Date('02/02/2007', format="%d/%m/%Y")
power <- subset(data, (Date == day_1) | (Date == day_2))
rownames(power) <- 1:nrow(power)

# Convert columns to numeric values 
power$Global_active_power <- as.numeric(as.character(power$Global_active_power))
power$Global_reactive_power <- as.numeric(as.character(power$Global_reactive_power))
power$Voltage <- as.numeric(as.character(power$Voltage))
power$Global_intensity <- as.numeric(as.character(power$Global_intensity))
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))

# Plot 2 - Line Plot of Global Active Power Over Time

# Open image file to save to 
png("plot2.png", width = 480, height = 480)

# Plot graph to file 
plot(Global_active_power ~ Date_Time, data=power, type = "l", 
     xlab='', ylab='Global Active Power (kilowatts)', xaxt='n')

# To add tick marks for each day 
first_idx <- 1
start <- power$Date_Time[first_idx]
second_idx <- nrow(power) / 2   # Middle value 
middle <- power$Date_Time[second_idx]
third_idx <- nrow(power)  # Last value 
end <- power$Date_Time[third_idx]

# Add x tick marks 
axis(1, at = c(start, middle, end), labels = c("Thur", "Fri", "Sat"))

# Close image file 
dev.off()
