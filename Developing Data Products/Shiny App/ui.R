library(shiny)
library(leaflet)
library(lubridate)
library(plotly)
library(RColorBrewer)
library(dplyr)

shinyUI(fluidPage(
      titlePanel("Earthquake Statistics in Chile from 2003 to 2015"),
      sidebarLayout(
            sidebarPanel(
                  numericInput("Fecha", "Year of the earthquake", 
                               value = 2010, min = 2003, max = 2015, step = 1),
                  h3(""),
                  plotlyOutput("plot1"),
                  h3(""),
                  submitButton("Submit")
            ),
           mainPanel(
                 tabsetPanel(
                       tabPanel("Map",
                                h3("Map of earthquakes in Chile"),
                                leafletOutput("treedat"),
                                selectInput("Select1", "Select to data:",
                                            c("All" = 0, "Topten" = 1))#,
                                #submitButton("Submit")
                                ),
                       tabPanel("Boxplot per Year",
                                h3(""),
                                plotlyOutput("plot2"),
                                selectInput("Select2", "Select season:",
                                            c("All" = 0, "Summer" = 1,
                                              "Autumn" = 2,"Winter" = 3,
                                              "Spring" = 4))#,
                                #submitButton("Submit")
                       ),
                       tabPanel("Plot per Year",
                                h3(""),
                                plotlyOutput("plot3"),
                                numericInput("Num", "Select the top number:", 
                                             value = 300, min = 25,
                                             max = 1000, step = 25),
                                numericInput("Alpha", "Transparency :", 
                                             value = 0.2, min = 0,
                                             max = 1, step = 0.01)#,
                                #submitButton("Submit")
                       ),
                       tabPanel("Data per year",
                                dataTableOutput("table")
                                ),
                       tabPanel("Documentation",
                                h2("Introduction"),
                                h5("In seismology.cl you can review all
                                    the earthquakes that have occurred in Chile
                                    since 2003, although the information is very
                                    complete, it is not in an adequate format to 
                                    have a global view of them."),
                                h5("These data were collected and entered into
                                    a database with earthquakes between 
                                    2003 to 2005 on the site: "),
                                   
                                a("http://benjad.github.io/2015/08/21/base-de-datos-sismos-chile/"),
                                   
                                h5("For this application, the data was extracted
                                    and processed from the previous site. The 
                                    data was processed with the code 
                                    QuakeData.R, which generates the data 
                                    ordered quake.csv, which are used for
                                    the development of this Shiny application."),
                                h5("The codes of the application are in
                                    the repository:"),
                                a("https://github.com/desareca/Developing-Data-Products.git"),
                                h2("How to use"),
                                
                                h5("This application consists of a side panel and five central tabs."),
                                
                                h3("Side panel:"),
                                h5("In the side panel you can select data for a specific year
                                    (between 2003 and 2015) to work on some of the tabs.
                                    By default, the selected year is 2010.In addition, 
                                    a box plot with information associated with the 
                                    earthquakes of the selected year is shown, according
                                    to the season in which it occurred. Each time you 
                                    perform an action in a tab you must press 'submit' to confirm."),
                                
                                h3("Tabs:"),
                                h4("Map:"),
                                h5("This tab shows the earthquakes that occurred during
                                   the year selected in the side panel. At the bottom
                                   of the tab there is a selector with two options, 
                                   'All' and 'Topten'. When selecting 'All', 
                                   all the earthquakes that occurred during that year
                                   are shown. Selecting 'Topten' shows the 10 major
                                   earthquakes during that year. By default, 'All' is displayed."),
                                
                                h4("Boxplot per year:"),
                                h5("This tab shows a boxplot with information associated with all 
                                   the earthquakes that occurred during 2003 to 2015 in Chile. 
                                   At the bottom is a selector with 5 options 'All', 'Summer', 
                                   'Autumn', 'Winter' and 'Spring'. When selecting one, the
                                   information associated with the selected time period is 
                                   displayed. By default, 'All' is displayed."),
                                
                                h4("Plot per year:"),
                                h5("This tab shows a barplot with the distribution of the 'n'
                                    strongest earthquakes occurred in Chile between 2003 and 2015. 
                                    The number 'n' can be selected in the first entry at the 
                                    bottom of the tab. You can select from 25 to 1000 data, by 
                                    default it is 300. Under this entry there is another
                                    entry that assigns the transparency level of the graph.
                                    This is useful to see when events of similar magnitude
                                    are repeated (more transparent means less repetition).
                                    The transparency range is from 0 to 1, and the default
                                    value is 0.2."),
                                
                                h4("Data per year:"),
                                h5("This tab shows the data of the earthquakes in Chile for
                                    the selected year. The table shows:"),
                                h5("Date: Date and time of the earthquake."),
                                h5("lat: Latitude where the earthquake occurred."),
                                h5("lng: Length where the earthquake occurred."),
                                h5("Depth: Depth in Km of the earthquake."),
                                h5("Magnitude: Magnitude of the earthquake on the Richter scale."),
                                h5("Ref: Reference of the nearest town."),
                                
                                h4("Documentation:"),
                                h5("This tab contains information about the data,
                                   the codes and how to use this application."),
                                br("")
                                
                       )
                 )
            )
      )
))