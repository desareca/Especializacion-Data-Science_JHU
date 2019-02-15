plot1 <- function(){
      # Download (first time) and unzip the file.
      #download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
      unzip(zipfile = "household_power_consumption.zip")
      
      # Read the .txt file into a data table.
      hpc <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
      
      # Select dates to use.
      hpc <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007"), ]
      
      # Format the date and time columns.
      hpc$Date <- strptime(hpc$Date, "%d/%m/%Y")
      hpc$Time <- strptime(hpc$Time, "%H:$M:$S")
      
      # Plot data
      hist(hpc$Global_active_power, col = "red", 
           xlab = "Global Active Power (kilowatts)",
           ylab = "Frequency",
           main = "Global Active Power")
      
      # Save to 480 x 480 .png file
      dev.copy(png, file = "plot1.png", width = 480, height = 480)    
      dev.off()
}