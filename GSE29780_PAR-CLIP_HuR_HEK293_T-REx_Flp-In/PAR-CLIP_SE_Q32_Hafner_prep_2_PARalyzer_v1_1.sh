#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16
##--RAW_data_analysis--
#./PARalyzer Sample.ini
./PARalyzer Sample_HuR.ini
