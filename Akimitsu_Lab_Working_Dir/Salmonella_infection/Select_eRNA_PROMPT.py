#!/usr/bin/env python3

import sys

ref_file = open(sys.argv[1], 'r')
input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

infor = {}

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    name = data[0]
    infor[name] = line

for line in ref_file:
    line = line.rstrip()
    name = line
    if name in infor:
        data = infor[name].split("\t")
        print(name,"\t".join(data[1:]),sep="\t",end="\n",file=output_file)
    else:
        print(name,"\t".join(['NA']*12),sep="\t",end="\n",file=output_file)