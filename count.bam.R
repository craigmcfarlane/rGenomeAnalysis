library("Rsamtools")

setwd("R/rnaseq")

what <- c("rname")
param <- ScanBamParam(what=what)

bam <-scanBam("vI/ic1vIs.bam",param=param)
counts <- as.data.frame(table(as.data.frame(bam[[1]])))
colnames(counts) <- c("contig","ic1")
rm("bam")

bam2 <-scanBam("vI/ic2vIs.bam",param=param)
counts2 <- as.data.frame(table(as.data.frame(bam2[[1]])))
colnames(counts2) <- c("contig","ic2")

rm("bam2")

bam3 <-scanBam("vI/ic3vIs.bam",param=param)
counts3 <- as.data.frame(table(as.data.frame(bam3[[1]])))
colnames(counts3) <- c("contig","ic3")

rm("bam3")

bam4 <-scanBam("vI/m01vIs.bam",param=param)
counts4 <- as.data.frame(table(as.data.frame(bam4[[1]])))
colnames(counts4) <- c("contig","m01")

rm("bam4")

all_counts <- merge(counts, counts2, by="contig")
all_counts <- merge(all_counts, counts3, by="contig")
all_counts <- merge(all_counts, counts4, by="contig")

write.table(all_counts, "all_counts.txt")
