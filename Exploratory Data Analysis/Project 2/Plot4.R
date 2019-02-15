plot4 <- function(){
      #load data
      
      NEI <- readRDS("summarySCC_PM25.rds")
      SCC <- readRDS("Source_Classification_Code.rds")
      
      #4. Across the United States, how have emissions from coal 
      #combustion-related sources changed from 1999-2008?

      library(dplyr)
      library(ggplot2)
      
      SCCcoal <- SCC[grepl("[Cc]oal",SCC$Short.Name),]
      NEIcoal <- merge(NEI,SCCcoal, by = "SCC")
      PMyear <- summarise(group_by(NEIcoal, year), EmissionsSum = sum(Emissions, na.rm = TRUE))

      q1<-qplot(year, EmissionsSum/1000, data = PMyear, xlab = "Years", ylab = "PM2.5 accumulated (Kton)", main = "PM2.5 (from coal combustion-related sources) v/s Years")
      q2<-q1 + scale_x_discrete(limit = PMyear$year)
      q3<-q2 + geom_point(color = "red",size = 4, alpha = 1) + geom_line(color = "red",size = 1, alpha = 1)
      q4<-q3 + geom_text(aes(label = round(PMyear$EmissionsSum / 1000, digits = 0)), size = 4, vjust = 1.5)
      q4

      ggsave("plot4.png", width = 7, height = 7, dpi = "screen")
}
