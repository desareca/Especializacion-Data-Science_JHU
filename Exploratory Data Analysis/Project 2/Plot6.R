plot6 <- function(){
      #load data
      
      NEI <- readRDS("summarySCC_PM25.rds")
      SCC <- readRDS("Source_Classification_Code.rds")
      
      #6. Compare emissions from motor vehicle sources in Baltimore City with
      #emissions from motor vehicle sources in Los Angeles County, 
      #California (fips == "06037"). Which city has seen greater changes 
      #over time in motor vehicle emissions?
      
      
      library(dplyr)
      library(ggplot2)
      
      PMyearfips <- summarise(group_by(NEI, year,fips,type), EmissionsSum = sum(Emissions, na.rm = TRUE))
      PMyear.Balt.LA <- PMyearfips[(PMyearfips$fips=="24510"|PMyearfips$fips=="06037")&PMyearfips$type=="ON-ROAD",]
      PMyear.Balt.LA[PMyear.Balt.LA$fips=="24510",2] <- "Baltimore, MD"
      PMyear.Balt.LA[PMyear.Balt.LA$fips=="06037",2] <- "Los Angeles, CA"

      
      q1<-qplot(year, EmissionsSum, data = PMyear.Balt.LA, col = type,  xlab = "Years", ylab = "PM2.5 accumulated (ton)", main = "PM2.5 (from motor vehicle (ON-ROAD)) v/s Years")
      q2<-q1 + scale_x_discrete(limit = PMyear.Balt.LA$year) + facet_grid(.~fips)
      q3<-q2 + geom_point(size = 4, alpha = 1) + geom_line(size = 1, alpha = 1)
      q4<-q3 + geom_text(aes(label = round(PMyear.Balt.LA$EmissionsSum, digits = 0)), col ="black", size = 4, vjust = 1.5)
      q4
      
      ggsave("plot6.png", width = 7, height = 7, dpi = "screen")
}