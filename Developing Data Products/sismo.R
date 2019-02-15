library(lubridate)
quake<-read.csv("sismos.csv")
quake[,6]<-as.character(quake[,6])#transforma magnitud en caracter
quake$Magnitud <- as.numeric(substr(quake[,6],1,4)) # toma los primeros 4 caracteres de magnitud
                              #y lo transforma en numero
quake<- quake[!is.na(quake$Magnitud),]#selecciona los datos donde hay valor numerico de la magnitud
quake <- quake[,-2]#elimina la fecha global
names(quake)[1] <- "Date"
names(quake)[2] <- "lat"
names(quake)[3] <- "lng"
names(quake)[4] <- "Depth"
names(quake)[5] <- "Magnitude"
names(quake)[6] <- "Ref"

quake <- quake[quake[,2] < -18 &quake[,2] > -56,] #ajusta las latitudes a chile
quake <- quake[quake[,3] < -67.5 &quake[,3] > -75,] #ajusta las longitudes a chile

quake$Date <- dmy_hm(as.character(quake$Date))
write.csv(quake,file = "quake.csv")

