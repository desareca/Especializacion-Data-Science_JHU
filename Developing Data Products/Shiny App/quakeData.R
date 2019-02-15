library(lubridate)
# The data was extracted from the page
#http://benjad.github.io/2015/08/21/base-de-datos-sismos-chile/,
#that in turn extracted the official information from the page http://sismologia.cl/

url <- "http://benjad.github.io/assets/sismos.csv"
download.file(url = url, destfile = "sismos.csv")


quake<-read.csv("sismos.csv")
quake[,6]<-as.character(quake[,6])
quake[,6] <- as.numeric(substr(quake[,6],1,4))
                              
quake<- quake[!is.na(quake[,6]),]
quake <- quake[,-2]
names(quake)[1] <- "Date"
names(quake)[2] <- "lat"
names(quake)[3] <- "lng"
names(quake)[4] <- "Depth"
names(quake)[5] <- "Magnitude"
names(quake)[6] <- "Ref"

quake <- quake[quake[,2] < -18 &quake[,2] > -56,] 
quake <- quake[quake[,3] < -67.5 &quake[,3] > -75,] 
quake$Date <- dmy_hm(as.character(quake[,1]))

quake$Seasons <- NA
quake$Seasons[(month(quake[,1]) >= 1)&(month(quake[,1]) <= 2)] <- "Summer"
quake$Seasons[(month(quake[,1]) >= 3)&(month(quake[,1]) <= 5)] <- "Autumn"
quake$Seasons[(month(quake[,1]) >= 6)&(month(quake[,1]) <= 8)] <- "Winter"
quake$Seasons[(month(quake[,1]) >= 9)&(month(quake[,1]) <= 11)] <- "Spring"
quake$Seasons[(month(quake[,1]) == 12)] <- "Summer"
quake$Seasons <- as.factor(quake$Seasons)

quake$Year <- NA
for (i in 1:14) {
      quake$Year[year(quake[,1]) == 2001+i] <- 2001+i
}
quake$Year <- as.factor(quake$Year)

write.csv(quake,file = "quake.csv", row.names = FALSE)
