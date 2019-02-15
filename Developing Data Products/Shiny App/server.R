library(shiny)
library(leaflet)
library(lubridate)
library(plotly)
library(RColorBrewer)
library(dplyr)

quake <- read.csv("quake.csv")
options(RCHART_WIDTH = 500)

shinyServer(function(input, output) {
      output$treedat <- renderLeaflet({
            pal <- colorRampPalette(brewer.pal(8, "Dark2"))
            quakeYear() %>%
                  leaflet() %>%
                  addTiles() %>%
                  addMarkers(clusterOptions = markerClusterOptions(),
                             popup = paste(sep = "<br/>",paste("Magnitude (Richter Scale) : ",
                                           as.character(quakeYear()[,5])),paste("Depth (km) : ",
                                           as.character(quakeYear()[,4])),paste("Date : ",
                                           as.character(quakeYear()[,1]))))
      })
       quakeYear <- reactive({
             q <- quake[year(quake[,1]) == input$Fecha,]
             if(input$Select1 == 0){
                   q
             }else if(input$Select1 == 1){
                   q[with(q, order(-q$Magnitude)), ] %>%
                         head(n=10)
             }
       })
       output$plot1 <- renderPlotly({
             pal <- colorRampPalette(brewer.pal(8, "Dark2"))
             q <- quake[year(quake[,1]) == input$Fecha,]
             plot_ly(q, y = ~Magnitude, 
                     color = ~factor(q$Seasons, levels = levels(q$Seasons)[c(3,1,4,2)])
                     , type = "box", colors = pal(4)) %>%
                   layout(title = 'Earthquake Statistics in Chile per Seasons')
       })
       output$plot2 <- renderPlotly({
             pal <- colorRampPalette(brewer.pal(8, "Dark2"))
             qq <- quake[year(quake[,1]) > 2002,]
             if(input$Select2 == 0){
                   q <- qq
             }else if(input$Select2 == 1){
                   q <- qq[qq$Seasons == "Summer",]
             }else if(input$Select2 == 2){
                   q <- qq[qq$Seasons == "Autumn",]
             }else if(input$Select2 == 3){
                   q <- qq[qq$Seasons == "Winter",]
             }else if(input$Select2 == 4){
                   q <- qq[qq$Seasons == "Spring",]
             }
             plot_ly(q, y = ~Magnitude, color = ~as.factor(Year), type = "box", colors = pal(14)) %>%
                   layout(title = 'Earthquake Statistics in Chile per Year')
       })
       output$table <- renderDataTable({
              quake[year(quake[,1]) == input$Fecha,1:6]
       })
       output$plot3 <- renderPlotly({
             pal <- colorRampPalette(brewer.pal(8, "Dark2"))
             q <- quake[year(quake[,1]) > 2002,]
             q$Year <- as.factor(q$Year)
             q <- q[with(q, order(-q$Magnitude)), ] %>%
                   head(n=input$Num)

             plot_ly(q, x = ~Year,
                     y = ~Magnitude, color = ~factor(q$Seasons, levels = levels(q$Seasons)[c(3,1,4,2)]),
                     type = "bar", colors = pal(14), alpha = input$Alpha) %>%
                   layout(title = 'Earthquake Statistics in Chile per Year')
       })
       
})