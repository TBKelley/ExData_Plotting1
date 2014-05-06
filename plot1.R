## plot1.R
##
## Create ./figure/plot1.png

dataUNC <- "./household_power_consumption.txt"
plotUNC <- fileUNC <- paste("./figure", "plot1.png", sep="/")
    
datStart <- as.Date("2007-02-01")
datEnd <- as.Date("2007-02-02")

## Columns: Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
cat("Read ", "'", dataUNC, "'", "\n", sep="")
df <- read.csv(dataUNC, sep=";")  #  dim=2075259*9, Columns are factors

df <- subset(df, as.Date(df$Date, format("%d/%m/%Y")) >= datStart & as.Date(df$Date, format("%d/%m/%Y")) <= datEnd) # dim=2880*9

df$Date = as.Date(df$Date, format("%d/%m/%Y"))
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_intensity <- as.numeric(as.character(df$Global_intensity))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))

title <- "Global Active Power"
xlab <- "Global Active Power (kilowatts)"
hist(df$Global_active_power, main=title, xlab=xlab, col="Red", cex.axis=0.8, cex.lab=0.8, cex.main=0.8)

cat("Write ", "'", plotUNC, "'", "\n", sep="")
dev.copy(png, file=plotUNC)
dev.off()
