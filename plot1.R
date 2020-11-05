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

# plot1
png(width = 480, height = 480, file = 'plot1.png')
hist(data$Global_active_power, col = 'red', 
     xlab = 'Global Active Power (kilowatts)', 
     main = 'Global Active Power')

dev.off()