
# Load file into memory
data <- read.csv2('household_power_consumption.txt')
# Format date  column
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Create days for filtering data to 2 days: 2/1/2007 and 2/2/2007
day_1 <- as.Date('01/02/2007', format="%d/%m/%Y")
day_2 <- as.Date('02/02/2007', format="%d/%m/%Y")
power <- subset(data, (Date == day_1) | (Date == day_2))
rownames(power) <- 1:nrow(power)

# Convert columns to numeric values 
power$Global_active_power = as.numeric(as.character(power$Global_active_power))
power$Global_reactive_power = as.numeric(as.character(power$Global_reactive_power))
power$Voltage = as.numeric(as.character(power$Voltage))
power$Global_intensity = as.numeric(as.character(power$Global_intensity))
power$Sub_metering_1 = as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 = as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 = as.numeric(as.character(power$Sub_metering_3))

# Plot 1 - Histogram Global Active Power

# Open image file for plot
png("plot1.png", width = 480, height = 480)

# Add histogram to file 
hist(power$Global_active_power, col='red', 
     xlab='Global Active Power (kilowatts)', 
     main='Global Active Power')

# Close image file 
dev.off()