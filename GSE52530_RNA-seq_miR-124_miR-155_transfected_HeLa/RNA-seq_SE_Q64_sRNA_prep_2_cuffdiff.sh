#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16
cuffdiff -p 8 --total-hits-norm --multi-read-correct -o ./cuffdiff_out_miR-124_overexpression_RefSeq /home/akimitsu/Refseq_gene_hg19_June_02_2014.gtf ./SRR1032877_Mock_transfection_to_HeLa_1_2_result_bw2.bam,./SRR1032878_Mock_transfection_to_HeLa_2_2_result_bw2.bam ./SRR1032873_miR-124_transfection_to_HeLa_1_2_result_bw2.bam,./SRR1032874_miR-124_transfection_to_HeLa_2_2_result_bw2.bam
cuffdiff -p 8 --total-hits-norm --multi-read-correct -o ./cuffdiff_out_miR-155_overexpression_RefSeq /home/akimitsu/Refseq_gene_hg19_June_02_2014.gtf ./SRR1032877_Mock_transfection_to_HeLa_1_2_result_bw2.bam,./SRR1032878_Mock_transfection_to_HeLa_2_2_result_bw2.bam ./SRR1032875_miR-155_transfection_to_HeLa_1_2_result_bw2.bam,./SRR1032876_miR-155_transfection_to_HeLa_2_2_result_bw2.bam