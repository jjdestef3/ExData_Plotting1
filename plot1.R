# Create plot1.png for Exploratory Data Analysis project 1
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

# Create the hist
message("Ploting ......")
hist(dataSet$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")

# Copy to file
dev.copy(png, file="plot1.png", height=480, width=480)

# Close file
dev.off()
message("plot1.png written")
