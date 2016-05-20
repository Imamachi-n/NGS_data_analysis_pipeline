#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

#File information - required
BamFile1="/home/akimitsu/data/RNAseq_150129_Dr_Yamamoto/tophat_out_150123_Hiseq2B_l1_005_Dr_Akimitu_ACAGTG_L001_R1_no_infection_2h/accepted_hits.bam"
BamFile2="/home/akimitsu/data/RNAseq_150129_Dr_Yamamoto/tophat_out_150123_Hiseq2B_l1_006_Dr_Akimitu_GCCAAT_L001_R1_wt_2h/accepted_hits.bam"
BamFile1Name="no_infection_2h"
BamFile2Name="wt_2h"

#Annotation
#GTFFile="/home/akimitsu/database/Refseq_gene_hg19_June_02_2014.gtf"
GTFFile="/home/akimitsu/database/Refseq_gene_hg19_June_02_2014+PROMPT+eRNA+FANTOM_eRNA.gtf"

#featureCounts - read counts
#featureCounts -T 8 -t exon -g gene_id -a ${GTFFile} -o featureCounts_result_${BamFile1Name}.txt ${BamFile1}
#featureCounts -T 8 -t exon -g gene_id -a ${GTFFile} -o featureCounts_result_${BamFile2Name}.txt ${BamFile2}

#sed -e "1,2d" featureCounts_result_${BamFile1Name}.txt > featureCounts_result_${BamFile1Name}_pre.txt
#sed -e "1,2d" featureCounts_result_${BamFile2Name}.txt > featureCounts_result_${BamFile2Name}_pre.txt

#python3 featureCounts_filecheck.py featureCounts_result_${BamFile1Name}_pre.txt featureCounts_result_${BamFile1Name}_for_R.txt
#python3 featureCounts_filecheck.py featureCounts_result_${BamFile2Name}_pre.txt featureCounts_result_${BamFile2Name}_for_R.txt

#rm featureCounts_result_${BamFile1Name}_pre.txt
#rm featureCounts_result_${BamFile2Name}_pre.txt

#edgeR - statistical analysis without replicate
Rscript edgeR_no_replicates.R featureCounts_result_${BamFile1Name}_for_R.txt featureCounts_result_${BamFile2Name}_for_R.txt ${BamFile1Name} ${BamFile2Name}
