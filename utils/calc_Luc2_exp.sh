#!/bin/sh
filename=`basename $@ .bam`
for file in ${filename}
do
samtools bam2fq ${file}.bam > ${file}.fastq
bowtie2 -p 8 --very-sensitive -x /home/akimitsu/bowtie2-2.2.4/indexes/Luc2 -U ./"$file".fastq > ./"$file"_mapped_to_Luc2.sam 2>> ./"$file"_bowtie2_infor.txt
done
