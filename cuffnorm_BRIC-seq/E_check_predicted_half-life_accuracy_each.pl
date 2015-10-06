#!/usr/local/bin/perl
#Title: Check predicted half-life accuracy
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2015-02-10

=pod
=cut

use warnings;
use strict;

my $input = $ARGV[0];
my $time_course = $ARGV[1]; #e.g.)0,1,1.5,2,3,4,5,6,8,10,12
my $cut_off = $ARGV[2]; #0.1
my @times = split/,/,$time_course;

#REF##############################
open(REF,"$input\_rel_normalized_cal_model_selection.fpkm_table") || die;

my %REF_HALF;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "gr_id"){next;}
	my $gr_id = $data[0];
	my $half = $data[3];
	$REF_HALF{$gr_id} = $half;
}

close(REF);

##################################
open(IN,"$input\.fpkm_table") || die;
open(OUT,">$input\_check.fpkm_table") || die;

OUTER: while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "gr_id"){
		print OUT "gr_id\tcheck\n";
		next;
	}
	my $gr_id = $data[0];
	my $half_life = $REF_HALF{$gr_id};
	if($half_life eq "NA"){
		print OUT "$gr_id\tNo\n";
		next OUTER;
	}
	my $length = @data;
	my $first_sample = 4;
	my $last_sample = $length - 1;
	my @rpkm = @data[$first_sample..$last_sample];
	my $time_point = @times;
	for(my $i=0; $i<@times; $i++){
		my $rpkm_each = $rpkm[$i];
		if($times[$i] < $half_life){
			if($rpkm_each < $cut_off){
				print OUT "$gr_id\tNo\n";
				next OUTER;
			}
			next;
		}
		if($rpkm_each < $cut_off){
			print OUT "$gr_id\tNo\n";
			next OUTER;
		}
		print OUT "$gr_id\tYes\n";
		next OUTER;
	}
	print OUT "$gr_id\tYes\n";
	next OUTER;
}

close(IN);
close(OUT);

