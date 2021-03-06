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
###5'-TTTTTT.../AAAAAA...
#CGGAAGAGCACACGTCTGAACTCCAGTCCCCGTTGTAT
#CGGAAAAGCACACGTCTGAACTCCAGTCACCGATGTATC
#CGGAAGGGCACACGTCTGAACTCCAGTCCCCGAT
#CGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTAT
#CGGAAGAGCCCACGTCTGAACTCCAGTCCCCGATGTT
#CGGAAGAGCACACGTCTGAACTCCAGTCCCCGATGTAT
#CGGAAGAGCACCCGTCTGAACTCCAGTCCCCGTTGTAT
#CGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCT
#CGGAAAAGCACACGTCTGACTCCAGTCACCGATGTATC
#CGGAAGAGCCCCCGTCTGAACCCCAGTCACCGATGT
#GGGAAGGCACCCGTTTGGACCCCCGTCCCCCGTTTT
#GAAGAGCCCCCGCCTGAACTCCCGTCACCGATT
#CGGAAAAGCCCCCGCTGGACTCCCGTCCCCGGTTTAAT
#CGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTAT
#-GGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCT
#-GGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCT
#CGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATC
#-GGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCT
#CGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTAT
#CGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTC
#----NGAGNNNACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCT
#---NAGANNNCACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTC
#----GAAGAGCACACGTCTGAACCAGTCACCGATGTATCTCGTATGCCGTCTTCT
#----AGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCT
#-----GAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCTG
#------AGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCTGC
#----AGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCT
#----AGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCT
#----AGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCT
#--GAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCT ###Adapter_seq2
#GACAAAAAAAAAAGATGGGAAAGGACCCCGTTTTAA - ARHGAP22_intron
###5'-AAAAAA...
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCG
#GATCGGAAGAGCACACGT
#GATCGGAAGAGCCCACGT
#GATCGGAAGAGCACCCGTCTGAACTCCAGTCCCCG
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCT
#GATCGGAAGAGCACACGTCTGAACTCC
#GATCGGAAGAGCACACGTCTTAACT
#GATCGGAAGAGCACACGTCTGAACTCCAGTAACCGATGTAT
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCG
#GATCGGAAGAGCACCCGTCTGAACTC
#GATCGGAAGAGCACACGTCTGAA
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCG
#GATCGGAAGAGCCCAC
#GATCGGAAGAGCACA
#GATCGGAAGAGCACA
#GATCGGAAGAGCACACGTCTG
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCG
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTC
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTAT
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTC
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCG
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCG
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTC
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCG
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCG
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCG
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCT
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGC
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCC ###51nt-Adapter_seq
###TruSeq Adapter, Index 2 (100% over 51bp)
#GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCTGC
###
cutadapt -m 10 -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCTGC ./"$file".fastq > ./"$file"_1_trimmed_adapter_type1.fastq 2> ./log_"$file"_APA_study_type1.txt
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./"$file"_1_trimmed_adapter_type1.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o "$file"_2_filtered_type1.fastq 2>> ./log_"$file"_APA_study_type1.txt
prinseq-lite.pl -fastq ./"$file"_2_filtered_type1.fastq -out_good ./"$file"_3_trimmed_pA_type1 -out_bad "$file"_3_contam_pA_type1 -trim_tail_left 5 -trim_tail_right 5 -min_len 10 2>> ./log_"$file"_APA_study_type1.txt
mkdir fastqc_"$file"_filtered_type1
fastqc -o ./fastqc_"$file"_filtered_type1 ./"$file"_3_trimmed_pA_type1.fastq -f fastq
bowtie -p 8 -v 2 -m 10 --best --strata -S --un "$file"_3_unmapped_type1.fastq /home/akimitsu/Downloads/bowtie1_index/hg19 "$file"_3_trimmed_pA_type1.fastq > "$file"_4_result.sam 2>> ./log_"$file"_APA_study_type1.txt
mkdir fastqc_"$file"_unmapped_type1
fastqc -o ./fastqc_"$file"_unmapped_type1 ./"$file"_3_unmapped_type1.fastq -f fastq
bowtie2 -p 8 -x /home/akimitsu/Downloads/bowtie2_index/hg19 --local --un ./"$file"_4_unmapped_bw2_local_type1.fastq -U ./"$file"_3_trimmed_pA_type1.fastq > ./"$file"_4_result_bw2_local.sam 2>> ./log_"$file"_APA_study_type1.txt
bowtie2 -p 8 -x /home/akimitsu/Downloads/bowtie2_index/hg19 --un ./"$file"_4_unmapped_bw2_type1.fastq -U ./"$file"_3_trimmed_pA_type1.fastq > ./"$file"_4_result_bw2.sam 2>> ./log_"$file"_APA_study_type1.txt
bowtie -p 8 -S --un "$file"_3_unmapped_ver2_type1.fastq /home/akimitsu/Downloads/bowtie1_index/hg19 "$file"_3_trimmed_pA_type1.fastq > "$file"_4_result_ver2.sam 2>> ./log_"$file"_APA_study_type1.txt
###
samtools view -Sb "$file"_4_result.sam | samtools sort - "$file"_4_result
mkdir UCSC_visual_"$file"
bedtools genomecov -ibam "$file"_4_result.bam -bg -split > ./UCSC_visual_${file}/"$file"_4_result.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}/tmp.txt
cat ./UCSC_visual_${file}/tmp.txt ./UCSC_visual_${file}/"$file"_4_result.bg > ./UCSC_visual_${file}/"$file"_4_result_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}/"$file"_4_result_for_UCSC.bg > ./UCSC_visual_${file}/"$file"_4_result_for_UCSC.bg.bz2
done
