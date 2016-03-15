#!/bin/bash -e
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=50G
#$ -l mem_req=50G

#Required
threads=8
indexOutput="./"
genomeFasta="/home/akimitsu/database/genome/hg38/hg38.fa"
annotationGTF="/home/akimitsu/database/annotation_file/hg38/gencode.v24.basic.annotation.gtf"

STAR --runThreadN ${threads} --runMode genomeGenerate --genomeDir ${indexOutput} \
     --genomeFastaFiles ${genomeFasta} --sjdbGTFfile ${annotationGTF} --sjdbOverhang 100
