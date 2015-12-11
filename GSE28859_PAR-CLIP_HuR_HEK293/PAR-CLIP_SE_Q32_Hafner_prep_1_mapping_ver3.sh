#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G
##--RAW_data_analysis--
filename=`basename $@ .fastq`
for file in ${filename}
do
    mkdir fastqc_"$file"
    fastqc -o ./fastqc_"$file" ./"$file".fastq -f fastq
    cutadapt -m 10 -a TCGTATGCCGTCTTCTGCTTG ./"$file".fastq > ./"$file"_1_trimmed_adapter_ver3.fastq 2> ./log_"$file"_ver3.txt
    fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./"$file"_1_trimmed_adapter_ver3.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o "$file"_2_filtered_ver3.fastq 2>> ./log_"$file"_ver3.txt
    mkdir fastqc_"$file"_filtered_ver3
    fastqc -o ./fastqc_"$file"_filtered_ver3 ./"$file"_2_filtered_ver3.fastq -f fastq
    bowtie -p 8 -v 2 -m 10 --best --strata -S --un "$file"_3_unmapped_ver3.fastq /home/akimitsu/database/bowtie1_index/hg19 "$file"_2_filtered_ver3.fastq > "$file"_4_result_ver3.sam 2>> ./log_"$file"_ver3.txt
    mkdir fastqc_"$file"_unmapped_ver3
    fastqc -o ./fastqc_"$file"_unmapped_ver3 ./"$file"_3_unmapped_ver3.fastq -f fastq
    bowtie -p 8 -v 2 -m 10 --best --strata /home/akimitsu/database/bowtie1_index/hg19 "$file"_2_filtered_ver3.fastq > "$file"_4_result_ver3.bowtie 2>> ./log_"$file"_ver3.txt
    samtools view -Sb "$file"_4_result_ver3.sam | samtools sort - "$file"_4_result_ver3
    mkdir UCSC_visual_"$file"_ver3
    bedtools genomecov -ibam "$file"_4_result_ver3.bam -bg -split > ./UCSC_visual_${file}_ver3/"$file"_4_result.bg
    echo "track type=bedGraph name=${file}_ver3 description=${file}_ver3 visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}_ver3/tmp.txt
    cat ./UCSC_visual_${file}_ver3/tmp.txt ./UCSC_visual_${file}_ver3/"$file"_4_result.bg > ./UCSC_visual_${file}_ver3/"$file"_4_result_for_UCSC.bg
    bzip2 -c ./UCSC_visual_${file}_ver3/"$file"_4_result_for_UCSC.bg > ./UCSC_visual_${file}_ver3/"$file"_4_result_for_UCSC.bg.bz2
    sort -k 5,5 -k 6,6g "$file"_4_result_ver3.bowtie > "$file"_4_result_ver3_sorted.bowtie
    sort -k 3,3 -k 4,4n "$file"_4_result_ver3.sam > "$file"_4_result_ver3_sorted.sam
done
