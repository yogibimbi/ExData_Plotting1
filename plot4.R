# we'd like to query a bit more comfortably, so let's get dplyr
library(dplyr)

# unzip the archive; we need to keep the archive, because GitHub has a policy against
# files > 100 MB and this way we can upload all data while .ignoring the txt file
unzip("exdata-data-household_power_consumption.zip")
# get the data; it is expected to be in the same directory as this R file
data = read.csv("household_power_consumption.txt", sep = ";", na.strings = c("?"), stringsAsFactors = FALSE)
data =  data %>%
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) %>%
  mutate(datetime = as.POSIXct(paste(Date, Time, sep = " "), format = "%Y-%m-%d %H:%M:%S"))

png(filename="plot4.png")

par(mfcol = c(2, 2))

#PLOT FROM TASK 2
plot(select(data, datetime, Global_active_power),
     type = "l",
     # labels of the x & y axis
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     # limits of the x and y axis and number of steps between
     yaxp = c(0, 6, 3)
)

# PLOT FROM TASK 3
plot(select(data, datetime, Sub_metering_1),
     type = "l",
     # labels of the x & y axis
     ylab = "Energy sub metering",
     xlab = "",
     # limits of the x and y axis and number of steps between
     yaxp = c(0, 30, 3)
)
lines(select(data, datetime, Sub_metering_2), col = "red")
lines(select(data, datetime, Sub_metering_3), col = "blue")
legend("topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  lty=c(1, 1, 1),
  col = c("black", "red", "blue"),
  # don't show the legend border
  bty = "n"
)

# PLOT BY VOLTAGE

plot(select(data, datetime, Voltage),
     type = "l",
     # labels of the x & y axis
     ylab = "Voltage",
     xlab = "datetime",
     # limits of the x and y axis and number of steps between
     yaxp = c(234, 246, 3)
)

# PLOT BY Global reactive power

plot(select(data, datetime, Global_reactive_power),
     type = "l",
     # labels of the x & y axis
     ylab = "Global_reactive_power",
     xlab = "datetime",
     # limits of the x and y axis and number of steps between
     yaxp = c(0, 0.5, 5)
)

dev.off()

