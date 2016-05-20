#!/usr/bin/env python3

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if data[0] == '':
        continue
    print(line, end="\n", file=output_file)
