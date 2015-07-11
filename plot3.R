# Create plot3.png for Exploratory Data Analysis project 1
# As this script uses mac/linux commands to filter the data set it will not run on Windows

# Check for file and get if not there fetch it
dataFileName <- 'exdata-data-household_power_consumption.zip'
fileName <- 'household_power_consumption.txt'

if(!file.exists(dataFileName)) {
    message("Downloading zip file")
    fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url=fileUrl,destfile=dataFileName,method="curl")
}

# Check for txt file
if(!file.exists(fileName)) {
    message("Extracting zip file")
    unzip(zipfile = dataFileName)
}

# Use some os commands to extract the data needed
# Get the first row then any row that has 1/2/2007 or 1/2/2007
message("Filtering data")
system("(head -1 household_power_consumption.txt ; grep '^[1|2]/2/2007' household_power_consumption.txt ) > filtered.csv")

#Read the data in
message("Reading data")
dataSet <- read.csv("filtered.csv", header=TRUE, sep=';', na.strings='?', check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

# Converting dates
dataSet$Date <- as.Date(dataSet$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(dataSet$Date), dataSet$Time)
dataSet$Datetime <- as.POSIXct(datetime)

# Create the plot
message("Ploting ......")
plot(dataSet$Sub_metering_1~dataSet$Datetime, ylab="Energy sub metering", xlab="", type="l")
lines(dataSet$Sub_metering_2~dataSet$Datetime,col='Red')
lines(dataSet$Sub_metering_3~dataSet$Datetime,col='Blue')
#Put ledgend in upper right corner
legend("topright", lty=1, lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.25)

# Copy to file
dev.copy(png, file="plot3.png", height=480, width=480)

# Close file
dev.off()
message("plot3.png written")

