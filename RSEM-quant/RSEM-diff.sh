#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

inputFile1="/home/akimitsu/data/UPF1_study/RNA-seq_v2/NoCTRL/rsem_output.genes.results"
inputFile2="/home/akimitsu/data/UPF1_study/RNA-seq_v2/siCTRL_1/rsem_output.genes.results"
inputFile3="/home/akimitsu/data/UPF1_study/RNA-seq_v2/siCTRL_2/rsem_output.genes.results"
inputFile4="/home/akimitsu/data/UPF1_study/RNA-seq_v2/siUPF1_1/rsem_output.genes.results"
inputFile5="/home/akimitsu/data/UPF1_study/RNA-seq_v2/siUPF1_2/rsem_output.genes.results"
outputFile="GeneMat.de.txt"

rsem-generate-data-matrix ${inputFile1} ${inputFile2} ${inputFile3} ${inputFile4} ${inputFile5} > GeneMat.txt
/home/akimitsu/software/RSEM-1.2.29/rsem-run-ebseq GeneMat.txt 3,2 GeneMat.results
/home/akimitsu/software/RSEM-1.2.29/rsem-control-fdr GeneMat.results 0.05 ${outputFile}
