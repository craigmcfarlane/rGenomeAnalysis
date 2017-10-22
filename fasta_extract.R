library("Biostrings")
setwd("R/rnaseq")


diffFile<-"topic12v3vN_earlyover"
seqs<-"nc3be.min"
diff <- read.table(sprintf("%s.txt",diffFile) , header=TRUE)
file <- readDNAStringSet(sprintf("%s.fa",seqs))

x<- subset(diff,select=c("rowID"))
x<- as.matrix(as.character(x$rowID))
x<-matrix(as.numeric(unlist(strsplit(x,"_"))))

##attempt to loop through string set and test whether in x, won't out put
##anything but a null matches
matches = DNAStringSet()
j<-data.frame(stringsAsFactors=FALSE)
Colnames<-c("index","sequence")
#
for(i in 1:max(names(file))) {
	if(i %in% x) {
		matches <- append(matches, file[i], after=length(matches))
		j<-rbind(j,c(i,as.numeric(names(file[i]))))
		names(j)<-Colnames
}}
head(matches)
length(matches)

writeXStringSet(matches,file=sprintf("%s.fasta",diffFile), width=80, append=TRUE)

reads<-read.table("a_count")
colnames(reads)<-"index"
q<-merge(reads,j,by="index")
write.table(q,file=sprintf("%s_seqs",diffFile))

