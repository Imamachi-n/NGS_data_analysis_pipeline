#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16
filename=`basename $@ .fastq`
for file in ${filename}
do
    ###Check_read_quality###
    mkdir fastqc_${file}
    fastqc -o ./fastqc_${file} ./${file}.fastq -f fastq

    ###Remove_low_quality_reads###
    fastq_quality_filter -Q32 -q 20 -p 80 -i ./${file}.fastq | fastq_quality_trimmer -Q32 -t 20 -l 10 -o ./${file}_1_filtered.fastq

    ###Remove_ribosomal_RNA_sequence###
    bowtie -p 8 --un ./${file}_2_norrna.fastq /home/akimitsu/bowtie-1.1.0/indexes/contam_Ribosomal_RNA ./${file}_1_filtered.fastq > rRNA.fastq 2>> ./log_${file}.txt
    
    ###Check_the_fastq_file###
    mkdir fastqc_${file}_rm_ribosomalRNA
    fastqc -o ./fastqc_${file}_rm_ribosomalRNA ./${file}_2_norrna.fastq -f fastq
    
    ###Mapping_to_Genome_&_Transcriptome###
    tophat -p 8 -o tophat_out_${file} -G /home/akimitsu/Refseq_gene_hg19_June_02_2014.gtf /home/akimitsu/bowtie-1.1.0/indexes/hg19 ${file}_2_norrna.fastq
    
    ###Mapping_to_Luc2_sequence###
    samtools bam2fq ./tophat_out_${file}/unmapped.bam > ./tophat_out_${file}/unmapped.fastq
    bowtie2 -p 8 --very-sensitive -x /home/akimitsu/bowtie2-2.2.4/indexes/Luc2 -U ./tophat_out_${file}/unmapped.fastq > ./tophat_out_${file}/${file}_mapped_to_Luc2.sam 2> ./tophat_out_${file}/Mapped_to_Luc2_${file}.txt

    ###Count_reads_mapped_to_transcriptome###
    htseq-count -f bam -s no ./tophat_out_${file}/accepted_hits.bam /home/akimitsu/Refseq_gene_hg19_June_02_2014.gtf > ./tophat_out_${file}/htseq_count_result_${file}.txt

    ###Data_visualization###
    mkdir UCSC_visual_"$file"
    bedtools genomecov -ibam ./tophat_out_${file}/accepted_hits.bam -bg -split > ./UCSC_visual_${file}/accepted_hits.bg
    echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}/tmp.txt
    cat ./UCSC_visual_${file}/tmp.txt ./UCSC_visual_${file}/accepted_hits.bg > ./UCSC_visual_${file}/accepted_hits_for_UCSC.bg
    bzip2 -c ./UCSC_visual_${file}/accepted_hits_for_UCSC.bg > ./UCSC_visual_${file}/accepted_hits_for_UCSC.bg.bz2
done
