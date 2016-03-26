#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

inputDir=${1}

bedtools genomecov -ibam ${inputDir}.bam -bg -split > ${inputDir}.bg
echo "track type=bedGraph name=${inputDir} description=${inputDir} visibility=2 maxHeightPixels=40:40:20" > tmp.txt
cat tmp.txt ${inputDir}.bg > ${inputDir}_for_UCSC.bg
bzip2 -c ${inputDir}_for_UCSC.bg > ${inputDir}_for_UCSC.bg.bz2
