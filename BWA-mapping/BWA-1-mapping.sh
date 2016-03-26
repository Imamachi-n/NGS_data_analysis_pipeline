#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

file=`basename ${1} .fastq`

bwa aln -q 5 -l 32 -k 2 -t 8 /home/akimitsu/database/genome/hg38/hg38.fa ${file}.fastq > ${file}.sai
bwa samse /home/akimitsu/database/genome/hg38/hg38.fa ${file}.sai ${file}.fastq > ${file}.sam
samtools view -Sb ${file}.sam | samtools sort - ${file}