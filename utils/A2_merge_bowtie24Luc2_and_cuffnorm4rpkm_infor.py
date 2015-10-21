#!/usr/bin/env python3
#Title: A2_merge_bowtie24Luc2_and_cuffnorm4rpkm_infor
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2015-10-21

import re
output_file = open("BRIC-seq_siCTRL_Luc2_Rel_RPKM.txt",'w')

def bowtie2_input(input_file_infor):
    #bowtie2 - result
    #4417 (0.44%) aligned exactly 1 time
    regex = r'\s+(?P<reads>[0-9]+) \([0-9]+\.[0-9]+%\) aligned exactly 1 time'
    reads_list = []

    for input_files in input_file_infor:
        input_file = open(input_files,'r')
        for line in input_file:
            line = line.rstrip()
            if re.search('aligned exactly 1 time',line):
                result = re.match(regex, line)
                reads = int(result.group('reads'))
                if not reads_list:
                    reads_list = [reads]
                else:
                    reads_list.append(reads)
    return reads_list

def calc_rel_rpkm(total_count_file):
    total_count = []

    for line in total_count_file:
        line = line.rstrip()
        data = line.split("\t")
        if data[0] == "sample_id":
            continue
        total = float(data[2])
        if not total_count:
            total_count = [total]
        else:
            total_count.append(total)

    rpkm = [reads_list[x]/total_count[x] for x in range(0,len(total_count))]
    rel_rpkm = [rpkm[x]/rpkm[0] for x in range(0,len(rpkm))]
    return rel_rpkm

#################################################

input_file_infor = ["unmapped_bowtie2_infor_BRIC-seq_siCTRL_0h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siCTRL_1h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siCTRL_2h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siCTRL_4h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siCTRL_8h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siCTRL_12h.txt"]
total_count_file = open("siCTRL_samples.table",'r')

reads_list = bowtie2_input(input_file_infor)

rel_rpkm = calc_rel_rpkm(total_count_file)
rel_rpkm = map(str,rel_rpkm)
print('sample','0h','1h','2h','4h','8h','12h',sep="\t",end="\n",file=output_file)
print('siCTRL',"\t".join(rel_rpkm),sep="\t",end="\n",file=output_file)

########################

input_file_infor = ["unmapped_bowtie2_infor_BRIC-seq_siStealth_0h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siStealth_1h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siStealth_2h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siStealth_4h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siStealth_8h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siStealth_12h.txt"]
total_count_file = open("siStealth_samples.table",'r')

reads_list = bowtie2_input(input_file_infor)

rel_rpkm = calc_rel_rpkm(total_count_file)
rel_rpkm = map(str,rel_rpkm)
print('siStealth',"\t".join(rel_rpkm),sep="\t",end="\n",file=output_file)

########################

input_file_infor = ["unmapped_bowtie2_infor_BRIC-seq_siPUM1_0h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM1_1h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM1_2h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM1_4h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM1_8h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM1_12h.txt"]
total_count_file = open("siPUM1_samples.table",'r')

reads_list = bowtie2_input(input_file_infor)

rel_rpkm = calc_rel_rpkm(total_count_file)
rel_rpkm = map(str,rel_rpkm)
print('siPUM1',"\t".join(rel_rpkm),sep="\t",end="\n",file=output_file)

########################

input_file_infor = ["unmapped_bowtie2_infor_BRIC-seq_siPUM2_0h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM2_1h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM2_2h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM2_4h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM2_8h.txt",
                    "unmapped_bowtie2_infor_BRIC-seq_siPUM2_12h.txt"]
total_count_file = open("siPUM2_samples.table",'r')

reads_list = bowtie2_input(input_file_infor)

rel_rpkm = calc_rel_rpkm(total_count_file)
rel_rpkm = map(str,rel_rpkm)
print('siPUM2',"\t".join(rel_rpkm),sep="\t",end="\n",file=output_file)

