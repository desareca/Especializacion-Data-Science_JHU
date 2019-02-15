#load data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#1. Have total emissions from PM2.5 decreased in the United States from 1999 to
#2008? Using the base plotting system, make a plot showing the total PM2.5
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)
PMyear <- summarise(group_by(NEI, year), EmissionsSum = sum(Emissions, na.rm = TRUE))
plot(PMyear$year, PMyear$EmissionsSum/1000, type = "b", col = "red", pch = 19, xlab = "Years", ylab = "PM2.5 accumulated (Kton)", main = "PM2.5 v/s Years", xaxt="n")
axis(1, at = c("1999", "2002", "2005", "2008"), cex.axis=1)
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
