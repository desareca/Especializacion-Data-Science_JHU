plot5 <- function(){
      #load data
      
      NEI <- readRDS("summarySCC_PM25.rds")
      SCC <- readRDS("Source_Classification_Code.rds")
      
      #5. How have emissions from motor vehicle sources changed from 1999-2008
      #in Baltimore City? 

      library(dplyr)
      library(ggplot2)
      
      PMyearfips <- summarise(group_by(NEI, year,fips,type), EmissionsSum = sum(Emissions, na.rm = TRUE))
      PMyearfips24510 <- PMyearfips[PMyearfips$fips==24510&PMyearfips$type=="ON-ROAD",]
      
      q1<-qplot(year, EmissionsSum, data = PMyearfips24510, col = type,  xlab = "Years", ylab = "PM2.5 accumulated (ton)", main = "PM2.5 (from motor vehicle (ON-ROAD)) v/s Years, in Baltimore City")
      q2<-q1 + scale_x_discrete(limit = PMyearfips24510$year)
      q3<-q2 + geom_point(size = 4, alpha = 1) + geom_line(size = 1, alpha = 1)
      q4<-q3 + geom_text(aes(label = round(PMyearfips24510$EmissionsSum, digits = 0)), col ="black", size = 4, vjust = 1.5)
      q4
      
      ggsave("plot5.png", width = 7, height = 7, dpi = "screen")
}