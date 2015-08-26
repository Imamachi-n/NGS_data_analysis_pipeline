#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=16G
#$ -l mem_req=16
filename=`basename $@ .fastq`
for file in ${filename}
do
mkdir fastqc_"$file"
fastqc -o ./fastqc_"$file" ./"$file".fastq -f fastq
#fastx_clipper -Q64 -a AATGATACGGCGACCACCGACAGGTTCAGAGTTCTA -l 10 -n -v -i ./"$file".fastq -o ./"$file"_1_clipped.fastq
fastq_quality_filter -Q64 -q 20 -p 80 -i ./"$file".fastq | fastq_quality_trimmer -Q64 -t 20 -l 10 -o ./"$file"_1_filtered.fastq
mkdir fastqc_"$file"_filtered
fastqc -o ./fastqc_"$file"_filtered ./"$file"_1_filtered.fastq -f fastq
bowtie2 -p 8 -x /home/akimitsu/bowtie2-2.2.4/indexes/hg19 --local --un ./"$file"_2_unmapped_bw2.fastq -U ./"$file"_1_filtered.fastq > ./"$file"_2_result_bw2.sam 2>> ./log_"$file"_bw2.log
samtools view -Sb "$file"_2_result_bw2.sam | samtools sort - ./"$file"_2_result_bw2
mkdir UCSC_visual_"$file"
bedtools genomecov -ibam ./"$file"_2_result_bw2.bam -bg -split > ./UCSC_visual_${file}/"$file"_2_result_bw2.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}/tmp.txt
cat ./UCSC_visual_${file}/tmp.txt ./UCSC_visual_${file}/"$file"_2_result_bw2.bg > ./UCSC_visual_${file}/"$file"_2_result_bw2_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}/"$file"_2_result_bw2_for_UCSC.bg > ./UCSC_visual_${file}/"$file"_2_result_bw2_for_UCSC.bg.bz2
done
