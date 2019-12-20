library(tidyverse)

# download file
path <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
newFile <- "download.zip"
    
if (!file.exists(newFile)) {
    download.file(path, newFile)
    unzip(newFile) # unzip
}

# load data
df <- read.table("household_power_consumption.txt", sep = ';', header=TRUE)

# first convert to proper date
df$Date <- lubridate::dmy(df$Date)

# filter
df2 <- df %>% 
    filter(Date %in% c(lubridate::ymd(20070201), lubridate::ymd(20070202)))

# code for plot1
png("plot1.png")
hist(as.numeric(df2$Global_active_power), col = 'red', 
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power')
dev.off()
