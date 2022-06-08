library(dplyr)

# dowloand and unzip file, load data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "exdata_data_household_power_consumption.zip"
download.file(fileUrl, fileName)
unzip("exdata_data_household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# select only first 3 columns, filter the two dates
data3 <- data %>% 
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  select(Date,Time,Sub_metering_1:Sub_metering_3)
  
# new columns for full date, set classes
data3$FullDate <- strptime(paste(data3$Date , data3$Time),"%d/%m/%Y %H:%M:%S")
data3 <- data.frame(data3[1:2], apply(data3[3:5],2,as.numeric), data3[6])

# Construct the plot
with(data3, plot(FullDate,Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
with(data3, lines(FullDate,Sub_metering_1))
with(data3, lines(FullDate,Sub_metering_2, col = "red"))
with(data3, lines(FullDate,Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black","red","blue"), legend = names(data3[3:5]), cex = .9)

# Save plot to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px") # 480x480 is default, anyway set it to be clear
dev.off()
