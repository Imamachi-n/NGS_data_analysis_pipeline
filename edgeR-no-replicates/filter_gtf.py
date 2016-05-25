#!/usr/bin/env python3

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

for line in input_file:
    flg = 0
    line = line.rstrip()
    if line.startswith('#'):
        continue
    data = line.split("\t")
    gene_infor = data[8].split("; ")
    for x in gene_infor:
        if x.startswith('transcript_type'):
            x = x.replace('transcript_type "', '')
            x = x.replace('"', '')
            if x == 'rRNA' or x == 'Mt_rRNA' or x == 'Mt_tRNA':
                # print(line)
                flg = 1
                break
    if flg == 0:
        print(line, end="\n", file=output_file)
