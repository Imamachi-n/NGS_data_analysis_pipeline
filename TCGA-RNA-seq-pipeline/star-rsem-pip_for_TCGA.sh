#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=64G
#$ -l mem_req=64G

set -e

threadNum=8
maxRAM=64000000000
maxSortRAM=64G
outputDir="STAR_output"

echo "-- Prep samples..."
tar zxvf *.tar.gz

mkdir ${outputDir}
echo "-- Mapping fastq file with STAR aligner..."
STAR --runThreadN ${threadNum} --genomeDir /home/akimitsu/database/STAR_index/hg38_Gencode_v24 \
	 --readFilesIn *_1.fastq *_2.fastq --outFilterMultimapNmax 20 \
	 --outFilterType BySJout --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --sjdbScore 1 \
	 --outFilterMismatchNmax 999 --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
	 --outFilterMismatchNoverReadLmax 0.04 --quantMode TranscriptomeSAM \
	 --outSAMattributes NH HI NM MD AS --outSAMtype BAM SortedByCoordinate --limitBAMsortRAM ${maxRAM}
	 #--outSAMunmapped Within --genomeLoad NoSharedMemory --outSAMheaderCommentFile COfile.txt --outSAMheaderHD @HD VN:1.4 SO:coordinate

echo "-- Preparing log files..."
mv Log.final.out ${outputDir}
mv Log.out ${outputDir}
mv Log.progress.out ${outputDir}
mv SJ.out.tab ${outputDir}

echo "-- Preparing genome bam..."
mv Aligned.sortedByCoord.out.bam STAR_accepted_hits_genome.bam
mv STAR_accepted_hits_genome.bam ${outputDir}

echo "-- Sorting annotation bam..."
cat <( samtools view -H Aligned.toTranscriptome.out.bam ) \
    <( samtools view -@ ${threadNum} Aligned.toTranscriptome.out.bam | \
        awk '{printf $0 " "; getline; print}' | \
        sort -S ${maxSortRAM} -T ./ | tr ' ' '\n' ) | \
    samtools view -@ ${threadNum} -bS - > STAR_accepted_hits_anno.bam
mv Aligned.toTranscriptome.out.bam ${outputDir}
mv STAR_accepted_hits_anno.bam ${outputDir}

echo "-- Calculate expression with RSEM..."
fileName="./STAR_output/STAR_accepted_hits_anno.bam"
indexPrefix="/home/akimitsu/database/RSEM_index/hg38_Gencode_v24/rsem"
sampleName="rsem_output"

rsem-calculate-expression --bam --paired-end --estimate-rspd --calc-ci --seed 12345 -p 16 \
                          --no-bam-output --ci-memory 64000 \
                          ${fileName} ${indexPrefix} ${sampleName}

inputFile=`pwd`
outputPass="~/data/TCGA_data_raw/BRCA/A12D"

echo "-- Move the files to NIG supercom..."
echo ${inputFile}
scp -i ~/public_key/HGC-to-NIG_nopass -r ${inputFile} akimitsu@gw2.ddbj.nig.ac.jp:${outputPass}

echo " --Remove the files in HGC supercom..."
rm -rf ${inputFile}
