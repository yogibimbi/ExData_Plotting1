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
  mutate(datetime = as.POSIXct(paste(Date, Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")) %>%
  select(datetime, Global_active_power)

png(filename="plot2.png")
plot(data,
     type = "l",
     # labels of the x & y axis
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     # limits of the x and y axis and number of steps between
     yaxp = c(0, 6, 3)
)
dev.off()

