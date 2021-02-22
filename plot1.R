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

## PLOT 1
png(filename = "Plot1.png", width = 480, height = 480, units = "px")

hist(df_dates$Global_active_power, col="red",main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", breaks=12,ylim = c(0, 1200))

dev.off()

