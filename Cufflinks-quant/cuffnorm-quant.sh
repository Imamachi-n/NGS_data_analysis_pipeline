#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

outputDir="cuffnorm_out_RNA-seq_Fractionation"
annotationGTF="/home/akimitsu/database/annotation_file/hg38/gencode.v24.basic.annotation.gtf"
sample1="/home/akimitsu/data/RNA-seq_Fractionation/RNA-seq_cyto/STAR_output_for_cufflinks_CytoRNASeq/STAR_accepted_hits_genome.bam"
sample2="/home/akimitsu/data/RNA-seq_Fractionation/RNA-seq_nuc/STAR_output_for_cufflinks_NucRNASeq/STAR_accepted_hits_genome.bam"
sample3="/home/akimitsu/data/RNA-seq_Fractionation/RNA-seq_total/STAR_output_for_cufflinks_TotalRNASeq/STAR_accepted_hits_genome.bam"

cuffnorm -p 8 -o ${outputDir} ${annotationGTF} ${sample1} ${sample2} ${sample3}
