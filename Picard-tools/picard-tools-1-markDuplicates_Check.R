if(require("Rsamtools")){
    print("Rsamtools is loaded correctly")
} else {
    print("trying to install Rsamtools...")
    source("http://bioconductor.org/biocLite.R")
    biocLite("Rsamtools")
    if(require("Rsamtools")){
        print("Rsamtools installed and loaded")
    } else {
        stop("could not install Rsamtools")
    }
}

library(Rsamtools)

bam.files <- c("/home/akimitsu/data/ChIP-seq_SE36_Pol2_salm_infection/1_No_infection_WCE/160308_Hiseq3B_l5_001_Dr_Akimitsu_Dr_Imamura_ATCACG_L005_R1_1_No_infection_WCE.marked.bam",
               "/home/akimitsu/data/ChIP-seq_SE36_Pol2_salm_infection/2_No_infection_Pol2/160308_Hiseq3B_l5_008_Dr_Akimitsu_Dr_Imamura_ACTTGA_L005_R1_2_No_infection_Pol2.marked.bam",
               "/home/akimitsu/data/ChIP-seq_SE36_Pol2_salm_infection/3_infection_WCE/160308_Hiseq3B_l5_010_Dr_Akimitsu_Dr_Imamura_TAGCTT_L005_R1_3_infection_WCE.marked.bam",
               "/home/akimitsu/data/ChIP-seq_SE36_Pol2_salm_infection/4_infection_Pol2/160308_Hiseq3B_l5_011_Dr_Akimitsu_Dr_Imamura_GGCTAC_L005_R1_4_infection_Pol2.marked.bam")
diagnostics <- list()

for (bam in bam.files) {
    total <- countBam(bam)$records
    mapped <- countBam(bam, param=ScanBamParam(
        flag=scanBamFlag(isUnmapped=FALSE)))$records
    marked <- countBam(bam, param=ScanBamParam(
        flag=scanBamFlag(isUnmapped=FALSE, isDuplicate=TRUE)))$records
    diagnostics[[bam]] <- c(Total=total, Mapped=mapped, Marked=marked)
}
diag.stats <- data.frame(do.call(rbind, diagnostics))
diag.stats$Prop.mapped <- diag.stats$Mapped/diag.stats$Total*100
diag.stats$Prop.marked <- diag.stats$Marked/diag.stats$Mapped*100
diag.stats
write.table(diag.stats, quote = F, sep = "\t", row.names = F, file = "./Bamfile_duplicates_results.txt")

##		       Total  Mapped  Marked Prop.mapped Prop.marked
## matureB-8059.bam 16675372 7752077 1054591    46.48818   13.603980
## matureB-8086.bam  6347683 4899961  195100    77.19291    3.981664
## proB-8108.bam    10413135 8213980  297796	78.88095    3.625478
## proB-8113.bam    10724526 9145743  489177	85.27876    5.348685
