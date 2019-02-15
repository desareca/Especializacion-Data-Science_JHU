plot3 <- function(){
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
      par(mfrow = c(1,1))
      plot(hpc$DateTime, hpc$Sub_metering_1, 
           type = "l", 
           col = "black",
           xlab = "",
           ylab = "Energy sub metering")
      points(hpc$DateTime, hpc$Sub_metering_2, 
           type = "l", 
           col = "red")
      points(hpc$DateTime, hpc$Sub_metering_3, 
           type = "l", 
           col = "blue")
      legend("topright",
           col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lwd = 1,
           inset = c(0,0),
           bty = "o",
           box.lwd = 1,
           y.intersp = 0.7,
           cex = 0.9)
      
      # Save to 480 x 480 .png file
      dev.copy(png, file = "plot3.png", width = 480, height = 480)    
      dev.off()
}