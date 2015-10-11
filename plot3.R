library(data.table)

hh_all <- fread("household_power_consumption.txt", sep = ';', header = TRUE, na.strings = '?')

# subset just 2/1/2007 and 2/2/2007
hh_subset <- hh_all[ as.Date(hh_all$Date, '%d/%m/%Y') %in% as.Date(c('01/02/2007', '02/02/2007'), '%d/%m/%Y') ]

datetime <- as.POSIXct(strptime(paste(hh_subset$Date, hh_subset$Time), '%d/%m/%Y %H:%M:%S'))

# Create a 480x480 png file
png("plot3.png", width = 480, height = 480, units = "px", bg = "white", type = "window")

plot(hh_subset$Sub_metering_1 ~ datetime, type = "n", xlab = "", ylab = "Energy sub metering")

# plot 3 sets of data points
points(hh_subset$Sub_metering_1 ~ datetime, type = "l")
points(hh_subset$Sub_metering_2 ~ datetime, type = "l", col = "red")
points(hh_subset$Sub_metering_3 ~ datetime, type = "l", col = "blue")

# add a legend
legend("topright",
       col=c("black", "red", "blue"),
       grep("Sub_metering", names(hh_subset), value = TRUE),
       lty = 1)

dev.off()