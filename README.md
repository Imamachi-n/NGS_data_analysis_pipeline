# NGS_data_analysis_pipeline
Shell scripts for analyzing NGS data such as RNA-seq, smallRNA-seq, ChIP-seq, BRIC-seq, PAR-CLIP and ribosome profiling(Ribo-seq).
***
##Requisite
Fastqc  
Fastx-toolkits  
cutadapt  
PRINSEQ-lite  
Bowtie  
Bowtie2  
TotHat  
Cufflinks  
samtools  
Bedtools  
MACS14  

##Installation
At first, make 'software' directory for installing each software.
```
mkdir ~/software
```
***
- [Fastqc](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
```
wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip
unzip fastqc_v0.11.3.zip
cd FastQC
chmod 755 fastqc
pwd
#~/software/FastQC
echo 'PATH=~/software/FastQC:${PATH}' >> ~/.bashrc
```
***
- [Fastx-toolkits](http://hannonlab.cshl.edu/fastx_toolkit/)
```
wget http://hannonlab.cshl.edu/fastx_toolkit/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2
mkdir fastx_toolkit_0_0_13
mv fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2 fastx_toolkit_0_0_13
cd fastx_toolkit_0_0_13
tar jxvf fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2
cd bin
pwd
#~/software/fastx_toolkit_0_0_13/bin
echo 'PATH=~/software/fastx_toolkit_0_0_13/bin:${PATH}' >> ~/.bashrc
```
***
- [PRINSEQ-lite](http://sourceforge.net/projects/prinseq/files/standalone/)
```
tar zxvf prinseq-lite-0.20.4.tar.gz
cd prinseq-lite-0.20.4
chmod 755 prinseq-lite.pl
chmod 755 prinseq-graphs.pl
chmod 755 prinseq-graphs-noPCA.pl
pwd
#~/software/prinseq-lite-0.20.4
echo 'PATH=~/software/prinseq-lite-0.20.4:${PATH}' >> ~/.bashrc
```
***
- [cutadapt](https://pypi.python.org/pypi/cutadapt)
```
###python_settings###
#Make_directory
mkdir -p ~/software/python_path/lib/python2.7/site-packages/

#.bashrc setting
echo 'export PYTHONHOME=/usr/local' >> ~/.bashrc
echo 'export PYTHONPATH=~/software/python_path/lib/python2.7/site-packages' >> ~/.bashrc
echo 'export PATH=~/software/python_path/bin:${PYTHONHOME}/bin:${PATH}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=~/software/python_path/lib:${LD_LIBRARY_PATH}' >> ~/.bashrc

###cutadapt_installation###
wget https://pypi.python.org/packages/source/c/cutadapt/cutadapt-1.8.3.tar.gz#md5=c7384f3bb834375ad8b0a2869827be6f
tar zxvf cutadapt-1.8.3.tar.gz
cd cutadapt-1.8.3
python setup.py build
python setup.py install --prefix=~/software/python_path
```
***
- [Bowtie](http://bowtie-bio.sourceforge.net/index.shtml)
```
unzip bowtie-1.1.2-linux-x86_64.zip
cd bowtie-1.1.2
pwd
#~/software/bowtie-1.1.2
echo 'PATH=~/software/bowtie-1.1.2:${PATH}' >> ~/.bashrc
```
***
- [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
```
unzip bowtie2-2.2.6-linux-x86_64.zip
cd bowtie2-2.2.6
pwd
#~/software/bowtie2-2.2.6
echo 'PATH=~/software/bowtie2-2.2.6:${PATH}' >> ~/.bashrc
```
***
- [TopHat](https://ccb.jhu.edu/software/tophat/index.shtml)
```
wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz
tar zxvf tophat-2.1.0.Linux_x86_64.tar.gz
cd tophat-2.1.0.Linux_x86_64.tar.gz
pwd
#~/software/tophat-2.1.0.Linux_x86_64
echo 'PATH=~/software/tophat-2.1.0.Linux_x86_64:${PATH}' >> ~/.bashrc
```
***
- [Cufflinks](http://cole-trapnell-lab.github.io/cufflinks/)
```
wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
tar zxvf cufflinks-2.2.1.Linux_x86_64.tar.gz
cd cufflinks-2.2.1.Linux_x86_64.tar.gz
pwd
#~/software/cufflinks-2.2.1.Linux_x86_64.tar.gz
echo 'PATH=~/software/cufflinks-2.2.1.Linux_x86_64:${PATH}' >> ~/.bashrc
```
***
- [samtools](http://www.htslib.org/)
```
wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2
tar jxvf samtools-1.2.tar.bz2
make
pwd
#~/software/samtools-1.2
echo 'PATH=~/software/samtools-1.2:${PATH}' >> ~/.bashrc
```
***
- [Bedtools](https://github.com/arq5x/bedtools2/releases)
```
wget https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz
tar zxvf bedtools-2.25.0.tar.gz
cd bedtools2
make
cd bin
pwd
#~/software/bedtools2/bin
echo 'PATH=~/software/bedtools2/bin:${PATH}' >> ~/.bashrc
```
***
- [MACS14](http://liulab.dfci.harvard.edu/MACS/)
```
###python_settings###
#Make_directory
mkdir -p ~/software/python_path/lib/python2.7/site-packages/

#.bashrc setting
echo 'export PYTHONHOME=/usr/local' >> ~/.bashrc
echo 'export PYTHONPATH=~/software/python_path/lib/python2.7/site-packages' >> ~/.bashrc
echo 'export PATH=~/software/python_path/bin:${PYTHONHOME}/bin:${PATH}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=~/software/python_path/lib:${LD_LIBRARY_PATH}' >> ~/.bashrc

###MACS14_installation###
wget https://github.com/downloads/taoliu/MACS/MACS-1.4.2-1.tar.gz
cd MACS-1.4.2
python setup.py build
python setup.py install --prefix=~/software/python_path
```

