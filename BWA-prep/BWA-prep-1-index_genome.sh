#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

bwa index -a bwtsw /home/akimitsu/database/genome/hg38/hg38.fa
