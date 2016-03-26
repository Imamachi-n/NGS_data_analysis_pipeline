if(require("rtracklayer")){
    print("rtracklayer is loaded correctly")
} else {
    print("trying to install rtracklayer...")
    source("http://bioconductor.org/biocLite.R")
    biocLite("rtracklayer")
    if(require("rtracklayer")){
        print("rtracklayer installed and loaded")
    } else {
        stop("could not install rtracklayer")
    }
}

if(require("csaw")){
    print("csaw is loaded correctly")
} else {
    print("trying to install csaw...")
    source("http://bioconductor.org/biocLite.R")
    biocLite("csaw")
    if(require("csaw")){
        print("csaw installed and loaded")
    } else {
        stop("could not install csaw")
    }
}

library(Rsamtools)
library(rtracklayer)
library(csaw)

###Required###
bam.files <- c("/home/akimitsu/data/ChIP-seq_SE36_Pol2_salm_infection/2_No_infection_Pol2/160308_Hiseq3B_l5_008_Dr_Akimitsu_Dr_Imamura_ACTTGA_L005_R1_2_No_infection_Pol2.marked.bam",
               "/home/akimitsu/data/ChIP-seq_SE36_Pol2_salm_infection/4_infection_Pol2/160308_Hiseq3B_l5_011_Dr_Akimitsu_Dr_Imamura_GGCTAC_L005_R1_4_infection_Pol2.marked.bam")

indexBam(bam.files)

original <- import("/home/akimitsu/database/genome/hg19_blacklist/hg19_blacklist.bed")
blacklist <- unlist(original)
saveRDS(file="hg19-blacklist.rds", blacklist)

#celltype <- sub("-.*",  "", bam.files)
#data.frame(BAM=bam.files,  CellType=celltype)

standard.chr <- paste0("chr", c(1:22, "X", "Y"))
param <- readParam(minq=37, discard=blacklist,restrict=standard.chr) #Max:37 (BWA)

x <- correlateReads(bam.files, param=reform(param, dedup=TRUE))
frag.len <- which.max(x) - 1
frag.len

png(filename = "./Average_fragment_length.png", width=640, height=640)
plot(1:length(x)-1, x, xlab="Delay (bp)", ylab="CCF", type="l")
abline(v=frag.len, col="red")
text(x=frag.len, y=min(x), paste(frag.len, "bp"), pos=4, col="red")
dev.off() #close_fig

win.data <- windowCounts(bam.files, param=param, width=160, ext=frag.len)
win.data

bins <- windowCounts(bam.files, bin=TRUE, width=2000, param=param)
filter.stat <- filterWindows(win.data,  bins, type="global")
min.fc <- 3
keep <- filter.stat$filter > log2(min.fc)
summary(keep)

png(filename = "./Average_abundances_across_all_2kb_genomic_bins.png", width=640, height=640)
hist(filter.stat$back.abundances, main="", breaks=50,
     xlab="Background abundance (log2-CPM)")
threshold <- filter.stat$abundances[1] - filter.stat$filter[1] + log2(min.fc)
abline(v=threshold, col="red")
dev.off() #close_fig

filtered.data <- win.data[keep,]

win.ab <- filter.stat$abundances[keep]
adjc <- log2(assay(filtered.data)+0.5)
logfc <- adjc[,2] - adjc[,1]
png(filename = "./Abundance-dependent_trend.png", width=640, height=640)
smoothScatter(win.ab, logfc, ylim=c(-6, 6), xlim=c(0, 5),
              xlab="Average abundance", ylab="Log-fold change")
dev.off() #close_fig

#Upgrade is needed (ver1.2.1 => ver1.4.1)
offsets <- normOffsets(filtered.data, type="loess")
head(offsets)

norm.adjc <- adjc - offsets/log(2)
norm.fc <- norm.adjc[,2]-norm.adjc[,1]
png(filename = "./Effect_of_non-linear_normalization.png", width=640, height=640)
smoothScatter(win.ab, norm.fc, ylim=c(-6, 6), xlim=c(0, 5),
              xlab="Average abundance", ylab="Log-fold change")
dev.off() #close_fig


gr <- rowRanges(filtered.data)

df <- data.frame(seqnames=seqnames(gr),
                 starts=start(gr)-1,
                 ends=end(gr),
                 Abundance=win.ab,
                 normFC=norm.fc)

write.table(df, quote = F, sep = "\t", row.names = F, file="./ChIP-seq_DB_result.txt")

write.table(test2, quote = F, sep = "\t", row.names = F, file="./ChIP-seq_DB_result_refseq.txt")


celltype <- c("NoInfection","Infection")
celltype <- factor(celltype)
design <- model.matrix(~0+celltype)
colnames(design) <- levels(celltype)
design

library(edgeR)
y <- asDGEList(filtered.data)
y$offset <- offsets
y <- estimateDisp(y, design)
summary(y$trended.dispersion)


