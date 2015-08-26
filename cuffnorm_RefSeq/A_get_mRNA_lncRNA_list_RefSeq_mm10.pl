#!/usr/local/bin/perl
#Title: Get mRNA lncRNA list
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2014-08-27

=pod
=cut

use warnings;
use strict;

#my $input = $ARGV[0];
#my $output = $ARGV[1];

################################
open(IN,"</home/akimitsu/Refseq_gene_mm10_May_23_2014.gtf") || die;
open(OUT,">/home/akimitsu/custom_command/cuffnorm_RefSeq/mRNA_lncRNA_list_RefSeq_mm10.txt") || die;

my %ref_data;
my @ref_gene_list;

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my @data_col = split/; /,$data[8];
	my @gene_data = grep(/gene_id/,@data_col);
	my $gene_id = $gene_data[0];
	$gene_id =~ s/gene_id "//;
	$gene_id =~ s/"//;
	my @trx_data = grep(/transcript_id/,@data_col);
	my $trx_id = $trx_data[0];
	$trx_id =~ s/transcript_id "//;
	$trx_id =~ s/"//;
	push(@ref_gene_list,$gene_id);
	push(@{$ref_data{$gene_id}},$trx_id);	
}

my %count;
@ref_gene_list = grep(!$count{$_}++,@ref_gene_list);

foreach(@ref_gene_list){
	my @id_list = @{$ref_data{$_}};
	my %count;
	@id_list = grep(!$count{$_}++,@id_list);
	#print "@id_list\n";
	if(grep(/NM/,@id_list)){
		print OUT "$_\tmRNA\t";
		print OUT join(",",@id_list),"\n";
	}else{
		print OUT "$_\tncRNA\t";
		print OUT join(",",@id_list),"\n";
	}
}

close(IN);
close(OUT);
