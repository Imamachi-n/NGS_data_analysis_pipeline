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
HTSeq(htseq-count)  
SRA Toolkit  
Trimmomatic  
PARalyzer  
cERMIT  
PhyloGibbs  
PhyloGibbs-MP  
STAR  
RiboTaper
RSEM

##Install
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
echo 'export PATH=~/software/FastQC:${PATH}' >> ~/.bashrc
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
echo 'export PATH=~/software/fastx_toolkit_0_0_13/bin:${PATH}' >> ~/.bashrc
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
echo 'export PATH=~/software/prinseq-lite-0.20.4:${PATH}' >> ~/.bashrc
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
echo 'export PATH=~/software/bowtie-1.1.2:${PATH}' >> ~/.bashrc
```
***
- [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
```
unzip bowtie2-2.2.6-linux-x86_64.zip
cd bowtie2-2.2.6
pwd
#~/software/bowtie2-2.2.6
echo 'export PATH=~/software/bowtie2-2.2.6:${PATH}' >> ~/.bashrc
```
***
- [TopHat](https://ccb.jhu.edu/software/tophat/index.shtml)
```
wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz
tar zxvf tophat-2.1.0.Linux_x86_64.tar.gz
cd tophat-2.1.0.Linux_x86_64
pwd
#~/software/tophat-2.1.0.Linux_x86_64
echo 'export PATH=~/software/tophat-2.1.0.Linux_x86_64:${PATH}' >> ~/.bashrc
```
***
- [Cufflinks](http://cole-trapnell-lab.github.io/cufflinks/)
```
wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
tar zxvf cufflinks-2.2.1.Linux_x86_64.tar.gz
cd cufflinks-2.2.1.Linux_x86_64
pwd
#~/software/cufflinks-2.2.1.Linux_x86_64.tar.gz
echo 'export PATH=~/software/cufflinks-2.2.1.Linux_x86_64:${PATH}' >> ~/.bashrc
```
***
- [samtools](http://www.htslib.org/)
```
wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2
tar jxvf samtools-1.2.tar.bz2
cd samtools-1.2
make
pwd
#~/software/samtools-1.2
echo 'export PATH=~/software/samtools-1.2:${PATH}' >> ~/.bashrc
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
echo 'export PATH=~/software/bedtools2/bin:${PATH}' >> ~/.bashrc
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
tar zxvf MACS-1.4.2-1.tar.gz
cd MACS-1.4.2
python setup.py build
python setup.py install --prefix=~/software/python_path
```
***
- [HTSeq(htseq-count)](http://www-huber.embl.de/users/anders/HTSeq/doc/count.html)
```
###python_settings###
#Make_directory
mkdir -p ~/software/python_path/lib/python2.7/site-packages/

#.bashrc setting
echo 'export PYTHONHOME=/usr/local' >> ~/.bashrc
echo 'export PYTHONPATH=~/software/python_path/lib/python2.7/site-packages' >> ~/.bashrc
echo 'export PATH=~/software/python_path/bin:${PYTHONHOME}/bin:${PATH}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=~/software/python_path/lib:${LD_LIBRARY_PATH}' >> ~/.bashrc

###HTSeq_installation###
wget https://pypi.python.org/packages/source/H/HTSeq/HTSeq-0.6.1.tar.gz#md5=b7f4f38a9f4278b9b7f948d1efbc1f05
tar zxvf HTSeq-0.6.1.tar.gz
cd HTSeq-0.6.1
python setup.py build
python setup.py install --prefix=~/software/python_path

###PySam_installation###
pip install --install-option="--prefix=~/software/python_path" PySam
```
***
- [SRA Toolkit](https://github.com/ncbi/sra-tools/wiki/Downloads)
```
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.5.5/sratoolkit.2.5.5-centos_linux64.tar.gz
tar zxvf sratoolkit.2.5.5-centos_linux64.tar.gz
cd sratoolkit.2.5.5-centos_linux64/bin
pwd
#~/software/sratoolkit.2.5.5-centos_linux64/bin
echo 'export PATH=~/software/sratoolkit.2.5.5-centos_linux64/bin:${PATH}' >> ~/.bashrc
```
***
- [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
```
wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.35.zip
unzip Trimmomatic-0.35.zip
cd Trimmomatic-0.35

