#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8
filename=`basename $@ .fastq`
for file in ${filename}
do
mkdir fastqc_"$file"
fastqc -t 8 -o ./fastqc_"$file" ./"$file".fastq -f fastq
done
