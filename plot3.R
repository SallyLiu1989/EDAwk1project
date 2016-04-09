# Use fread from data.table package to read faster
# Put the dataset in the working directory
library(data.table)
# Faster read and output to data frame
df3 <- fread('household_power_consumption.txt', 
             na.strings='?', select = c('Date', 'Time', 'Sub_metering_1',
                                        'Sub_metering_2', 'Sub_metering_3'),
             data.table = FALSE)

# Subsetting to get the target dates
df3 <- df3[df3$Date=='1/2/2007'|df3$Date=='2/2/2007',]

# Convert Date to date objects
df3$dt <- strptime(paste(df3$Date, df3$Time), '%e/%m/%Y %H:%M:%S')

# Construct plot in screen device
plot(df3$dt, df3$Sub_metering_1, type='n', 
     ylab ='Energy Sub Metering', xlab="") # Placeholder
lines(df3$dt, df3$Sub_metering_1, col='black') # Lines only
lines(df3$dt, df3$Sub_metering_2, col='red')
lines(df3$dt, df3$Sub_metering_3, col='blue')
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copy to PNG device
dev.copy(png, file = "plot3.png", width = 480, height = 480, units='px')
dev.off()