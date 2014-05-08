## plot4.R
##
## Create ./plot4.png
## Combine 4 plots
## 1. Line plot of Date+Time vs Global_active_power 
## 2. Line plot of Date+Time vs Voltage 
## 3. Line plot of Date+Time vs Sub_metering_1;Sub_metering_2;Sub_metering_3 
## 4. Line plot of Date+Time vs Global_reactive_power 
library("sqldf")
require("tcltk")

require("sqldf")

dataUNC <- "../household_power_consumption.txt"
plotUNC <- fileUNC <- paste(".", "plot4.png", sep="/")

sql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## Columns: Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
cat("Read ", "'", dataUNC, "'", "\n", sep="")
df <- read.csv.sql(dataUNC, sql, sep=";")  # dim=2880*9
df$datetime <- as.POSIXct(strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S"))

par(font.lab=1, mfrow=c(2,2), mar=c(5.1, 4.0, 1.0, 1.0)) # Bold labels

# 1. Line plot of Date+Time vs Global_active_power
xlab <- ""
ylab <- "Global Active Power"
plot(df$datetime, df$Global_active_power, type="l", xaxt="n", ylab=ylab, xlab=xlab, cex.axis=0.7, cex.lab=0.8)
axis.POSIXct(1, df$datetime, format="%a", cex.axis=0.8)
lines(df$datetime, df$Global_active_power) 

# 2. Line plot of Date+Time vs Voltage
xlab <- "datetime"
ylab <- "Voltage"
plot(df$datetime, df$Voltage, type="l", xaxt="n", ylab=ylab, xlab=xlab, cex.axis=0.7, cex.lab=0.8)
axis.POSIXct(1, df$datetime, format="%a", cex.axis=0.8)
lines(df$datetime, df$Voltage) 

# 3. Line plot of Date+Time vs Sub_metering_1;Sub_metering_2;Sub_metering_3
xlab <- ""
ylab <- "Energy sub metering"
plot(df$datetime, df$Sub_metering_1, type="l", xaxt="n", ylab=ylab, xlab=xlab, cex.axis=0.7, cex.lab=0.8)
axis.POSIXct(1, df$datetime, format="%a", cex.axis=0.8)
lines(df$datetime, df$Sub_metering_2, col="red") 
lines(df$datetime, df$Sub_metering_3, col="blue")
legend("topright", lty=c(1, 1, 1), cex=0.8, bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 4. Line plot of Date+Time vs Global_reactive_power
xlab <- "datetime"
ylab <- "Global_reactive_power"
plot(df$datetime, df$Global_reactive_power, type="l", xaxt="n", ylab=ylab, xlab=xlab, cex.axis=0.7, cex.lab=0.8)
axis.POSIXct(1, df$datetime, format="%a", cex.axis=0.8)
lines(df$datetime, df$Global_reactive_power) 


cat("Write ", "'", plotUNC, "'", "\n", sep="")
dev.copy(png, file=plotUNC)
dev.off()


