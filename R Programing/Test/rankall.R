rankall <- function(outcome, num = "best") {
      ## Read outcome data
      y2 <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
      z<-data.frame()
      ## Check that state are valid and 
      y3<-arrange(y2,State)
      state_dim<-unique(y3[,7])
      
      for (i in 1:length(state_dim)) {
            z[i,1]<-rankhospital(state_dim[i], outcome, num)
            z[i,2]<-state_dim[i]
      }
      colnames(z)<-c("hospital","state")
      z
      
      
      ## Check that state and outcome are valid
      ## For each state, find the hospital of the given rank
      ## Return a data frame with the hospital names and the
      ## (abbreviated) state name
      
      
      
}