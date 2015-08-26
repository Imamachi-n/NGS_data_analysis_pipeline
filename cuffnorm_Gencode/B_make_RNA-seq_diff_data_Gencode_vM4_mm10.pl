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
open(REF, "</home/akimitsu/custom_command/cuffnorm_Gencode/mRNA_lncRNA_list_gencode_vM4_mm10.txt") || die;

my %ref_list;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	my $gene_id = $data[0];
	my $trx_id = $data[3];
	my $type = $data[1];
	my $name = $data[4];
	$ref_list{$gene_id}{'trx_id'} = $trx_id;
	$ref_list{$gene_id}{'type'} = $type;
	$ref_list{$gene_id}{'name'} = $name;
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
open(OUT_mRNA,">$input/genes_Gencode_vM4_result_mRNA.fpkm_table") || die;
open(OUT_ncRNA,">$input/genes_Gencode_vM4_result_ncRNA.fpkm_table") || die;

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
	unless(defined($ref_list{$gene_id}{'trx_id'})){next;}
	my $trx_id = $ref_list{$gene_id}{'trx_id'};
	my $gene_name = $ref_list{$gene_id}{'name'};
	my $type = $ref_list{$gene_id}{'type'};
	my $locus = $REF_ATTR{$gene_id};
	#print "$type\n";
	if($type eq "mRNA"){
		print OUT_mRNA "$gr_id_mRNA\t$gene_name\t$trx_id\t$locus\t",join("\t",@result),"\n";
		$gr_id_mRNA++;
	}elsif($type eq "ncRNA"){
		print OUT_ncRNA "$gr_id_ncRNA\t$gene_name\t$trx_id\t$locus\t",join("\t",@result),"\n";
		$gr_id_ncRNA++;
	}
}

close(IN);
close(OUT_ncRNA);
close(OUT_mRNA);
