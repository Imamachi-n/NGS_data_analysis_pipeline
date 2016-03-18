#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

file=`basename $@ .fastq`
threadNum=8
maxRAM=32000000000
maxSortRAM=32G
outputDir="STAR_output_for_cufflinks"

mkdir ${outputDir}_${file}
echo "-- Mapping fastq file with STAR aligner..."
STAR --runThreadN ${threadNum} --genomeDir /home/akimitsu/database/STAR_index/hg38_Gencode_v24 \
	 --readFilesIn ${file}_2_norrna.fastq --outFilterMultimapNmax 20 \
	 --outFilterType BySJout --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --sjdbScore 1 \
	 --outFilterMismatchNmax 999 --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
	 --outFilterMismatchNoverReadLmax 0.04 --quantMode TranscriptomeSAM \
	 --outSAMattributes NH HI NM MD AS --outSAMtype BAM SortedByCoordinate --limitBAMsortRAM ${maxRAM} \
	 --outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonical
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
