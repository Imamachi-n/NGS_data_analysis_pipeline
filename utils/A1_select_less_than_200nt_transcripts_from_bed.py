#!/usr/bin/env python3
#Title: A1_select_less_than_200nt_transcripts_from_bed
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2015-10-21

"""
Usage:
  A1_select_less_than_200nt_transcripts_from_bed.py [-i input_gtf_file] [-r reference_bed_file] [-o output_gtf_file]

"""

import argparse
import re

parser = argparse.ArgumentParser(prog="A1_select_less_than_200nt_transcripts_from_bed")
parser.add_argument('-i','--input-gtf-file', action='store', dest='input_file', help='input your gtf file')
parser.add_argument('-r','--reference-bed-file', action='store', dest='reference_file', help='input your bed file derived from gtf input file')
parser.add_argument('-o','--output-gtf-file', action='store', dest='output_file', help='name your output file')
args = parser.parse_args()

input_path = args.input_file
ref_path = args.reference_file
output_path = args.output_file

ref_file = open(ref_path,'r')
ref_data = {}

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    refid = data[3]
    exon_block = data[10].split(',')
    exon_block.pop()
    exon_size = 0
    for x in range(0,len(exon_block)):
        exon_size += int(exon_block[x])
    if exon_size < 200:
        if not refid in ref_data:
            ref_data[refid] = 1
        else:
            pass

input_file = open(input_path,'r')
output_file = open(output_path,'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    data_infor = data[8].split('; ')
    for x in range(0,len(data_infor)):
        if re.search('transcript_id', data_infor[x]):
            test = data_infor[x].replace('transcript_id ','')
            test = test.replace('"','')
            if not test in ref_data:
                print(line,end="\n",file=output_file)
                continue
