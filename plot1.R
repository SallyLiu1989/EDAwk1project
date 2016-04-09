# Use fread from data.table package to read faster
# Put the dataset in the working directory
library(data.table)
# Faster read and output to data frame
df1 <- fread('household_power_consumption.txt', 
            na.strings='?', select = c('Date', 'Global_active_power'),
            data.table = FALSE)

# Subsetting to get the target dates
df1 <- df1[df1$Date=='1/2/2007'|df1$Date=='2/2/2007',]

# Construct plot in screen device
hist(df1$Global_active_power, col = 'red', 
     xlab = 'Global Active Power (kilowatt)', main = 'Global Active Power')

# Copy to PNG device
dev.copy(png, file = "plot1.png", width = 480, height = 480, units='px')
dev.off()