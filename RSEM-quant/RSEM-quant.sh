#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G


fileName="${1}/STAR_accepted_hits_anno.bam"
indexPrefix="/home/akimitsu/database/RSEM_index/hg38_Gencode_v24/rsem"
sampleName="rsem_output"

mkdir ${outputDir}
echo "-- Calculate expression with RSEM..."
rsem-calculate-expression --bam --estimate-rspd --calc-ci --seed 12345 -p 8 \
                          --no-bam-output --ci-memory 16000 \
                          ${fileName} ${indexPrefix} ${sampleName}
