#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

file=`basename $@ .fastq`
threadNum=8
maxRAM=32000000000
maxSortRAM=32G
outputDir="STAR_output"

echo "-- Low quality reads and rRNA sequence removal..."
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./${file}.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o ${file}_1_filtered.fastq 2>> ./log_${file}.txt
bowtie -p 8 --seedlen=23 --un ${file}_2_norrna.fastq /home/akimitsu/database/bowtie1_index/contam_Ribosomal_RNA ${file}_1_filtered.fastq > ${file}_3_rrna_contam.fastq 2>> ./log_${file}.txt

echo "-- Fastq file QC after filtering..."
#mkdir fastqc_${file}_filtered
#fastqc -o ./fastqc_${file}_filtered ./${file}_3_norrna.fastq -f fastq

mkdir ${outputDir}_${file}
echo "-- Mapping fastq file with STAR aligner..."
STAR --runThreadN ${threadNum} --genomeDir /home/akimitsu/database/STAR_index/hg38_Gencode_v24 \
	 --readFilesIn ${file}_2_norrna.fastq --outFilterMultimapNmax 8 \
	 --outFilterType BySJout --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --sjdbScore 1 \
	 --outFilterMismatchNmax 4 --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
	 --quantMode TranscriptomeSAM --outSAMattributes NH HI NM MD AS --outSAMtype BAM SortedByCoordinate --limitBAMsortRAM ${maxRAM}
	 #--outSAMunmapped Within --genomeLoad NoSharedMemory --outSAMheaderCommentFile COfile.txt --outSAMheaderHD @HD VN:1.4 SO:coordinate

echo "-- Preparing log files..."
mv Log.final.out ${outputDir}_${file}
mv Log.out ${outputDir}_${file}
mv Log.progress.out ${outputDir}_${file}
mv SJ.out.tab ${outputDir}_${file}

echo "-- Preparing genome bam..."
mv Aligned.sortedByCoord.out.bam STAR_accepted_hits_genome.bam
mv STAR_accepted_hits_genome.bam ${outputDir}_${file}

echo "-- Sorting annotation bam..."
cat <( samtools view -H Aligned.toTranscriptome.out.bam ) \
    <( samtools view -@ ${threadNum} Aligned.toTranscriptome.out.bam | sort -S ${maxSortRAM} -T ./ ) | \
    samtools view -@ ${threadNum} -bS - > STAR_accepted_hits_anno.bam
mv Aligned.toTranscriptome.out.bam ${outputDir}_${file}
mv STAR_accepted_hits_anno.bam ${outputDir}_${file}

