generateMatrix <- function(g_row,g_col=g_row,g_min=0,g_max=10) {
      x<-runif(g_row*g_col, min=g_min, max=g_max)
      y<-matrix(x,nrow = g_row,ncol = g_col)
      y
      
}