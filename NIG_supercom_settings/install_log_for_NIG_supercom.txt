###Fastqc###
wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip
unzip fastqc_v0.11.3.zip
cd FastQC
chmod 755 fastqc
pwd
#/home/akimitsu/software/FastQC
echo 'PATH=/home/akimitsu/software/FastQC:${PATH}' >> ~/.bashrc

###Fastx-toolkits###
wget http://hannonlab.cshl.edu/fastx_toolkit/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2
mkdir fastx_toolkit_0_0_13
mv fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2 fastx_toolkit_0_0_13
cd fastx_toolkit_0_0_13
tar jxvf fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2
cd bin
pwd
#/home/akimitsu/software/fastx_toolkit_0_0_13/bin
echo 'PATH=/home/akimitsu/software/fastx_toolkit_0_0_13/bin:${PATH}' >> ~/.bashrc

###PRINSEQ-lite###
tar zxvf prinseq-lite-0.20.4.tar.gz
cd prinseq-lite-0.20.4
chmod 755 prinseq-lite.pl
chmod 755 prinseq-graphs.pl
chmod 755 prinseq-graphs-noPCA.pl
pwd
#/home/akimitsu/software/prinseq-lite-0.20.4
echo 'PATH=/home/akimitsu/software/prinseq-lite-0.20.4:${PATH}' >> ~/.bashrc

###Cutadapt###
wget https://pypi.python.org/packages/source/c/cutadapt/cutadapt-1.8.3.tar.gz#md5=c7384f3bb834375ad8b0a2869827be6f
tar zxvf cutadapt-1.8.3.tar.gz
cd cutadapt-1.8.3
python setup.py build
python setup.py install --prefix=~/software/python_path

###Bowtie###
unzip bowtie-1.1.2-linux-x86_64.zip
cd bowtie-1.1.2
pwd
#/home/akimitsu/software/bowtie-1.1.2
echo 'PATH=/home/akimitsu/software/bowtie-1.1.2:${PATH}' >> ~/.bashrc

###Bowtie2###
unzip bowtie2-2.2.6-linux-x86_64.zip
cd bowtie2-2.2.6
pwd
#/home/akimitsu/software/bowtie2-2.2.6
echo 'PATH=/home/akimitsu/software/bowtie2-2.2.6:${PATH}' >> ~/.bashrc

###TopHat###
wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz
tar zxvf tophat-2.1.0.Linux_x86_64.tar.gz
cd tophat-2.1.0.Linux_x86_64.tar.gz
pwd
#/home/akimitsu/software/tophat-2.1.0.Linux_x86_64
echo 'PATH=/home/akimitsu/software/tophat-2.1.0.Linux_x86_64:${PATH}' >> ~/.bashrc

###Cufflinks###
wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
tar zxvf cufflinks-2.2.1.Linux_x86_64.tar.gz
cd cufflinks-2.2.1.Linux_x86_64.tar.gz
pwd
#/home/akimitsu/software/cufflinks-2.2.1.Linux_x86_64.tar.gz
echo 'PATH=/home/akimitsu/software/cufflinks-2.2.1.Linux_x86_64:${PATH}' >> ~/.bashrc

###Samtools###
wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2
tar jxvf samtools-1.2.tar.bz2
make
pwd
#/home/akimitsu/software/samtools-1.2
echo 'PATH=/home/akimitsu/software/samtools-1.2:${PATH}' >> ~/.bashrc

###Bedtools###
wget https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz
tar zxvf bedtools-2.25.0.tar.gz
cd bedtools2
make
cd bin
pwd
#/home/akimitsu/software/bedtools2/bin
echo 'PATH=/home/akimitsu/software/bedtools2/bin:${PATH}' >> ~/.bashrc