###Shell script preparation###
cat prep_file.sh
#!/bin/bash
java -jar "$0" "$@"
exit $?

###Make easy-to-use trimmomatic command###
cat prep_file.sh trimmomatic-0.35.jar > trimmomatic_core
chmod 755 trimmomatic_core
pwd
#~/software/Trimmomatic-0.35
echo 'export PATH=~/software/Trimmomatic-0.35:${PATH}' >> ~/.bashrc
```
***
- [PARalyzer](https://ohlerlab.mdc-berlin.de/software/PARalyzer_85/)
```
wget https://ohlerlab.mdc-berlin.de/files/duke/PARalyzer/PARalyzer_v1_1_executable.tgz
tar zxvf PARalyzer_v1_1_executable.tgz
cd PARalyzer_v1_1
chmod 755 PARalyzer
pwd
#~/software/PARalyzer_v1_1
echo 'export PATH=~/software/PARalyzer_v1_1:${PATH}' >> ~/.bashrc
```
***
- [cERMIT](https://ohlerlab.mdc-berlin.de/software/cERMIT_82/)
```
wget https://ohlerlab.mdc-berlin.de/files/duke/transcription/cERMIT/Georgiev_2009_executable_with_sample_datasets_v1.01.tar.gz
mkdir cERMIT_v1_0
mv Georgiev_2009_executable_with_sample_datasets_v1.01.tar.gz cERMIT_v1_0
tar zxvf Georgiev_2009_executable_with_sample_datasets_v1.01.tar.gz
pwd
#~/software/cERMIT_v1_0
echo 'export PATH=~/software/cERMIT_v1_0:${PATH}' >> ~/.bashrc
```
***
- [PhyloGibbs](https://www.imsc.res.in/~rsidd/phylogibbs/)
```
wget https://www.imsc.res.in/~rsidd/phylogibbs/linux-static/phylogibbs
chmod 755 phylogibbs
```
***
- [PhyloGibbs-MP](https://www.imsc.res.in/~rsidd/phylogibbs-mp/)
```
wget https://www.imsc.res.in/~rsidd/phylogibbs-mp/linux64/phylogibbs-mp-2.0-linux64.tar.gz
tar zxvf phylogibbs-mp-2.0-linux64.tar.gz
cd phylogibbs-mp-2.0-linux64/program
pwd
#~/software/phylogibbs-mp-2.0-linux64/program
echo 'export PATH=~/software/phylogibbs-mp-2.0-linux64/program:${PATH}' >> ~/.bashrc
```
***
- [STAR](https://github.com/alexdobin/STAR)
```
git clone https://github.com/alexdobin/STAR.git
cd STAR/bin/Linux_x86_64_static
pwd
#~/software/STAR/bin/Linux_x86_64_static
echo 'export PATH=~/software/STAR/bin/Linux_x86_64_static:${PATH}' >> ~/.bashrc
```
***
- [RiboTaper](https://ohlerlab.mdc-berlin.de/software/RiboTaper_126/)
```
wget https://ohlerlab.mdc-berlin.de/files/RiboTaper/RiboTaper_v1.3.tar.gz
tar zxvf RiboTaper_v1.3.tar.gz
mv Version_1.3 RiboTaper_v1.3
cd RiboTaper_v1.3/scripts
pwd
#~/software/RiboTaper_v1.3/scripts
echo 'export PATH=~/software/RiboTaper_v1.3/scripts:${PATH}' >> ~/.bashrc
```
***
- [RSEM](http://deweylab.github.io/RSEM/)
```
wget https://github.com/deweylab/RSEM/archive/v1.2.29.tar.gz
tar zxvf v1.2.29.tar.gz
cd RSEM-1.2.29/
mkdir bin
make
make ebseq
make install DESTDIR=/home/akimitsu/software/RSEM-1.2.29 prefix=/bin
cd bin
pwd
#~/software/RSEM-1.2.29/bin/bin
echo 'export PATH=~/software/RSEM-1.2.29/bin/bin:${PATH}' >> ~/.bashrc
```
