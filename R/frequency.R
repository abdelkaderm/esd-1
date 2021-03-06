## Author : A. Mezghani
## used in check.ncdf4()

## Full time frequency names
frequency.name <- c("year","season","month","day","hours","minutes","seconds")

## Abbreviated time frequency names 
frequency.abb  <-  substr(tolower(frequency.name),1,3) 

frequency.data <- function(data=NULL,unit=NULL,verbose=FALSE) {
  if (is.null(data) | is.null(unit)) stop("Both data and unit are mandatory inputs !")
 # Initialize
 freq <- NULL
 # compute interval
 dt <- round(median(diff(data)))
 # Automatic detection 
 if (!is.null(unit)) {
    if ((((dt==31) | (dt==30)) & grepl("day",unit)) | ((dt==1) & grepl("mon",unit)) | (((dt==744) | (dt==728) | (dt==720)) & grepl("hou",unit) | (((dt==31) | (dt==1440) | (dt==44640)) & grepl("min",unit))))
       freq <- "month"
    if (((dt==1) & grepl("day",unit)) | ((dt==24) & grepl("hou",unit)))
       freq <- "day" 
    if ((dt==7) & grepl("day",unit))
       freq <- "week"
    if ((dt==14) & grepl("day",unit))
       freq <- "2weeks"
    if (((dt==1) & grepl("hou",unit)) | ((dt==3600) & grepl("hou",unit)))
       freq <- "hour"
    if ((dt==6) & grepl("hou",unit))
       freq <- "6hour"
    if ((dt==12) & grepl("hou",unit))
       freq <- "12hour"
    if ((dt==12) & grepl("mon",unit))
       freq <- "year"
    if ((dt==3) & grepl("mon",unit))
       freq <- "season"
 } else if (is.null(freq)) {
# User entry
    if (verbose)
      print("Frequency could not be set automatically !")
    print(paste(as.character(seq(1,12,1)),frequency.name,sep=":"))
    ifreq <- as.integer(readline("Please select a frequency number from the list before continue and press Enter:"))   
    if (!is.na(ifreq)) 
      freq <- frequency.abb[ifreq]
    else stop("You must provide an integer from the list !")
    if (is.null(freq)) stop("Process is stopped: User should provide the frequency before continuing !")
  }
  return(freq)
  invisible(freq)
}
