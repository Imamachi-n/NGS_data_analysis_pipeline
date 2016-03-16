#!/bin/bash -e
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

genomeFasta="/home/akimitsu/database/genome/hg38/hg38.fa"
annotationGTF="/home/akimitsu/database/annotation_file/hg38/gencode.v24.basic.annotation.gtf"
saveFile="/home/akimitsu/database/RSEM_index/hg38_Gencode_v24/rsem"

rsem-prepare-reference --gtf ${annotationGTF} ${genomeFasta} ${saveFile}
