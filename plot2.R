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

par(mfrow = c(1,1))

plot(
  dataset$DateTime, 
  dataset$Global_active_power, 
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)")

dev.copy(png, filename = "plot2.png")
dev.off()


