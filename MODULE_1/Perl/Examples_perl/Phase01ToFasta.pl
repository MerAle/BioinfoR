#!/usr/bin/perl


# Author: Carla Giner Delgado
# Date: 2013.03.28
# Description: Conversion of Phase output summary file to multi fasta file, with one sequence per chromosome (2*individuals sequences).

# Test command line:
# perl Scripts/Phase01ToFasta.pl -i phase209.out -r HsInv209/HsInv209_REF_11_71282866_71287771.fasta -v HsInv209/25CEU/Diverg/Het/filtered_11.71282866-71287771.ALL.chr11.phase1_release_v3.20101123.snps_indels_svs.genotypes.vcf -s 71282866



use warnings;
use strict;
use Getopt::Long;


my $help = undef;
my $input;
my $phasein;
my $ref;
my $add = 0;
my $vcf;
my $init;
my $width = "100";
my $output = "sequences.fasta";

Usage() if ( @ARGV < 4 or
	!GetOptions(
		"help|?" => \$help,
	    "input=s" => \$input,
	    "positions=s" =>\$phasein,
	    "reference=s" => \$ref,
	    "add-reference" => \$add,
	    "vcf=s" => \$vcf,
	    "start-position=i" => \$init,
	    "width:i" => \$width,
	    "output:s" => \$output)
	or defined $help);

sub Usage{
	print "\nUsage:\tPhase01ToFasta.pl --input <Phase output> --positions <Phase input> --reference <reference.fasta> --vcf <vcf file> --start-position <INT> [--add-reference --width <INT> --output <OUTPUTFILE>]\n\n";
	print "OPTIONS:\n\t--input\t\t\tPhase output summary file.\n";
	print "\t--positions\t\tPhase input file (to know the positions in the rigth format (and not in scientific notation!).\n";
	print "\t--reference\t\tReference sequence in fasta format.\n";
	print "\t--add-reference\tFlag option to include reference sequence to the end of the fasta file.\n";
	print "\t--vcf\t\t\tOriginal vcf file with the REF and ALT variants for each position.\n";
	print "\t--start-position\tInitial position in reference sequence.\n";
	print "\t--width\t\t\tNumber of bases per line in the fasta output. Default value 100.\n";
	print "\t--output\t\tName for the output fasta file. Default name \"sequences.fasta\".\n";
	exit;
}

my $lineref = 0; #line/position counter.

# FILE OPENING AND PROCESSING #
###############################
# REFERENCE FASTA SEQUENCE
# ------------------------
open ( my $inref_fh, "<", "$ref" ) or die "Could not open $ref: $!";

my $sequence;
my $refname = <$inref_fh>;
while ($lineref = <$inref_fh>) {
	chomp $lineref;
	$sequence .= $lineref;
}
my @refseq = split("",$sequence);

# print "@refseq\n";
close $inref_fh;


