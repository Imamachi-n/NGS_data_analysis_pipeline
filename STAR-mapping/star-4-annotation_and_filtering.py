#!/usr/bin/env python3

import sys

anno_file = open("/home/akimitsu/database/annotation_file/hg38/gencode.v24.basic.annotation.map.txt", 'r')

anno_trx_dict = {}
gene_dict = {}

for line in anno_file:
    line = line.rstrip()
    data = line.split("\t")
    trx_id = data[0]
    gene_id = data[1]
    gene_name = data[2]
    gene_type = data[3]
    trx_type = data[4]

    if not gene_id in anno_trx_dict:
        anno_trx_dict[gene_id] = [trx_id]
    else:
        anno_trx_dict[gene_id].append(trx_id)
    
    if not gene_id in gene_dict:
        gene_dict[gene_id] = [gene_name, gene_type]

input_file = open(sys.argv[1] + '/gene_exp.diff', 'r')
output_file = open(sys.argv[1] + '/gene_exp.annotated.diff', 'w')

gr_id = 1

for line in input_file:
    line = line.strip()
    data = line.split("\t")
    if data[0] == "test_id":
        print("gr_id", "gene_id", "trx_id", "gene_name", "gene_type", data[3], "\t".join(data[6:10]), "\t".join(data[11:]), sep="\t", end="\n", file=output_file)
        continue

    gene_id = data[1]
    trx_id = ','.join(anno_trx_dict[gene_id])
    gene_name = gene_dict[gene_id][0]
    gene_type = gene_dict[gene_id][1]

    if gene_type == 'miRNA' or gene_type == 'Mt_rRNA' or gene_type == 'Mt_tRNA' or gene_type == 'rRNA' or gene_type == 'scaRNA' or gene_type == 'snoRNA' or gene_type == 'snRNA' or gene_type == 'sRNA' or gene_type == 'vaultRNA':
        continue

    print(gr_id, gene_id, trx_id, gene_name, gene_type, data[3], "\t".join(data[6:10]), "\t".join(data[11:]), sep="\t", end="\n", file=output_file)
    gr_id += 1
