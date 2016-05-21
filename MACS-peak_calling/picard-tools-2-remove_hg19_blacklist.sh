#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

file=`basename ${1} .fastq`

#bwa aln -q 5 -l 32 -k 2 -t 8 /home/akimitsu/database/genome/hg19/hg19.fa ${file}.fastq > ${file}.sai
#bwa samse /home/akimitsu/database/genome/hg19/hg19.fa ${file}.sai ${file}.fastq > ${file}.sam
#samtools view -Sb ${file}.sam | samtools sort - ${file}
#java -Xmx10000m -jar /home/akimitsu/software/picard-tools-1.119/MarkDuplicates.jar I="${file}.bam" O="${file}.marked.bam" M="${file}.marked.txt" TMP_DIR="./" AS=true REMOVE_DUPLICATES=false VALIDATION_STRINGENCY=SILENT
intersectBed -abam ${file}.marked.bam -b /home/akimitsu/database/genome/hg19_blacklist/hg19_blacklist.bed -v > ${file}.blacklist_removed.bam
