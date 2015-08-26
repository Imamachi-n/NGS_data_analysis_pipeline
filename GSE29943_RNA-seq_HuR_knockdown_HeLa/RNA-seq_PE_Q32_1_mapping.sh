#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16
##--RAW_data_analysis--
filename=`basename $@ _1.fastq`
filename=`basename ${filename} _2.fastq`
for file in ${filename}
do
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./"$file"_1.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o "$file"_1_filtered_1.fastq 2>> ./log_"$file".txt
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./"$file"_2.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o "$file"_1_filtered_2.fastq 2>> ./log_"$file".txt
mkdir fastqc_"$file"_1_filtered
fastqc -o ./fastqc_"$file"_1_filtered ./"$file"_1_filtered_1.fastq -f fastq
mkdir fastqc_"$file"_2_filtered
fastqc -o ./fastqc_"$file"_2_filtered ./"$file"_1_filtered_2.fastq -f fastq
tophat -p 8 -o tophat_out_"$file" -G /home/akimitsu/Refseq_gene_hg19_June_02_2014.gtf /home/akimitsu/bowtie2-2.2.4/indexes/hg19 "$file"_1_filtered_1.fastq "$file"_1_filtered_2.fastq
mkdir UCSC_visual_"$file"
bedtools genomecov -ibam ./tophat_out_${file}/accepted_hits.bam -bg -split > ./UCSC_visual_${file}/accepted_hits.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}/tmp.txt
cat ./UCSC_visual_${file}/tmp.txt ./UCSC_visual_${file}/accepted_hits.bg > ./UCSC_visual_${file}/accepted_hits_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}/accepted_hits_for_UCSC.bg > ./UCSC_visual_${file}/accepted_hits_for_UCSC.bg.bz2
done
