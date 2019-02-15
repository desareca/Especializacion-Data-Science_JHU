best <- function(state, outcome) {
      ##les necesario cargar dplyr
      
      ## Read outcome data
      y <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

      
      ## Check that state are valid and 
      state.ok<-sum(unique(y[,7])==state)
      if (state.ok<=0){
            stop("invalid state")
      }
      
      #filter the data according to the state
      y.state<-filter(y,State==state)

      ## Check that outcome are valid
      out.ha<-(outcome=="heart attack")
      out.hf<-(outcome=="heart failure")
      out.p<-(outcome=="pneumonia")
      
      outcome.ok<-out.ha|out.hf|out.p
      if (!outcome.ok){
            stop("invalid outcome")
      }
      
      ## Return hospital name in that state with lowest 30-day death
      #select the type of outcome
      if (out.ha){
            out<-11
      }else if (out.hf){
            out<-17
      }else if (out.p){
            out<-23     
      }
      
      #filter the "Not Available"
      y.state.outcome<-filter(y.state,y.state[,out]!="Not Available")
      
      #Modify the class to numeric to make ranking
      y.state.outcome[,out]<-as.numeric(y.state.outcome[,out])

      #generates a ranking based on the state, the requested exit and the name of the hospital
      z<-arrange(y.state.outcome,y.state.outcome[,out],y.state.outcome[,2])
      
      #Show the top in the list
      z[1,2]
      
}