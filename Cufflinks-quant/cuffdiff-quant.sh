#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

outputDir="cuffdiff_out_RNA-seq_Fractionation"
genomeFasta="/home/akimitsu/database/genome/hg38/hg38.fa"
annotationGTF="/home/akimitsu/database/annotation_file/hg38/gencode.v24.basic.annotation.gtf"
sample1="/home/akimitsu/data/RNA-seq_Fractionation/RNA-seq_cyto/STAR_output_for_cufflinks_CytoRNASeq/STAR_accepted_hits_genome.bam"
sample2="/home/akimitsu/data/RNA-seq_Fractionation/RNA-seq_nuc/STAR_output_for_cufflinks_NucRNASeq/STAR_accepted_hits_genome.bam"

cuffdiff -p 8 --multi-read-correct --frag-bias-correct ${genomeFasta} -o ${outputDir} ${annotationGTF} ${sample1} ${sample2}
