#!/bin/bash
filename=`basename $@ .bam`
for file in filename
do
    samtools view -q 4 ${filename}.bam > ${filename}.uniq.sam
    cat ~/database/sam_header.txt ${filename}.uniq.sam > ${filename}.header.sam
    samtools view -Sb ${filename}.header.sam > ${filename}.uniq.bam
done
