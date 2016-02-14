file_name <- "household_power_consumption.txt"

header <- read.csv(
  file_name, 
  nrows = 1, 
  sep =';',
  stringsAsFactors = FALSE)

dataset <- read.csv(
  file_name, 
  na.strings = "?", 
  stringsAsFactors = FALSE, 
  sep = ";",
  skip = 66300,
  nrows = 4000,
  comment.char = "")

colnames(dataset) <- colnames(header)

dataset <- transform(dataset, DateTime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
dataset <- transform(dataset, Date = as.POSIXct(Date, format="%d/%m/%Y"))

dataset = subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

par(mfrow = c(2,2))

with(dataset, plot(
  DateTime,
  Global_active_power, 
  type = "l",
  xlab = "",
  ylab = "Global Active Power"))

with(dataset, plot(
  DateTime,
  Voltage, 
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"))

with(dataset, plot(
  DateTime,
  Sub_metering_1, 
  type = "n",
  xlab = "",
  ylab = "Energy sub metering"))

with(dataset, lines(DateTime, Sub_metering_1, type = "l", col = "black"))
with(dataset, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(dataset, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))

with(dataset, plot(
  DateTime,
  Global_reactive_power, 
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"))

dev.copy(png, filename = "plot4.png")
dev.off()