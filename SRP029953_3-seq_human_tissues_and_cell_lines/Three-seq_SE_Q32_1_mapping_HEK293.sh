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
###TruSeq Adapter, Index 7
#---CGGAAGAGCACACGTCTGAACTCCAGTCACCAGATCATCTCGTATGCCGTC
#-----GAAGAGCACACGTCTGAACTCCAGTCACCAGATCATCTCGTATGCCGTCTT
#----GGAAGAGCACACGTCTGAACTCCAGTCACCAGATCATCTCGTATGCCGTCT
#------AAGAGCACACGTCTGAACTCCAGTCACCAGATCATCTCGTATGCCGTCTTC
#---CGGAAGAGCACACGTCTGAACTCCAGTCACCAGATCATCTCGTATGCCGTCTTC
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCAGATCATCTCGTATGCCGTCTTCTGCTTG
###
cutadapt -m 10 -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACCAGATCATCTCGTATGCCGTCTTCTGCTTG ./"$file".fastq > ./"$file"_1_trimmed_adapter_type1.fastq 2> ./log_"$file"_APA_study_type1.txt
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./"$file"_1_trimmed_adapter_type1.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o "$file"_2_filtered_type1.fastq 2>> ./log_"$file"_APA_study_type1.txt
prinseq-lite.pl -fastq ./"$file"_2_filtered_type1.fastq -out_good ./"$file"_3_trimmed_pA_type1 -out_bad "$file"_3_contam_pA_type1 -trim_tail_left 5 -trim_tail_right 5 -min_len 10 2>> ./log_"$file"_APA_study_type1.txt
mkdir fastqc_"$file"_filtered_type1
fastqc -o ./fastqc_"$file"_filtered_type1 ./"$file"_3_trimmed_pA_type1.fastq -f fastq
bowtie -p 8 -v 2 -m 10 --best --strata -S --un "$file"_3_unmapped_type1.fastq /home/akimitsu/Downloads/bowtie1_index/hg19 "$file"_3_trimmed_pA_type1.fastq > "$file"_4_result_type1.sam 2>> ./log_"$file"_APA_study_type1.txt
mkdir fastqc_"$file"_unmapped_type1
fastqc -o ./fastqc_"$file"_unmapped_type1 ./"$file"_3_unmapped_type1.fastq -f fastq
bowtie2 -p 8 -x /home/akimitsu/Downloads/bowtie2_index/hg19 --local --un ./"$file"_4_unmapped_bw2_local_type1.fastq -U ./"$file"_3_trimmed_pA_type1.fastq > ./"$file"_4_result_bw2_local_type1.sam 2>> ./log_"$file"_APA_study_type1.txt
bowtie2 -p 8 -x /home/akimitsu/Downloads/bowtie2_index/hg19 --un ./"$file"_4_unmapped_bw2_type1.fastq -U ./"$file"_3_trimmed_pA_type1.fastq > ./"$file"_4_result_bw2_type1.sam 2>> ./log_"$file"_APA_study_type1.txt
bowtie -p 8 -S --un "$file"_3_unmapped_ver2_type1.fastq /home/akimitsu/Downloads/bowtie1_index/hg19 "$file"_3_trimmed_pA_type1.fastq > "$file"_4_result_ver2_type1.sam 2>> ./log_"$file"_APA_study_type1.txt
###
samtools view -Sb "$file"_4_result_type1.sam | samtools sort - "$file"_4_result_type1
mkdir UCSC_visual_"$file"_type1
bedtools genomecov -ibam "$file"_4_result_type1.bam -bg -split > ./UCSC_visual_${file}_type1/"$file"_4_result_type1.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}_type1/tmp.txt
cat ./UCSC_visual_${file}_type1/tmp.txt ./UCSC_visual_${file}_type1/"$file"_4_result_type1.bg > ./UCSC_visual_${file}_type1/"$file"_4_result_type1_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}_type1/"$file"_4_result_type1_for_UCSC.bg > ./UCSC_visual_${file}_type1/"$file"_4_result_type1_for_UCSC.bg.bz2
done
