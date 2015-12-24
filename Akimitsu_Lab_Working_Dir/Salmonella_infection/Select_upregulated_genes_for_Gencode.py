#!/usr/bin/env python3

import sys

input_file = open(sys.argv[1],'r')
output_file = open(sys.argv[2],'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if data[0] == 'gr_id':
        print("\t".join(data[:4]),'No_infection_2h_RPKM','WT_2h_RPKM','FC(WT/No)','Status_2h','No_infection_6h_RPKM','WT_6h_RPKM','FC(WT/No)','Status_6h','No_infection_18h_RPKM','WT_18h_RPKM','FC(WT/No)','Status_18h',sep="\t",end="\n",file=output_file)
        continue
    infe_2h_no = float(data[4])
    infe_2h_wt = float(data[5])
    div_test_2h = '.'
    div_2h = '.'
    if infe_2h_no == 0:
        if infe_2h_wt < 1:
            pass
        else:
            div_test_2h = 'infection-sensitive'
    else:
        div_2h = infe_2h_wt/infe_2h_no
        if div_2h >= 2 and infe_2h_wt >= 1:
            div_test_2h = 'infection-sensitive'

    infe_6h_no = float(data[6])
    infe_6h_wt = float(data[7])
    div_test_6h = '.'
    div_6h = '.'
    if infe_6h_no == 0:
        if infe_6h_wt < 1:
            pass
        else:
            div_test_6h = 'infection-sensitive'
    else:
        div_6h = infe_6h_wt/infe_6h_no
        if div_6h >= 2 and infe_6h_wt >= 1:
            div_test_6h = 'infection-sensitive'

    infe_18h_no = float(data[8])
    infe_18h_wt = float(data[9])
    div_test_18h = '.'
    div_18h = '.'
    if infe_18h_no == 0:
        if infe_18h_wt < 1:
            pass
        else:
            div_test_18h = 'infection-sensitive'
    else:
        div_18h = infe_18h_wt/infe_18h_no
        if div_18h >= 2 and infe_18h_wt >= 1:
            div_test_18h = 'infection-sensitive'
    print("\t".join(data[:4]),infe_2h_no,infe_2h_wt,div_2h,div_test_2h,infe_6h_no,infe_6h_wt,div_6h,div_test_6h,infe_18h_no,infe_18h_wt,div_18h,div_test_18h, sep="\t", end="\n", file=output_file)
