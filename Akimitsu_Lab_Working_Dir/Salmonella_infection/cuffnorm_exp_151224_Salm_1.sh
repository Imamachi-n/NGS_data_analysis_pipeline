#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G
cuffnorm -p 8 --total-hits-norm -o ./cuffnorm_out_RNA-seq_infection_eRNA_v2_plus_uniq /home/akimitsu/database/Refseq_gene_hg19_June_02_2014+eRNA_v2.gtf ./tophat_out_150123_Hiseq2B_l1_005_Dr_Akimitu_ACAGTG_L001_R1_no_infection_2h/accepted_hits.uniq.sam ./tophat_out_150123_Hiseq2B_l1_006_Dr_Akimitu_GCCAAT_L001_R1_wt_2h/accepted_hits.uniq.sam ./tophat_out_150123_Hiseq2B_l2_007_Dr_Akimitu_CAGATC_L002_R1_no_infection_6h/accepted_hits.uniq.sam ./tophat_out_150123_Hiseq2B_l2_016_Dr_Akimitu_CCGTCC_L002_R1_wt_6h/accepted_hits.uniq.sam ./tophat_out_150123_Hiseq2B_l4_003_Dr_Akimitu_TTAGGC_L004_R1_no_infection_18h/accepted_hits.uniq.sam ./tophat_out_150123_Hiseq2B_l4_009_Dr_Akimitu_GATCAG_L004_R1_wt_18h/accepted_hits.uniq.sam
