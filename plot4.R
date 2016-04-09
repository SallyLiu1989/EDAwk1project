# Use fread from data.table package to read faster
# Put the dataset in the working directory
library(data.table)
# Faster read and output to data frame
df4 <- fread('household_power_consumption.txt', 
             na.strings='?', 
             data.table = FALSE)

# Subsetting to get the target dates
df4 <- df4[df4$Date=='1/2/2007'|df4$Date=='2/2/2007',]

# Convert Date to date objects
df4$dt <- strptime(paste(df4$Date, df4$Time), '%e/%m/%Y %H:%M:%S')

# Devide campus into 2 by 2 grids
par(mfrow=c(2,2), mar=c(2,4,1,1))

# Construct the 1st plot
plot(df4$dt, df4$Global_active_power, type='n', 
     ylab ='Global Active Power', xlab="") # Placeholder
lines(df4$dt, df4$Global_active_power) # Lines only

# Construct the 2nd plot
plot(df4$dt, df4$Voltage, type='n', 
     ylab ='Voltage', xlab="datetime") # Placeholder
lines(df4$dt, df4$Voltage) # Lines only

# Construct the 3rd plot
plot(df4$dt, df4$Sub_metering_1, type='n', 
     ylab ='Energy Sub Metering', xlab="") # Placeholder
lines(df4$dt, df4$Sub_metering_1, col='black') # Lines only
lines(df4$dt, df4$Sub_metering_2, col='red')
lines(df4$dt, df4$Sub_metering_3, col='blue')
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

# Construct the 4th plot
plot(df4$dt, df4$Global_reactive_power, type='n', 
     ylab ='Global_reactive_power', xlab="datetime") # Placeholder
lines(df4$dt, df4$Global_reactive_power) # Lines only


# Copy to PNG device
dev.copy(png, file = "plot4.png", width = 480, height = 480, units='px')
dev.off()