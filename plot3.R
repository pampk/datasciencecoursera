library(dplyr)
library(lubridate)

## READ IN FILE
df <- read.table("household_power_consumption.txt", sep = ";", na="?", header=TRUE)
head(df)
sapply(df, class)
summary(df)

## CONVERT DATE COLUMN TO ACTUAL DATE FORMAT
df$Date <- dmy(df$Date)
head(df)
sapply(df, class)

## CONVERT TIME COLUMN TO TIME FORMAT
df$Time <- hms(df$Time)

## CONVERT CHARACTER COLUMNS TO NUMERIC
df[3:8] <- sapply(df[3:8], as.numeric)

## CHECK FOR MISSING VALUES
sum(is.na(df_dates))

## FILTER ON 2007-02-01 AND 2007-02-02
df_dates <- df %>% 
  filter(Date=="2007-02-01" | Date=="2007-02-02")

df_dates <- df %>% 
  filter(Date=="2007-01-02" | Date=="2007-02-02")

## PLOT 3
png(filename = "Plot3.png", width = 480, height = 480, units = "px")

plot(df_dates$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(df_dates$Sub_metering_1, col = "black")
lines(df_dates$Sub_metering_2, col = "red")
lines(df_dates$Sub_metering_1, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
axis(side = 1, at = c(1,1500, nrow(df_dates)), labels = c("Thu", "Fri", "Sat"))

dev.off()

