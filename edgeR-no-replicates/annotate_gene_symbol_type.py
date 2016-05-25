#!/usr/bin/env python3

#Usage: python3 annotate_gene_symbol_type.py anno_list.txt edgeR_output.txt output.txt

import sys

ref_file = open(sys.argv[1], 'r')

ref_dict = {}

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('#'):
        continue
    gene_name = data[0]
    ref_dict[gene_name] = line

input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if len(data) == 5:
        print('gene_id', 'gene_name', 'Akimitsu_gene_type', 'Gencode_gene_type', line, sep="\t", end="\n", file=output_file)
        continue
    gene_infor = ref_dict[data[0]]
    print(gene_infor, "\t".join(data[1:]), sep="\t", end="\n", file=output_file)
