# prepare data for EDA (also remove big data sets)
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp_zip <- tempfile()
download.file(dataset_url, temp_zip)
data_file <- unzip(temp_zip)
unlink(temp_zip)
data_set <- read.table(data_file, header = TRUE, sep = ';', na.strings = '?')
data <- subset(data_set, Date == '1/2/2007' | Date == '2/2/2007')
data$Date <- strptime(paste(data$Date, data$Time), '%d/%m/%Y %H:%M:%S')
file.remove(data_file)
rm(data_set)

# plot4 NB! my locale is Estonian
LC <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

png(width = 480, height = 480, file = 'plot4.png')
par(mfcol = c(2, 2))
# plot1.1
plot(data$Date, data$Global_active_power, type = 'l', 
     xlab = '', ylab = 'Global Active Power (kilowatts)')
# plot2.1
plot(data$Date, data$Sub_metering_1, type = 'l', 
     xlab = '', ylab = 'Energy sub metering')
lines(data$Date, data$Sub_metering_2, col = 'red')
lines(data$Date, data$Sub_metering_3, col = 'blue')
legend("topright", lty = 1, col = c('black', 'red', 'blue'), bty = 'n',
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
# plot1.2
plot(data$Date, data$Voltage, type = 'l', 
     xlab = 'datetime', ylab = 'Voltage')
# plot2.2
plot(data$Date, data$Global_reactive_power, type = 'l', 
     xlab = 'datetime', ylab = 'Global_reactive_power')

dev.off()
Sys.setlocale("LC_TIME", LC)