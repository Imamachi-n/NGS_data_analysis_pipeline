#!/usr/local/bin/perl
#Title: Normalize each time data
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2014-09-01

=pod
=cut

use warnings;
use strict;

my $input = $ARGV[0];

#MAIN####################################
my $r2;
my $half;
my $a_1;
my $a_2;
my $b_2;
my $a_3;
my $b_3;
my $c_3;

open (IN,"<$input\_rel_normalized_cal.fpkm_table") || die;
open (OUT,">$input\_rel_normalized_cal_model_selection.fpkm_table") || die;
select(OUT);

OUTER:while(my $line = <IN>){
	chomp $line;
	my @data = split /\t/,$line;
	if($data[0] eq "id"){
		print "gr_id\tmodel\tr2\thalf_life\n";
		next OUTER;
	}

	print "$data[0]\t";

	if($data[1] eq "ok"){

		my @AIC = (
		["model1",$data[7]],
		["model2",$data[13]],
		["model3",$data[20]],
		);
		@AIC = sort{@$a[1] <=> @$b[1]} @AIC;

		INNER:foreach(0..2){
			my $name = $AIC[$_][0];
			#Model1
			if($name eq "model1"){
				$a_1 = $data[4];
				$r2 =  $data[3];
				$half = $data[6];
			
				if($half > 24){
					$half = "24.0";
				}

				if($a_1 > 0){
					print "model1\t$r2\t$half\n";
					next OUTER;
				}else{
					next INNER;
				}
			#Model2
			}elsif($name eq "model2"){
				$a_2 = $data[10];
				$b_2 = $data[11];
				$r2 =  $data[9];
				$half = $data[12];
			
				if($half eq "Inf"){
					$half = "24.0";
				}elsif($half > 24){
					$half= "24.0";
				}

				if($a_2 > 0 && $b_2 > 0 && $b_2 < 1 ){
					print "model2\t$r2\t$half\n";
					next OUTER;
				}else{
					next INNER;
				}
			#Model3
			}elsif($name eq "model3"){
				$a_3 = $data[16];
				$b_3 = $data[17];
				$c_3 = $data[18];
				$r2 =  $data[15];
				$half = $data[19];
				
				if($half > 24){
					$half = "24.0";
				}
		    
				if($a_3 > 0 && $b_3 > 0 && $c_3 < 1 && $c_3 > 0){
					print "model3\t$r2\t$half\n";
					next OUTER;
				}else{
					next INNER;
				}
		    
			}else{
				next INNER;
			}
		}
		#The others => Model1
		$a_1 = $data[4];
		$r2 =  $data[3];
		$half = $data[6];
		if($a_1 < 0){
			print "model1\t$r2\t24\n";
			next OUTER;
		}else{
			print "no_good_model\t24\t\n";
			next OUTER;	
		}
	}else{
		print "$data[1]\tNA\tNA\n";
	}
}
    
close(IN);
close(OUT);
select(STDOUT);

print "Process were successfully finished\n";
