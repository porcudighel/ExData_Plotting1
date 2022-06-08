library(dplyr)

# dowloand and unzip file, load data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "exdata_data_household_power_consumption.zip"
download.file(fileUrl, fileName)
unzip("exdata_data_household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# select only first 3 columns, filter the two dates
data2 <- data %>% 
  select(Date:Global_active_power) %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")

# new columns for full date, set classes
data2$FullDate <- strptime(paste(data2$Date , data2$Time),"%d/%m/%Y %H:%M:%S")
data2$Global_active_power <- as.numeric(data2$Global_active_power)

# Construct the plot
with(data2, plot(FullDate,Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

# Save plot to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px") # 480x480 is default, anyway set it to be clear
dev.off()
