#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G
filename=`basename $@ .bowtie`
for name in ${filename}
do
    PARalyzer_data_analysis.sh ${filename}.bowtie /home/akimitsu/database/genome/hg19.2bit 1
done
