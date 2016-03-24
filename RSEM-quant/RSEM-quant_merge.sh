#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=2G
#$ -l mem_req=2G

sample3='RNA-seq_Fraction_No3'
sample4='RNA-seq_Fraction_No4'
sample5='RNA-seq_Fraction_No5'
sample6='RNA-seq_Fraction_No6'
sample7='RNA-seq_Fraction_No7'
sample8='RNA-seq_Fraction_No8'
sample9='RNA-seq_Fraction_No9'
sample10='RNA-seq_Fraction_No10'
sample11='RNA-seq_Fraction_No11'
sample12='RNA-seq_Fraction_No12'
result='RNA-seq_Fraction_CTRL'

paste <( cut -f 1-4 ${sample3}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample3}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample4}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample5}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample6}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample7}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample8}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample9}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample10}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample11}/rsem_output.genes.results ) \
      <( cut -f 7 ${sample12}/rsem_output.genes.results ) \
      > rsem_output_merged_${result}.genes.results