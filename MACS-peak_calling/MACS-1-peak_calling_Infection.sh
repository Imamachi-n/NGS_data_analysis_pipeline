#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

controlBam="/home/akimitsu/data/ChIP-seq_SE36_Pol2_salm_infection/3_infection_WCE/160308_Hiseq3B_l5_010_Dr_Akimitsu_Dr_Imamura_TAGCTT_L005_R1_3_infection_WCE.blacklist_removed.bam"
treatBam="/home/akimitsu/data/ChIP-seq_SE36_Pol2_salm_infection/4_infection_Pol2/160308_Hiseq3B_l5_011_Dr_Akimitsu_Dr_Imamura_GGCTAC_L005_R1_4_infection_Pol2.blacklist_removed.bam"

macs14 -c ${controlBam} -t ${treatBam} -f BAM --name=Pol2_Infection
