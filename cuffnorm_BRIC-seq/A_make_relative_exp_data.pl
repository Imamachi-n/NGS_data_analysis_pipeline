#!/usr/local/bin/perl
#$ -S /usr/local/bin/perl
#$ -cwd
#Title: Make relative exp. data
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2014-08-29

=pod
=cut

use warnings;
use strict;

my $input = $ARGV[0];
my $cutoff = 0.1;
my @list=(
"mRNA",
"ncRNA"
);

##################################
foreach my $filename(@list){
open(IN,"$input\_$filename\.fpkm_table") || die;
open(OUT,">$input\_$filename\_rel.fpkm_table") || die;

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "gr_id"){
		print OUT "$line\n";
		next;
	}
	my @infor = @data[0..3];
	print OUT join("\t",@infor);
	my $num_col = @data;
	my $num_sample = $num_col - 4;
	my $first;
	for(my $i=0; $i<$num_sample; $i++){
		if($i == 0){
			$first = $data[4+$i];
			unless($first > $cutoff){ #Default: 0.001rpkm
				print OUT "\t0";
				next;
			}
			print OUT "\t1";
		}else{
			unless($first > $cutoff){ #Default: 0.001rpkm
				print OUT "\t0";
				next;
			}
			my $dat = $data[4+$i]/$first;
			print OUT "\t$dat";
		}
	}
	print OUT "\n";
}

close(IN);
close(OUT);
}
