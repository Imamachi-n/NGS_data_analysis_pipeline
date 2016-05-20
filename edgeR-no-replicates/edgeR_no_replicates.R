#File name
args1 = commandArgs(trailingOnly=TRUE)[1]
args2 = commandArgs(trailingOnly=TRUE)[2]
args3 = commandArgs(trailingOnly=TRUE)[3]
args4 = commandArgs(trailingOnly=TRUE)[4]

library(edgeR)

input_file1 <- read.table(args1, header = F, row.names = 1)
input_file2 <- read.table(args2, header = F, row.names = 1)

count <- cbind(input_file1, input_file2)[,c(6,12)]
#colnames(count) <- c("no_infection_2h", "wt_2h")
colnames(count) <- c(args3, args4)
#group <- factor(c("no_infection_2h", "wt_2h"))
group <- factor(c(args3, args4))
d <- DGEList(counts = count, group = group)
d <- calcNormFactors(d)
d <- estimateGLMCommonDisp(d, method = "deviance", robust = T, subset = NULL)
result <- exactTest(d)
result_table <- result$table

output_file <- cbind(count, result_table)

write.table(output_file, quote = F, sep = "\t", file = paste("edgeR_no_replicates_",args3, "_vs_", args4,".txt", sep=""))
