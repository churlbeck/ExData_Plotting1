library(data.table)

hh_all <- fread("household_power_consumption.txt", sep = ';', header = TRUE, na.strings = '?')

# subset just 2/1/2007 and 2/2/2007
hh_subset <- hh_all[ as.Date(hh_all$Date, '%d/%m/%Y') %in% as.Date(c('01/02/2007', '02/02/2007'), '%d/%m/%Y') ]

datetime <- as.POSIXct(strptime(paste(hh_subset$Date, hh_subset$Time), '%d/%m/%Y %H:%M:%S'))


# Create a 480x480 png file
png("plot4.png", width = 480, height = 480, units = "px", bg = "white", type = "window")

# Split it into 4 quadrants
par(mfrow = c(2,2))
  
#quadrant #1
plot(hh_subset$Global_active_power ~ datetime, type = "l", ylab = "Global Active Power", xlab = "")

#quadrant #2
plot(hh_subset$Voltage ~ datetime, type = "l", ylab = "Voltage")

#quadrant #3
plot(hh_subset$Sub_metering_1 ~ datetime, type = "n", xlab = "", ylab = "Energy sub metering")
points(hh_subset$Sub_metering_1 ~ datetime, type = "l")
points(hh_subset$Sub_metering_2 ~ datetime, type = "l", col = "red")
points(hh_subset$Sub_metering_3 ~ datetime, type = "l", col = "blue")
legend("topright",
       col=c("black", "red", "blue"),
       grep("Sub_metering", names(hh_subset), value = TRUE),
       lty = 1,
       bty ="n")

#quadrant #4
plot(hh_subset$Global_reactive_power ~ datetime, type = "l", ylab = "Global_reactive_power")

dev.off()