FromMaldiToCSV <- function(brukerFlexDir, number_of_spectra) {
  library("readBrukerFlexData")
  AllFiles <- readBrukerFlexDir(brukerFlexDir,
                                removeCalibrationScans = TRUE, removeMetaData = FALSE,
                                useHpc = TRUE, useSpectraNames = TRUE,
                                filterZeroIntensities = FALSE, verbose = FALSE)
  
  dir.create(paste(brukerFlexDir,"/readBrukerFlexData_Output", sep=""))
  diroutput=paste(brukerFlexDir,"/readBrukerFlexData_Output", sep="")
  
  for (valores in 1:number_of_spectra){
    x=names(AllFiles[valores])
    x=strsplit(names(AllFiles[valores]), "[.]")
    write.csv(AllFiles[[valores]]$spectrum, paste(diroutput, paste(x[[1]][1],x[[1]][2], sep=""), ".csv", sep =""), row.names = FALSE, )
  }
  
}