# we'd like to query a bit more comfortably, so let's get dplyr
library(dplyr)

# unzip the archive; we need to keep the archive, because GitHub has a policy against
# files > 100 MB and this way we can upload all data while .ignoring the txt file
unzip("exdata-data-household_power_consumption.zip")
# get the data; it is expected to be in the same directory as this R file
data = read.csv("household_power_consumption.txt", sep = ";", na.strings = c("?"), stringsAsFactors = FALSE)
data =  data %>%
        mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
        filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

png(filename="plot1.png")
hist(data[["Global_active_power"]],
     # get rid of the border around the image (although hist does already this by default, so just keep as a reminder of plot() needing this)
     bty = "n",
     # title of the whole damn thing
     main = "Global Active Power",
     # label of the x axis
     xlab = "Global Active Power (kilowatts)",
     # limits of the x and y axis and number of steps between
     xaxp = c(0, 6, 3), yaxp = c(0, 1200, 6),
     # yeah, whatever, colour of the plot, apparently
     col = "red"
)
dev.off()
