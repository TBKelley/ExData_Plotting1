## plot2.R
##
## Create ./plot2.png
## Line plot of Global_active_power vs Date+Time
library("sqldf")
require("tcltk")

require("sqldf")

dataUNC <- "../household_power_consumption.txt"
plotUNC <- fileUNC <- paste(".", "plot2.png", sep="/")

sql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## Columns: Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
cat("Read ", "'", dataUNC, "'", "\n", sep="")
df <- read.csv.sql(dataUNC, sql, sep=";")  # dim=2880*9
df$timestamp <- as.POSIXct(strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S"))

xlab <- ""
ylab <- "Global Active Power (kilowatts)"
plot(df$timestamp, df$Global_active_power, type="l", xaxt="n", ylab=ylab, xlab=xlab, cex.axis=0.7, cex.lab=0.8)
axis.POSIXct(1, df$timestamp, format="%a", cex.axis=0.8)

cat("Write ", "'", plotUNC, "'", "\n", sep="")
dev.copy(png, file=plotUNC)
dev.off()


