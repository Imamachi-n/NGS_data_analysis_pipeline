#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16
##--RAW_data_analysis--
filename=`basename $@ .fastq`
for file in ${filename}
do
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./${file}.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o ${file}_1_filtered.fastq 2>> ./log_${file}_ChIP-seq_HeLa.txt
mkdir fastqc_"$file"_filtered
fastqc -o ./fastqc_${file}_filtered ${file}_1_filtered.fastq -f fastq
bowtie2 -p 8 -x /home/akimitsu/Downloads/bowtie2_index/hg19 --un ./${file}_2_unmapped_bw2.fastq -U ./${file}_1_filtered.fastq > ./${file}_2_mapped_bw2.sam 2>> ./log_${file}_ChIP-seq_HeLa.txt
samtools view -Sb ./${file}_2_mapped_bw2.sam | samtools sort - ${file}_2_mapped_bw2_raw
grep -v "XS" ./${file}_2_mapped_bw2.sam > ./${file}_2_mapped_bw2_unique.sam
samtools view -Sb ./${file}_2_mapped_bw2_unique.sam | samtools sort - ${file}_2_mapped_bw2_unique
###
mkdir UCSC_visual_${file}_raw
bedtools genomecov -ibam ${file}_2_mapped_bw2_raw.bam -bg -split > ./UCSC_visual_${file}_raw/${file}_2_mapped_bw2_raw.bg
echo "track type=bedGraph name=${file}_raw description=${file}_raw visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}_raw/tmp.txt
cat ./UCSC_visual_${file}_raw/tmp.txt ./UCSC_visual_${file}_raw/"$file"_2_mapped_bw2_raw.bg > ./UCSC_visual_${file}_raw/"$file"_2_mapped_bw2_raw_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}_raw/"$file"_2_mapped_bw2_raw_for_UCSC.bg > ./UCSC_visual_${file}_raw/"$file"_2_mapped_bw2_raw_for_UCSC.bg.bz2
###
mkdir UCSC_visual_${file}_unique
bedtools genomecov -ibam ${file}_2_mapped_bw2_unique.bam -bg -split > ./UCSC_visual_${file}_unique/${file}_2_mapped_bw2_unique.bg
echo "track type=bedGraph name=${file}_unique description=${file}_unique visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}_unique/tmp.txt
cat ./UCSC_visual_${file}_unique/tmp.txt ./UCSC_visual_${file}_unique/${file}_2_mapped_bw2_unique.bg > ./UCSC_visual_${file}_unique/${file}_2_mapped_bw2_unique_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}_unique/${file}_2_mapped_bw2_unique_for_UCSC.bg > ./UCSC_visual_${file}_unique/${file}_2_mapped_bw2_unique_for_UCSC.bg.bz2
done
