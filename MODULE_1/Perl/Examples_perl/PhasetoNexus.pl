#!/usr/bin/perl

use warnings;
use strict;



# INPUT: 

# Haplotypes, IDfile, Output


# OUTPUT: NEXUS format para PopART

		#NEXUS
			# [This is an example of a Nexus file, modified from a sample file distributed 
			# with DNASP. It should run in PopART. Any text appearing between square braces is
			# a comment and will be ignored by the program.]


		# BEGIN TAXA;
			# [You need either taxa and characters blocks, or else a data block.]
			
		# DIMENSIONS NTAX=7; 		 #NUMBER OF SEQUENCES = 250 INPUTHAPLOTYPES[0]


		# TAXLABELS
		# seq_1
		# seq_2
		# seq_3
		# seq_4
		# seq_5
		# seq_6
		# seq_7
		# ;

		# END;

		# BEGIN CHARACTERS;
			# [You can either use the matchchar option or else include all characters for 
			# all sequences.]

		# DIMENSIONS NCHAR=56;		 #NUMBER OF POSITIONS = 166 INPUTHAPLOTYPES[1]
		# FORMAT DATATYPE=DNA MISSING=? GAP=- MATCHCHAR=. ;    # OPTIONS  DataType = { standard | DNA | RNA | nucleotide | protein | continuous }
		# MATRIX

		# seq_1 ATATACGGGGTTA---TTAGA----AAAATGTGTGTGTGTTTTTTTTTTCATGTGG  # seq_1 = Name in idfile

		# seq_2 ......--..A..---...C.----.G...C.A...C..C...C............

		# seq_3 ..........A..---...T.----.G.............................

		# seq_4 ..........A..---G...T----..............................A

		# seq_5 ..........A..---G...G----..............................C

		# seq_6 ..........A..---G...C----..............................T

		# seq_7 ..........A..---G....----..............................A

		# ;

		# END;

		# BEGIN TRAITS;
			# [The traits block is specific to PopART. The numbers in the matrix are number of
			# samples associated with each trait. The order of the columns must match the 
			# order of TraitLabels. Separator can be comma, space, or tab.]
		
		#   Dimensions NTRAITS=5;		#S and I = 2
		#   Format labels=yes missing=? separator=Comma;

			#   [Optional: if you include TraitLatitude and TraitLongitude they will be used to place trait groups on the map]
			#   TraitLatitude 53 43.6811 5.4 -25.61 -0;
			#   TraitLongitude 16.75 87.3311 26.5 134.355 -76;

		#   TraitLabels Europe Asia Africa Australia America;  # S and I
		#   Matrix   # = ID file 1 and 0
		# seq_2 10,5,0,6,0
		# seq_7 0,0,5,0,0
		# seq_5 4,0,10,0,0
		# seq_4 0,0,0,4,2
		# seq_3 0,0,0,3,5
		# seq_1 0,0,0,3,3
		# seq_6 0,0,0,7,3
		# ;

		# END;

		

######################################

# INPUT

	print "Haplotypes : $ARGV[0]\nIDfile : $ARGV[1]\nOutput : $ARGV[2]\n";		

# OPEN INPUT
	
	open ( FH, $ARGV[0]) or die "Can't open $ARGV[0]";
		my @Haplotypes = <FH>;
	close FH;


	open ( FH, $ARGV[1]) or die "Can't open $ARGV[1]";
		my @Idfile = <FH>;
	close FH;

# PREPARE OUTPUT (in order of appearance)

	# DIMENSIONS NTAX --> no \n
	chomp $Haplotypes[0];

	# TAXLABELS --> no S/I 0

	my @Taxlabels = @Idfile;
	foreach my $lines (@Taxlabels){
		$lines =~ s/ \w \d//;
	}

	# DIMENSIONS NCHAR --> no \n
	chomp $Haplotypes[1];

	# ALIGNMENT
	my @Alignment = @Haplotypes;
	for (my $i = 0; $i < 3; $i++){
		shift @Alignment;

	}

	#TRAITLABELS MATRIX
	foreach my $lines (@Idfile){
		if ($lines =~ /( S \d\n$)/){
			$lines =~ s/ \w \d/ 1,0/;
		}
		elsif ($lines =~ /( I \d\n$)/){
			$lines =~ s/ \w \d/ 0,1/;
		}

	}

# WRITE OUTPUT

	open (my $Nexus, ">", $ARGV[2].".nexus") or die "Can't open $ARGV[2].nexus";

		print $Nexus "#NEXUS\n\nBEGIN TAXA;\nDIMENSIONS NTAX= $Haplotypes[0];\n\nTAXLABELS\n";

		foreach my $lines (@Taxlabels){
			print $Nexus $lines;
		} 

		print $Nexus ";\n\nEND;\n\nBEGIN CHARACTERS;\nDIMENSIONS NCHAR=$Haplotypes[1];\nFORMAT DATATYPE=standard MISSING=? GAP=- ;\nMATRIX\n\n";

		my $i = 0;
		foreach my $values (@Alignment){
			chomp $Taxlabels[$i];
			print $Nexus $Taxlabels[$i]." ".$values."\n";
			$i++;
		}


		print $Nexus ";\n\nEND;\n\nBEGIN TRAITS;\nDimensions NTRAITS=2;\nFormat labels=yes missing=? separator=Comma;\nTraitLabels S I;\nMatrix\n";

		foreach my $lines (@Idfile){
			print $Nexus $lines;
		}

		print $Nexus ";\n\nEND;";

	close $Nexus;	

