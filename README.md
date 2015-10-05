# NGS_data_analysis_pipeline
###Shell scripts for analyzing NGS data such as RNA-seq, smallRNA-seq, ChIP-seq, BRIC-seq, PAR-CLIP and ribosome profiling(Ribo-seq).
***
##Requisite
Fastqc
Fastx-toolkits
cutadapt
PRINSEQ-lite
Bowtie
Bowtie2
HotHat
Cufflinks
samtools
bedtools

##Installation
- [Fastqc](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
```
wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip
unzip fastqc_v0.11.3.zip
cd FastQC
chmod 755 fastqc
pwd
#/home/akimitsu/software/FastQC
echo 'PATH=/home/akimitsu/software/FastQC:${PATH}' >> ~/.bashrc
```
