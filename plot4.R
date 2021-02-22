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

## PLOT 4
png(filename = "Plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))

with(df_dates, plot(Global_active_power, type="l", xlab="", ylab="Global Active Power",xaxt = "n"))
axis(side = 1, at = c(1,1500, nrow(df_dates)), labels = c("Thu", "Fri", "Sat"))
with(df_dates, plot(Voltage, type = "l", xlab="datetime", ylab="Voltage",xaxt = "n"))
axis(side = 1, at = c(1,1500, nrow(df_dates)), labels = c("Thu", "Fri", "Sat"))
with(df_dates, plot(Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",xaxt = "n"))
axis(side = 1, at = c(1,1500, nrow(df_dates)), labels = c("Thu", "Fri", "Sat"))
lines(df_dates$Sub_metering_2,type="l", col= "red")
lines(df_dates$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(df_dates, plot(Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
axis(side = 1, at = c(1,1500, nrow(df_dates)), labels = c("Thu", "Fri", "Sat"))

dev.off()
