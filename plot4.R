
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

# Plot 4 - Plot with 4 Sub-Plots

# Open image file for plot 
png("plot4.png", width = 480, height = 480)

# Set up plotting window with 2x2 sub-plots 
par(mfcol = c(2, 2))

# Indexes for tick marks  
first_idx <- 1
start <- power$Date_Time[first_idx]
second_idx <- nrow(power) / 2   # Middle value 
middle <- power$Date_Time[second_idx]
third_idx <- nrow(power)  # Last value 
end <- power$Date_Time[third_idx]

# Add Plot 2 - Line Plot of Global Active Power Over Time
plot(Global_active_power ~ Date_Time, data=power, type = "l", 
     xlab='', ylab='Global Active Power', xaxt='n')
# Add x tick marks
axis(1, at = c(start, middle, end), labels = c("Thur", "Fri", "Sat"))

# Add Plot 3 - Line Plots of Energy Sub Metering
plot(Sub_metering_1 ~ Date_Time, data=power, type = "l", 
     xlab='', ylab='Energy sub metering', xaxt='n')
lines(Sub_metering_2 ~ Date_Time, data=power, col="red")
lines(Sub_metering_3 ~ Date_Time, data=power, col="blue")
legend(x='topright',
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"),
       lty = c(1, 1, 1), cex = 0.75,
       bty = "n")
# Add x tick marks 
axis(1, at = c(start, middle, end), labels = c("Thur", "Fri", "Sat"))

# Add new plot - Line Plot of Voltage Over Time
plot(Voltage ~ Date_Time, data=power, type = "l", 
     xlab='datetime', ylab='Voltage', xaxt='n')
# Add x tick marks
axis(1, at = c(start, middle, end), labels = c("Thur", "Fri", "Sat"))

# Another new plot - Line Plot of Global Reactive Power Over Time
plot(Global_reactive_power ~ Date_Time, data=power, type = "l", 
     xlab='datetime', xaxt='n')
# Add x tick marks
axis(1, at = c(start, middle, end), labels = c("Thur", "Fri", "Sat"))

# Close device 
dev.off()