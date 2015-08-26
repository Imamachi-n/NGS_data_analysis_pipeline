#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=2G
#$ -l mem_req=2
for dir in $@
do
    ~/custom_command/cuffnorm_RefSeq/B_make_RNA-seq_diff_data_RefSeq_hg19.pl ${dir}
    VALUE_TIME='0,1,1.5,2,3,4,5,6,8,10,12'
    ~/custom_command/cuffnorm_BRIC-seq/A_make_relative_exp_data.pl ${dir}/genes_RefSeq_result 0.1
    ~/custom_command/cuffnorm_BRIC-seq/B_normalize_each_time_data.pl ${dir}/genes_RefSeq_result
    #Rscript ~/custom_command/cuffnorm_BRIC-seq/C_fitting_decay_curve_6time.r ${dir}/genes_RefSeq_result_mRNA ${VALUE_TIME}
    Rscript ~/custom_command/cuffnorm_BRIC-seq/C_fitting_decay_curve_6time.r ${dir}/genes_RefSeq_result_ncRNA ${VALUE_TIME} #0,1,1.5,2,3,4,5,6,8,10,12
    ~/custom_command/cuffnorm_BRIC-seq/D_model_selection.pl ${dir}/genes_RefSeq_result
    ~/custom_command/cuffnorm_BRIC-seq/E_check_predicted_half-life_accuracy.pl ${dir}/genes_RefSeq_result ${VALUE_TIME} 1
done
