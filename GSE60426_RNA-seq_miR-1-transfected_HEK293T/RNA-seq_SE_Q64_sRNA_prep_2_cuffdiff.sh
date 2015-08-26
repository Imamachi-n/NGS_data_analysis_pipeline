#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16
cuffdiff -p 8 --total-hits-norm --multi-read-correct -o ./cuffdiff_out_miR-1_overexpression_RefSeq /home/akimitsu/Refseq_gene_hg19_June_02_2014.gtf SRR1551164_mock-transfected_HEK293T_RNA_2_result_bw2.bam SRR1551166_miR-1-transfected_HEK293T_RNA_2_result_bw2.bam
