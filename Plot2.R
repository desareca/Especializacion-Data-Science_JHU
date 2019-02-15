#load data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#2. Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
#system to make a plot answering this question.

library(dplyr)
PMyearfips <- summarise(group_by(NEI, year,fips), EmissionsSum = sum(Emissions, na.rm = TRUE))
PMyearfips24510 <- PMyearfips[PMyearfips$fips==24510,]
plot(PMyearfips24510$year, PMyearfips24510$EmissionsSum/1000, type = "b", col = "red", pch = 19, xlab = "Years", ylab = "PM2.5 accumulated (Kton)", main = "PM2.5 v/s Years, in the Baltimore City", xaxt="n")
axis(1, at = c("1999", "2002", "2005", "2008"), cex.axis=1)
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
