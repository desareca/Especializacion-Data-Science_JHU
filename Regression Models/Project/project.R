#setwd("C:/Users/HP/Documents/Data Science/Regression Models/Week 4/Project")
data(mtcars)
#head(mtcars)
#str(mtcars)
#pairs(mtcars)

#mtcars$amAuto <- factor(mtcars$am)
#mtcars$amManual <- factor(1*(!mtcars$am))
#mtcars <- mtcars[,!(names(mtcars)=="am")]

mtcars$cyl <- factor(mtcars$cyl)
mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)