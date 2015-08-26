#!/usr/bin/env python3

import re

input_file = open('/mnt/hgfs/github/HuR_study/2015-08-07_sRNA-seq_analysis/raw_data/htseq_count_result_sRNAseq_HuR_study.txt','r')
output_file = open('/mnt/hgfs/github/HuR_study/2015-08-07_sRNA-seq_analysis/result/htseq_count_result_sRNAseq_HuR_study_for_DESeq.txt','w')

print('Gene_symbol','Control','HuR_KD1','HuR_KD2',sep="\t",end="\n",file=output_file)

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if re.match('^__',data[0]):
        continue
    print(data[0],data[1],data[3],data[5],sep="\t",end="\n",file=output_file)

input_file.close()
output_file.close()
