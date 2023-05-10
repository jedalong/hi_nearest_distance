library('move')
library('sf')
library('osmdata')
library('devtools')
library('ggplot2')
library('units')
devtools::install_github('jedalong/wildlifeHI')
library('wildlifeHI')

rFunction = function(data,r=r,key=key,value=value,geom=geom,poly2line=poly2line) {
  
  #check input data type
  if (class(data) != 'MoveStack'){
    if (class(data) == 'Move'){
      data <- moveStack(data, forceTz='UTC')
    } else {
      print('Input Data not of class MoveStack. Returning null object.')
      return(NULL)
    }
  }
  
  if (value == 'all'){
    move_dist <- hi_distance(move=data,key=key,geom=geom,poly2line=poly2line)
  } else {
    move_dist <- hi_distance(move=data,key=key,value=value,geom=geom,poly2line=poly2line)
  }
  
  #give R appropriate units
  units(r) <- units(move_dist$nearest_distance)
  
  move_df <- data.frame(move_dist)
  move_df$timestamp <- timestamps(move_dist)
  move_df$trackId <- trackId(move_dist)
  
  #Distance Plot
  pdfName <- paste0('DistanceAnalysisPlot_r_',r,'.pdf')
  
  dplot <- ggplot(move_df,aes(x=timestamp,y=nearest_distance)) + 
    geom_line() + 
    geom_hline(yintercept=r,linetype=2,color='red') + 
    facet_wrap(~trackId, scales='free_x')
  
  ggsave(appArtifactPath(pdfName), dplot)
  
  
  #Within Distance
  sub_df <- subset(move_df,nearest_distance < r)
  dtab <- table(sub_df$trackId,sub_df$nearest_value)
  csvName <- paste0('DistanceAnalysisTable_r_',r,'.csv')
  write.csv(dtab,appArtifactPath(csvName),row.names=TRUE)
  
  #return movestack
  return(move_dist)
}