# VARIANTS FOR EACH POSITION
# --------------------------
open ( my $invcf_fh, "<", "$vcf" ) or die "Could not open $vcf: $!";
my %variants; # Store the REF and ALT alleles for each SNP. Hash of arrays! Key: positions; Value: array with variants [0] ref [1] first alt
while (my $vcf_line = <$invcf_fh>){
	next if ($vcf_line =~ /^#/);
	my @entry = split("\t",$vcf_line);
	my @alt = split(",",$entry[ 4 ]);
	my @alleles = ( $entry[ 3 ], @alt );
	$variants{ $entry[ 1 ] } = \@alleles;
}
close $invcf_fh;

foreach my $key (keys %variants) {
	print "$key => @{$variants{ $key }}\n";
}


# SNP POSITIONS (From Phase input file)
open ( my $pha_fh, "<", "$phasein" ) or die "Could not open $phasein: $!";
my @positions;
my @snps_ref; # To store position of interesting snps for reconstructing sequences.
while (my $line = <$pha_fh>) {
	if ($line =~ /^P\s([\d,\s]+)/) {
		@positions = split(" ", $1 );
		print "Positions: @positions\n";

		for ( my $k = 0; $k < scalar @positions; $k++ ) { # Store only desired SNPS
			# print "$positions[ $k ]\n";
			my $pos = $positions[ $k ];
			# print "@{$variants{$pos}}\n";
			if ( $variants{ $pos }) {
				push @snps_ref,$k;
			}
		}
		print "Ref positions: @snps_ref\n";
	}
}

close $pha_fh;

# SEQUENCES
# ---------
open ( my $in_fh, "<", "$input" ) or die "Could not open $input: $!";
open ( my $out_fh, ">", "$output" ) or die "Could not open $output: $!";

my ( $individuals, $loci );
my $bestpairs = 0;

LINE: while (my $line = <$in_fh>){
	# SUMMARY AND SELECT DESIRED POSITIONS
	if ($line =~ /BEGIN INPUT_SUMMARY/) {
		$line = <$in_fh>;
		$line =~ /Number of Individuals: (\d+)/;
		$individuals = $1;
		$line = <$in_fh>;
		$line =~ /Number of Loci: (\d+)/;
		$loci = $1;

		# ----------------------------------- LOG -------------------------------------------
		print "\nPhase output to fasta converter\n---------------------------------\n";
		printf "\nReference sequence length:\t%d\n", $#refseq+1;
		printf "\nNumber of individuals:\t%d\nNumber of sequences:\t%d\nNumber of polymorphic sites in phase:\t%d\n\n", $individuals, $individuals*2, $loci;
		# -----------------------------------------------------------------------------------
	}
	# RECONSTUCT SEQUENCES
	$bestpairs = 1 if ($line =~ /BEGIN BESTPAIRS1/); # Haplotypes PART!!
	$bestpairs = 0 if ($line =~ /END BESTPAIRS1/);
	
	if ($bestpairs and $line =~ /[0|1]? #(\w+)/){ # One individual
		my $indiv_name = $1;
		# FIRST HAPLOTYPE +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		$line = <$in_fh>;
		
		my @snps = split(" ", join(" ", split(/\s|\(|\)|\[|\]/, $line ))); # Remove parenthesis and extra spaces
		my $position = $init;
		my $ref_base = 0;
		my $count = 0; # to count bases/line
		print $out_fh ">$indiv_name"."_1\n";

		foreach my $i (@snps_ref) {
			my $base = $snps[ $i ];
			# print $base;
			my ( $insertion, $deletion ) = ( 0, 0 );
			# DELETION
			$deletion = 1 if (length($variants{$positions[$i]}[0]) > 1);
			# INSERTION
			$insertion = 1 if (length($variants{$positions[$i]}[1]) > 1);

			# BEFORE SNP position
			while ($position < $positions[ $i ]) { # Position lower than SNP position

				print $out_fh "$refseq[ $ref_base ]";
				$ref_base++;
				$position++;
				$count++;
				if ($count == $width) {
					$count = 0;
					print $out_fh "\n";
				}
			}
			# SNP position
			$count += length($variants{$positions[$i]}[0]) if ($deletion);
			$count += length($variants{$positions[$i]}[1]) if ($insertion);
			$count ++ if (!$deletion and !$insertion);
			if ($base == 0) {
				print $out_fh "$variants{$positions[$i]}[0]";
				if ($insertion) {
					for (my $l = 0; $l < length($variants{$positions[$i]}[1])-length($variants{$positions[$i]}[0]); $l++) {
						print $out_fh "-";
					}
				}
			} elsif ($base == 1) {
				if ($variants{$positions[$i]}[1] eq "."){
					print $out_fh "$variants{$positions[$i]}[0]";
				} else {
					print $out_fh "$variants{$positions[$i]}[1]";
					if ($deletion) {
						for (my $l = 0; $l < length($variants{$positions[$i]}[0])-length($variants{$positions[$i]}[1]); $l++) {
							print $out_fh "-";
						}
					}
				}
			} else {
				print "ERROR: \"$base\" is not 0 or 1!\n";
				exit;
			}
			$ref_base += length($variants{$positions[$i]}[0]);
			$position += length($variants{$positions[$i]}[0]);
			if ($count >= $width) {
				$count = 0;
				print $out_fh "\n";
			}
		}
		# When the last SNP is printed, the tail of the reference sequence
		for (my $j = $position; $j <= $init+$#refseq; $j++) {
			print $out_fh $refseq[ $ref_base ];
			$ref_base++;
			$count++;
			if ($count == $width) {
				$count = 0;
				print $out_fh "\n";
			}
		}
		print $out_fh "\n\n";


		# # SECOND HAPLOTYPE+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		$line = <$in_fh>;
		
		@snps = split(" ", join(" ", split(/\s|\(|\)|\[|\]/, $line )));
		$position = $init;
		$ref_base = 0;
		$count = 0; # to count bases/line
		next LINE if ($snps[0] == 2);
		print $out_fh ">$indiv_name"."_2\n";

		foreach my $i (@snps_ref) {
			my $base = $snps[ $i ];
			my ( $insertion, $deletion ) = ( 0, 0 );
			# DELETION
			$deletion = 1 if (length($variants{$positions[$i]}[0]) > 1);
			# INSERTION
			$insertion = 1 if (length($variants{$positions[$i]}[1]) > 1);

			# BEFORE SNP position
			while ($position < $positions[ $i ]) { # Position lower than SNP position
				print $out_fh "$refseq[ $ref_base ]";
				$ref_base++;
				$position++;
				$count++;
				if ($count == $width) {
					$count = 0;
					print $out_fh "\n";
				}
			}
			# SNP position
			$count += length($variants{$positions[$i]}[0]) if ($deletion);
			$count += length($variants{$positions[$i]}[1]) if ($insertion);
			$count ++ if (!$deletion and !$insertion);

			if ($base == 0) {
				print $out_fh "$variants{$positions[$i]}[0]";
				if ($insertion) { # If insertion, when reference allele
					for (my $l = 0; $l < length($variants{$positions[$i]}[1])-length($variants{$positions[$i]}[0]); $l++) {
						print $out_fh "-";
					}
				}
			} elsif ($base == 1) {
				if ($variants{$positions[$i]}[1] eq "."){
					print $out_fh "$variants{$positions[$i]}[0]";
				} else {
					print $out_fh "$variants{$positions[$i]}[1]";
					if ($deletion) {
						for (my $l = 0; $l < length($variants{$positions[$i]}[0])-length($variants{$positions[$i]}[1]); $l++) {
							print $out_fh "-";
						}
					}
				}
			} else {
				print "ERROR: \"$base\" is not 0 or 1!\n";
				exit;
			}
			$ref_base += length($variants{$positions[$i]}[0]);
			$position += length($variants{$positions[$i]}[0]);
			if ($count >= $width) {
				$count = 0;
				print $out_fh "\n";
			}
		}
		# When the last SNP is printed, the tail of the reference sequence
		for (my $j = $position; $j <= $init+$#refseq; $j++) {
			print $out_fh $refseq[ $ref_base ];
			$ref_base++;
			$count++;
			if ($count == $width) {
				$count = 0;
				print $out_fh "\n";
			}
		}
		print $out_fh "\n\n";
		# print "$ref_base\n";
	}
}
# ADD REFERENCE SEQUENCE
# ----------------------
if ($add) {
	print $out_fh ">Ref\n";

	my $position = $init;
	my $ref_base = 0;
	my $count = 0; # to count bases/line
	
	foreach my $i (@snps_ref) {
		my ( $insertion, $deletion ) = ( 0, 0 );
		# DELETION
		$deletion = 1 if (length($variants{$positions[$i]}[0]) > 1);
		# INSERTION
		$insertion = 1 if (length($variants{$positions[$i]}[1]) > 1);

		# BEFORE SNP position
		while ($position < $positions[ $i ]) { # Position lower than SNP position
			print $out_fh "$refseq[ $ref_base ]";
			$ref_base++;
			$position++;
			$count++;
			if ($count == $width) {
				$count = 0;
				print $out_fh "\n";
			}
		}
		# SNP position
		$count += length($variants{$positions[$i]}[0]) if ($deletion);
		$count += length($variants{$positions[$i]}[1]) if ($insertion);
		$count ++ if (!$deletion and !$insertion);
		print $out_fh "$variants{$positions[$i]}[0]";
		if ($insertion) { # If insertion, when reference allele
			for (my $l = 0; $l < length($variants{$positions[$i]}[1])-length($variants{$positions[$i]}[0]); $l++) {
				print $out_fh "-";
			}
		}
		$ref_base += length($variants{$positions[$i]}[0]);
		$position += length($variants{$positions[$i]}[0]);
		if ($count >= $width) {
			$count = 0;
			print $out_fh "\n";
		}
	}
	# When the last SNP is printed, the tail of the reference sequence
	for (my $j = $position; $j <= $init+$#refseq; $j++) {
		print $out_fh $refseq[ $ref_base ];
		$ref_base++;
		$count++;
		if ($count == $width) {
			$count = 0;
			print $out_fh "\n";
		}
	}
	print $out_fh "\n\n";
	# print "$ref_base\n";
}

# # ----------------------------------- LOG -------------------------------------------
print "\n$output file has been created!\n\n";
# # -----------------------------------------------------------------------------------
close $in_fh;
close $out_fh;


exit;
