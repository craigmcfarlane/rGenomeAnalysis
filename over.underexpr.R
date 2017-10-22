library("Biostrings")
setwd("R/rnaseq")
file<-"topic12v3vN_FDR.01"


x<- read.table(sprintf("%s.txt",file),header=T)
#x<- [1:2000,]
over<-data.frame()
under<-data.frame()
for(i in 1:length(x$caL.1)){
	if(x$caL.1[i] > x$caE.1[i]){
		over<-rbind(over,x[i,])}
	else {
		under<-rbind(under,x[i,])}
}

write.table(over, sprintf("%s_earlyover.txt",file))

write.table(under, sprintf("%s_lateover.txt",file))
