#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

file=`basename $@ .fastq`
threadNum=8
maxRAM=32000000000
maxSortRAM=32G
outputDir="STAR_output"

echo "-- Raw fastq file QC..."
#mkdir fastqc_${file}
#fastqc -o ./fastqc_${file} ./{$file}.fastq -f fastq

echo "-- Adapter sequence trimming..."
#Reference: https://github.com/ChangLab/FAST-iCLIP
cutadapt -m 10 -a AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTT ${file}.fastq > ${file}_1_trimmed_adapter.fastq

echo "-- Low quality reads and rRNA sequence removal..."
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./${file}_1_trimmed_adapter.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o ${file}_2_filtered.fastq 2>> ./log_${file}.txt
bowtie -p 8 --un ${file}_3_norrna.fastq /home/akimitsu/database/bowtie1_index/contam_Ribosomal_RNA ${file}_2_filtered.fastq > ${file}_3_rrna_contam.fastq 2>> ./log_${file}.txt
