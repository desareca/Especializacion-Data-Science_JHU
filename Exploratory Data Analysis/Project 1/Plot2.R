plot2 <- function(){
      # Download (first time) and unzip the file.
      #download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
      unzip(zipfile = "household_power_consumption.zip")
      
      # Read the .txt file into a data table.
      hpc <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
      
      # Select dates to use.
      hpc <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007"), ]
      
      # Add column with date and time in POSIXct format.
      hpc$DateTime <- paste(hpc$Date, hpc$Time)
      hpc$DateTime <- as.POSIXct(hpc$DateTime, format = "%d/%m/%Y %H:%M:%S")
      
      # Plot data
      plot(hpc$DateTime, hpc$Global_active_power,
           type = "l", 
           lwd = 1.5, 
           xlab = "",
           ylab = "Global Active Power (kilowatts)")
      
      # Save to 480 x 480 .png file
      dev.copy(png, file = "plot2.png", width = 480, height = 480)    
      dev.off()
}