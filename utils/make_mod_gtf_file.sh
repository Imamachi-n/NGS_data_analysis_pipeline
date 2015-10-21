#!/bin/sh
perl gtf2bed.pl Refseq_gene_hg19_June_02_2014.gtf > Refseq_gene_hg19_June_02_2014.bed
python3 A1_select_less_than_200nt_transcripts_from_bed.py -i Refseq_gene_hg19_June_02_2014.gtf -r Refseq_gene_hg19_June_02_2014.bed -o Refseq_gene_hg19_June_02_2014_more_than_200nt.gtf
