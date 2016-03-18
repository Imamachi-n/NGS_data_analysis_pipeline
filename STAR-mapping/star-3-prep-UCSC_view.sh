#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

inputDir=${1}

bedtools genomecov -ibam ${inputDir}/STAR_accepted_hits_genome.bam -bg -split > ${inputDir}/STAR_accepted_hits_genome.bg
echo "track type=bedGraph name=${inputDir} description=${inputDir} visibility=2 maxHeightPixels=40:40:20" > ${inputDir}/tmp.txt
cat ${inputDir}/tmp.txt ${inputDir}/STAR_accepted_hits_genome.bg > ${inputDir}/STAR_accepted_hits_genome_for_UCSC.bg
bzip2 -c ${inputDir}/STAR_accepted_hits_genome_for_UCSC.bg > ${inputDir}/STAR_accepted_hits_genome_for_UCSC.bg.bz2
