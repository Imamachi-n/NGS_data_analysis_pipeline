#!/usr/local/bin/perl
#Title: make_RNA-seq_diff
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2014-08-28

=pod
=cut

use warnings;
use strict;

my $input = $ARGV[0];

#REF#################################
open(REF, "</home/akimitsu/custom_command/cuffnorm_RefSeq/mRNA_lncRNA_list_RefSeq_hg19_June_02_2014.txt") || die;

my %REF_GENE_INFOR;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	my $gene_id = $data[0];
	my $trx_id = $data[2];
	my $type = $data[1];
	$REF_GENE_INFOR{$gene_id}{'trx_id'} = $trx_id;
	$REF_GENE_INFOR{$gene_id}{'type'} = $type;
}

close(REF);

#REF#################################
open(REF, "<$input/samples.table") || die;

my @REF_SAMPLE;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "sample_id"){next;}
	my $name = $data[1];
	$name =~ s/\.\/cuffquant_out_//;
	$name =~ s/\/abundances.cxb//;
	push(@REF_SAMPLE,$name);
}

close(REF);

#REF#################################
open(REF, "<$input/genes.attr_table") || die;

my %REF_ATTR;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "tracking_id"){next;}
	my $symbol = $data[0];
	my $locus = $data[6];
	$REF_ATTR{$symbol} = $locus;
}

close(REF);

#MAIN################################
open(IN,"<$input/genes.fpkm_table") || die;
open(OUT_mRNA,">$input/genes_RefSeq_result_mRNA.fpkm_table") || die;
open(OUT_ncRNA,">$input/genes_RefSeq_result_ncRNA.fpkm_table") || die;

my $gr_id_mRNA = 1;
my $gr_id_ncRNA = 1;

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "tracking_id"){
		print OUT_mRNA "gr_id\tsymbol\taccession_id\tlocus\t",join("\t",@REF_SAMPLE),"\n";
		print OUT_ncRNA "gr_id\tsymbol\taccession_id\tlocus\t",join("\t",@REF_SAMPLE),"\n";
		next;
	}
	my $gene_id = shift(@data);
	my @result = @data;
	my $trx_id = $REF_GENE_INFOR{$gene_id}{'trx_id'};
	my $type = $REF_GENE_INFOR{$gene_id}{'type'};
	my $locus = $REF_ATTR{$gene_id};
	#print "$type\n";
	if($type eq "mRNA"){
		print OUT_mRNA "$gr_id_mRNA\t$gene_id\t$trx_id\t$locus\t",join("\t",@result),"\n";
		$gr_id_mRNA++;
	}elsif($type eq "ncRNA"){
		if($gene_id =~ /MIR/ || $gene_id =~ /SNOR/){next;}
		print OUT_ncRNA "$gr_id_ncRNA\t$gene_id\t$trx_id\t$locus\t",join("\t",@result),"\n";
		$gr_id_ncRNA++;
	}
}

close(IN);
close(OUT_ncRNA);
close(OUT_mRNA);
