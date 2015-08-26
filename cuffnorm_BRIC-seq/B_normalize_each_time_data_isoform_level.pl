#!/usr/local/bin/perl
#Title: Normalize each time data
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2014-08-29

=pod
=cut

use warnings;
use strict;

my $input = $ARGV[0];
my $file = $ARGV[1];
my @list=(
"mRNA",
"ncRNA"
);

#House-keeping_genes_for_normalization#####
my @gene_list =("ALDOA","ATP5B","ENO1","GAPDH","PGK1","PPIA");
my $gene_list_length = @gene_list;
my %check_list;
foreach(@gene_list){
	$check_list{$_} = 1;
}

#REF#############################
open(REF,"<$input/genes_$file\_mRNA_rel.fpkm_table") || die;

my @exp_list;
my $sample_num;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	unless(defined($check_list{$data[1]})){next;}
	my $data_length = @data;
	$sample_num = $data_length - 4;
	my $data_size = $data_length - 1;
	push(@exp_list,@data[4..$data_size]);
}
my @norm_list;
for(my $i=0; $i<$sample_num; $i++){
	my $counter = 0;
	my $exp = 1;
	foreach(@gene_list){
		my $k = $i+($counter*$sample_num);
		$exp *= $exp_list[$k];
		$counter++;
	}
	my $div_exp = $exp**(1/$gene_list_length);
	push(@norm_list,$div_exp);
}
	print "@norm_list\n";
close(REF);

#MAIN############################
foreach my $filename(@list){
open(IN,"<$input/isoforms_$file\_$filename\_rel.fpkm_table") || die;
open(OUT,">$input/isoforms_$file\_$filename\_rel_normalized.fpkm_table") || die;

while(my $line = <IN>){
		chomp $line;
		my @data = split/\t/,$line;
		if($data[0] eq "gr_id"){
			print OUT "$line\n";
			next;
		}
		my $data_size = @data;
		my $sample_num = $data_size - 4;
		print OUT join("\t",@data[0..3]);
		if($data[4] == 0){
			for(my $i=0; $i<$sample_num; $i++){
				print OUT "\t0";
			}
			print OUT "\n"; 
			next;
		}
		for(my $i=0; $i<$sample_num; $i++){
			my $exp = $data[4+$i]/$norm_list[$i];
			print OUT "\t$exp";
		}
		print OUT "\n";
}

close(IN);
close(OUT);
}
