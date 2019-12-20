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
png('plot2.png')
plot(df2$datetime, df2$Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     main = "")
dev.off()
