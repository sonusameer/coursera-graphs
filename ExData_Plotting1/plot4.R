library(tidyverse)

# download file
path <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
newFile <- "download.zip"

if (!file.exists(newFile)) {
    download.file(path, newFile)
    unzip(newFile) # unzip
}

# load data
df <- read.table("household_power_consumption.txt", sep=';', header=TRUE)

# first convert to proper date
df$Date <- lubridate::dmy(df$Date)

# filter
df2 <- df %>% 
    filter(Date %in% c(lubridate::ymd(20070201), lubridate::ymd(20070202)))

# combine date & time
datetime <- paste(df2$Date, df2$Time)
df2$datetime <- lubridate::ymd_hms(datetime)

# code for plot1
png("plot4.png")
par(mfrow=c(2,2))

plot(df2$datetime, df2$Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     main = "")

plot(df2$datetime, df2$Voltage, type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     main = "")

plot(range(df2$datetime), range(df2$Sub_metering_1), type = 'n',
     xlab = "", ylab = "Energy sub metering")
lines(df2$datetime, df2$Sub_metering_1, type = "l", col = "black")
lines(df2$datetime, df2$Sub_metering_2, type = "l", col = "red")
lines(df2$datetime, df2$Sub_metering_3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c('black', 'red', 'blue'), lty = 1)

plot(df2$datetime, df2$Global_reactive_power, type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     main = "")
dev.off()
