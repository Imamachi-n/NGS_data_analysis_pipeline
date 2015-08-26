#Title: DESeq2
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2015-04-17

require(DESeq2)

count <- read.table("C:/Users/Naoto/Documents/github/HuR_study/2015-08-07_sRNA-seq_analysis/result/htseq_count_result_sRNAseq_HuR_study_for_DESeq.txt",sep = "\t", header = T, row.names = 1)
count <- as.matrix(count)
group <- data.frame(con = factor(c("Control", "HuR_KD", "HuR_KD")))

dds <- DESeqDataSetFromMatrix(countData = count, colData = group, design = ~ con)
dds <- DESeq(dds)
res <- results(dds)

write.table(file="C:/Users/Naoto/Documents/github/HuR_study/2015-08-07_sRNA-seq_analysis/result/DESeq_result_sRNAseq_HuR_study_for_DESeq.txt",res,sep="\t",quote=F)
