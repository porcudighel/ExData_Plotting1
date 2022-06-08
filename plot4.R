library(dplyr)

# dowloand and unzip file, load data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "exdata_data_household_power_consumption.zip"
download.file(fileUrl, fileName)
unzip("exdata_data_household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# select only first 3 columns, filter the two dates
data4 <- data %>% 
  filter(Date == "1/2/2007" | Date == "2/2/2007")

# new columns for full date, set classes
data4$FullDate <- strptime(paste(data4$Date , data4$Time),"%d/%m/%Y %H:%M:%S")
data4 <- data.frame(data4[1:2], apply(data4[3:9],2,as.numeric), data4[10])

# Construct the plot
par(mfcol = c(2,2))
with(data4, plot(FullDate,Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(data4, plot(FullDate,Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
with(data4, lines(FullDate,Sub_metering_1))
with(data4, lines(FullDate,Sub_metering_2, col = "red"))
with(data4, lines(FullDate,Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black","red","blue"), legend = names(data4[7:9]), cex = .9, bty = "n")
with(data4, plot(FullDate,Voltage,type = "l", ylab = "Voltage", xlab = "datetime"))
with(data4, plot(FullDate,Global_reactive_power,type = "l", ylab = names(data4$Global_reactive_power), xlab = "datetime"))


# Save plot to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px") # 480x480 is default, anyway set it to be clear
dev.off()

# setting plotting to normal
par(mfrow = c(1,1))