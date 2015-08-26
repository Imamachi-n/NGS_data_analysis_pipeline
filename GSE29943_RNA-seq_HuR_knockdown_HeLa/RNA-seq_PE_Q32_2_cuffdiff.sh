#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16
cuffdiff -p 8 --total-hits-norm --multi-read-correct -o ./cuffdiff_out_RNA-seq_HeLa_HuRKD_RefSeq /home/akimitsu/Refseq_gene_hg19_June_02_2014.gtf ./tophat_out_SRR309282_HeLa_mock_knockdown_5d/accepted_hits.bam ./tophat_out_SRR309283_HeLa_HuR_siRNA1_2d/accepted_hits.bam,./tophat_out_SRR309284_HeLa_HuR_siRNA1_5d/accepted_hits.bam
