#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16
filename=`basename $@ .fastq`
for file in ${filename}
do
mkdir fastqc_"$file"
fastqc -o ./fastqc_"$file" ./"$file".fastq -f fastq
fastq_quality_filter -Q32 -q 20 -p 80 -i ./"$file".fastq | fastq_quality_trimmer -Q32 -t 20 -l 10 -o ./"$file"_1_filtered.fastq
bowtie -p 8 --un ./"$file"_2_norrna.fastq /home/akimitsu/bowtie-1.1.0/indexes/contam_Ribosomal_RNA ./"$file"_1_filtered.fastq > rRNA.fastq 2>> ./log_"$file".txt
mkdir fastqc_"$file"_rm_ribosomalRNA
fastqc -o ./fastqc_"$file"_rm_ribosomalRNA ./"$file"_2_norrna.fastq -f fastq
tophat -p 8 -o tophat_out_"$file" -G /home/akimitsu/gencode.v19.annotation.gtf /home/akimitsu/bowtie-1.1.0/indexes/hg19 "$file"_2_norrna.fastq
cuffquant -p 8 -multi-read-correct -o cuffquant_out_"$file"_Gencode_v19 /home/akimitsu/gencode.v19.annotation.gtf ./tophat_out_"$file"/accepted_hits.bam
cuffquant -p 8 -multi-read-correct -o cuffquant_out_"$file"_RefSeq /home/akimitsu/Refseq_gene_hg19_June_02_2014.gtf ./tophat_out_"$file"/accepted_hits.bam
mkdir UCSC_visual_"$file"
bedtools genomecov -ibam ./tophat_out_${file}/accepted_hits.bam -bg -split > ./UCSC_visual_${file}/accepted_hits.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}/tmp.txt
cat ./UCSC_visual_${file}/tmp.txt ./UCSC_visual_${file}/accepted_hits.bg > ./UCSC_visual_${file}/accepted_hits_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}/accepted_hits_for_UCSC.bg > ./UCSC_visual_${file}/accepted_hits_for_UCSC.bg.bz2
done
