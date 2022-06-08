library(dplyr)

# dowloand and unzip file, load data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "exdata_data_household_power_consumption.zip"
download.file(fileUrl, fileName)
unzip("exdata_data_household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# select only first 3 columns, filter the two dates
data1 <- data %>% 
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  select(Global_active_power)

# set classes
data1$Global_active_power <- as.numeric(data1$Global_active_power)

# Construct the plot
hist(data1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# Save plot to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px") # 480x480 is default, anyway set it to be clear
dev.off()
