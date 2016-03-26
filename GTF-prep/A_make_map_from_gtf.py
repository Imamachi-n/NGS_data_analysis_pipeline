#!/usr/bin/env python3

import sys
import re

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

ref_dict = {}
#test = 'gene_id "ENSG00000223972.5"; transcript_id "ENST00000456328.2"; gene_type "transcribed_unprocessed_pseudogene"; gene_status "KNOWN"; gene_name "DDX11L1"; transcript_type "processed_transcript"; transcript_status "KNOWN"; transcript_name "DDX11L1-002"; level 2; tag "basic"; transcript_support_level "1"; havana_gene "OTTHUMG00000000961.2"; havana_transcript "OTTHUMT00000362751.1";'

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if re.match('^#', line):
        continue
    if data[2] != "exon":
        continue
    infor = data[8].split('; ')
    gene_id = ''
    trx_id = ''
    gene_name = ''
    gene_type = ''
    trx_type = ''
    for x in infor:
        if re.match('^gene_id', x):
            gene_id = x.replace('gene_id "', '')
            gene_id = gene_id.replace('"', '')
        elif re.match('^transcript_id', x):
            trx_id = x.replace('transcript_id "', '')
            trx_id = trx_id.replace('"', '')
        elif re.match('^gene_name', x):
            gene_name = x.replace('gene_name "', '')
            gene_name = gene_name.replace('"', '')
        elif re.match('^gene_type', x):
            gene_type = x.replace('gene_type "', '')
            gene_type = gene_type.replace('"', '')
        elif re.match('^transcript_type', x):
            trx_type = x.replace('transcript_type "', '')
            trx_type = trx_type.replace('"', '')
    if not trx_id in ref_dict:
        ref_dict[trx_id] = [gene_id, gene_name, gene_type, trx_type]

for x in ref_dict.keys():
    infor = ref_dict[x]
    gene_id = infor[0]
    gene_name = infor[1]
    gene_type = infor[2]
    trx_type = infor[3]
    print(x, gene_id, gene_name, gene_type, trx_type, sep="\t", end="\n", file=output_file)
