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
open(IN,"</home/akimitsu/gencode.vM4.annotation.gtf") || die;
open(OUT,">./mRNA_lncRNA_list_gencode_vM4_mm10.txt") || die;

my %REF_ID;
my @ref_gene_list;

while(my $line = <IN>){
	chomp $line;
	if($line =~ /^#/){next;}
	my @data = split/\t/,$line;
	my $transcript = $data[2];
	unless($transcript eq "transcript"){next;}
	my @data_col = split/; /,$data[8];
	
	#Gene_id
	my @gene_data = grep(/gene_id/,@data_col);
	my $gene_id = $gene_data[0];
	$gene_id =~ s/gene_id "//;
	$gene_id =~ s/"//;
	
	#Trx_id
	my @trx_data = grep(/transcript_id/,@data_col);
	my $trx_id = $trx_data[0];
	$trx_id =~ s/transcript_id "//;
	$trx_id =~ s/"//;
	
	#Gene_name
	my @name_data = grep(/gene_name/,@data_col);
	my $name_id = $name_data[0];
	$name_id =~ s/gene_name "//;
	$name_id =~ s/"//;
	
	#Gene_type
	my @type_data = grep(/gene_type/,@data_col);
	my $type = $type_data[0];
	$type =~ s/gene_type "//;
	$type =~ s/"//;
	if($type eq "miRNA" || $type eq "Mt_rRNA" || $type eq "Mt_tRNA" || $type eq "rRNA" || $type eq "snoRNA" || $type eq "snRNA"){next;}
	
	push(@ref_gene_list,$gene_id);
	push(@{$REF_ID{$gene_id}{'trx_id'}},$trx_id);
	$REF_ID{$gene_id}{'name'} = $name_id;
	$REF_ID{$gene_id}{'type'} = $type; #protein_coding or not.
}

my %count;
@ref_gene_list = grep(!$count{$_}++,@ref_gene_list);

foreach(@ref_gene_list){
	my $gene_id = $_;
	my $type = $REF_ID{$_}{'type'};
	my @trx_id = @{$REF_ID{$_}{'trx_id'}};
	my $name = $REF_ID{$_}{'name'};
	if($type eq "protein_coding"){
		print OUT "$gene_id\tmRNA\t$type\t",join(",",@trx_id),"\t$name\n";
	}else{
		print OUT "$gene_id\tncRNA\t$type\t",join(",",@trx_id),"\t$name\n";
	}
}

close(IN);
close(OUT);
