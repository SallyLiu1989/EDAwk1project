# Use fread from data.table package to read faster
# Put the dataset in the working directory
library(data.table)
# Faster read and output to data frame
df2 <- fread('household_power_consumption.txt', 
             na.strings='?', select = c('Date', 'Time', 'Global_active_power'),
             data.table = FALSE)

# Subsetting to get the target dates
df2 <- df2[df2$Date=='1/2/2007'|df2$Date=='2/2/2007',]

# Convert Date to date objects
df2$dt <- strptime(paste(df2$Date, df2$Time), '%e/%m/%Y %H:%M:%S')

# Construct plot in screen device
plot(df2$dt, df2$Global_active_power, type='n', 
     ylab ='Global Active Power (kilowatt)', xlab="") # Placeholder
lines(df2$dt, df2$Global_active_power) # Lines only

# Copy to PNG device
dev.copy(png, file = "plot2.png", width = 480, height = 480, units='px')
dev.off()