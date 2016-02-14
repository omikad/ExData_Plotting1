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

dataset <- transform(dataset, Date = as.POSIXct(Date, format="%d/%m/%Y"))

dataset = subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

par(mfrow = c(1,1))

hist(
  dataset$Global_active_power, 
  col = "red", 
  xlab = "Global Active Power (kilowatts)", 
  main = "Global Active Power")

dev.copy(png, filename = "plot1.png")
dev.off()