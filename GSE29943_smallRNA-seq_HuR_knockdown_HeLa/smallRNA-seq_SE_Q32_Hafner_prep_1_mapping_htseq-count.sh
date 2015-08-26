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
mkdir fastqc_"$file"
fastqc -o ./fastqc_"$file" ./"$file".fastq -f fastq
cutadapt -m 10 -a ATCTCGTATGCCGTCTTCTGCTTG ./"$file".fastq > ./"$file"_1_trimmed_adapter.fastq 2> ./log_"$file".txt
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./"$file"_1_trimmed_adapter.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o "$file"_2_filtered.fastq 2>> ./log_"$file".txt
mkdir fastqc_"$file"_filtered
fastqc -o ./fastqc_"$file"_filtered ./"$file"_2_filtered.fastq -f fastq
bowtie -p 8 -v 2 -m 10 --best --strata -S /home/akimitsu/bowtie-1.1.0/indexes/hg19 "$file"_2_filtered.fastq > "$file"_4_result.sam 2>> ./log_"$file".txt
bowtie2 -p 8 -x /home/akimitsu/bowtie2-2.2.4/indexes/hg19 --local --un ./"$file"_4_unmapped_bw2.fastq -U ./"$file"_2_filtered.fastq > ./"$file"_4_result_bw2.sam 2>> ./log_"$file"_bw2.log
samtools view -Sb "$file"_4_result_bw2.sam | samtools sort - "$file"_4_result_bw2
mkdir UCSC_visual_"$file"_bw2
bedtools genomecov -ibam "$file"_4_result_bw2.bam -bg > ./UCSC_visual_${file}_bw2/"$file"_4_result_bw2.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}/tmp.txt
cat ./UCSC_visual_${file}_bw2/tmp.txt ./UCSC_visual_${file}_bw2/"$file"_4_result_bw2.bg > ./UCSC_visual_${file}_bw2/"$file"_4_result_bw2_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}_bw2/"$file"_4_result_bw2_for_UCSC.bg > ./UCSC_visual_${file}_bw2/"$file"_4_result_bw2_for_UCSC.bg.bz2
htseq-count -f bam -t miRNA -i Name ./"$file"_4_result_bw2.bam /home/akimitsu/miRBase_v20_hsa.gff3 > htseq_count_result_${file}.txt
done
