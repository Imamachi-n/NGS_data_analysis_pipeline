#!/usr/bin/env python3

import sys

input_file = open(sys.argv[1], 'r')

ref_dict = {}
counter = 0

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('#'):
        continue
    types = data[2]
    if types == 'gene':
        counter += 1
    ref_dict[types] = 1

for key in ref_dict.keys():
    print(key, end="\n")

print(counter)