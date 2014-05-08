## plot3.R
##
## Create ./plot3.png
## Line plot of Sub_metering_1;Sub_metering_2;Sub_metering_3 vs Date+Time
library("sqldf")
require("tcltk")

require("sqldf")

dataUNC <- "../household_power_consumption.txt"
plotUNC <- fileUNC <- paste(".", "plot3.png", sep="/")

sql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## Columns: Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
cat("Read ", "'", dataUNC, "'", "\n", sep="")
df <- read.csv.sql(dataUNC, sql, sep=";")  # dim=2880*9
df$timestamp <- as.POSIXct(strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S"))

xlab <- ""
ylab <- "Energy sub metering"
par(font.lab=2) # Bold labels
plot(df$timestamp, df$Sub_metering_1, type="l", xaxt="n", ylab=ylab, xlab=xlab, cex.axis=0.7, cex.lab=0.8)
axis.POSIXct(1, df$timestamp, format="%a", cex.axis=0.8)
lines(df$timestamp, df$Sub_metering_2, col="red") 
lines(df$timestamp, df$Sub_metering_3, col="blue")
legend("topright", lty=c(1, 1, 1), cex=0.7, text.font=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

cat("Write ", "'", plotUNC, "'", "\n", sep="")
dev.copy(png, file=plotUNC)
dev.off()


