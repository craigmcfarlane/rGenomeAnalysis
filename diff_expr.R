library("baySeq")
#setwd("R/rnaseq")

counts <- read.table("all_counts_vN.txt", header=TRUE)
#head(counts)
## subset of data to check other relationships
data2 <- as.matrix(cbind(counts[,2],counts[,3], counts[,4],counts[,5]))
replicates2 <- c("caE","caE","caL","caL")
groups2 <- list(NDE= c(1,1,1), DE= c(1,1,2,2))

CD2 <- new("countData", data=data2, replicates=replicates2, groups=groups2)

libsizes(CD2) <- getLibsizes(CD2)

#plotMA.CD(CD2,samplesA="c2", samplesB="n4", col = c(rep("red", 100), rep("black", 900)))

cl<-NULL
CD2 <- getPriors.NB(CD2, samplesize=500, estimation = "QL", cl=cl)

#plotPriors(CD2,group="NDE")
	## look for bimodality in the data, see bayseq docs


CD2 <- getLikelihoods.NB(CD2,pET= 'BIC',nullData=TRUE, cl=cl)

CD2@estProps
#CD2@posteriors[1:10,]

#plotPosteriors(CD2, group = "DE", col = c(rep("red", 100), rep("black", 900)))


alltop <- topCounts(CD2, group=2,FDR=1)
write.table(alltop, "topic1v2vN_all.txt")

top01 <- topcounts(CD2, group=2,FDR=.01)
write.table(top01,"topic1v2vN_FDR.01.txt")

