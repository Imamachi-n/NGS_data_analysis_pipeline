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
#fastq-dump ./"$file".sra
#mkdir fastqc_"$file"
#fastqc -o ./fastqc_"$file" ./"$file".fastq -f fastq
#cutadapt -m 10 -a TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAAAAAA ./"$file".fastq > ./"$file"_1_trimmed_adapter.fastq 2> ./log_"$file".txt
#fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./"$file"_1_trimmed_adapter.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o "$file"_2_filtered.fastq 2>> ./log_"$file".txt
#bowtie -p 8 --un "$file"_3_norrna.fastq /home/akimitsu/bowtie-1.1.0/indexes/contam_Ribosomal_RNA "$file"_2_filtered.fastq > "$file"_3_rrna_contam.fastq 2>> ./log_"$file".txt
#mkdir fastqc_"$file"_filtered
#fastqc -o ./fastqc_"$file"_filtered ./"$file"_2_filtered.fastq -f fastq
#bowtie -p 8 -v 2 -m 10 --best --strata -S --un "$file"_3_unmapped.fastq /home/akimitsu/bowtie-1.1.0/indexes/hg19 "$file"_2_filtered.fastq > "$file"_4_result.sam 2>> ./log_"$file".txt
#mkdir fastqc_"$file"_unmapped
#fastqc -o ./fastqc_"$file"_unmapped ./"$file"_3_unmapped.fastq -f fastq
bowtie -p 8 -v 2 -m 10 --best --strata /home/akimitsu/bowtie-1.1.0/indexes/hg19 "$file"_2_filtered.fastq > "$file"_4_result.bowtie 2>> ./log_"$file".txt
samtools view -Sb "$file"_4_result.sam | samtools sort - "$file"_4_result
mkdir UCSC_visual_"$file"
bedtools genomecov -ibam "$file"_4_result.bam -bg -split > ./UCSC_visual_${file}/"$file"_4_result.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}/tmp.txt
cat ./UCSC_visual_${file}/tmp.txt ./UCSC_visual_${file}/"$file"_4_result.bg > ./UCSC_visual_${file}/"$file"_4_result_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}/"$file"_4_result_for_UCSC.bg > ./UCSC_visual_${file}/"$file"_4_result_for_UCSC.bg.bz2
sort -k 5,5 -k 6,6g "$file"_4_result.bowtie > "$file"_4_result_sorted.bowtie
done
