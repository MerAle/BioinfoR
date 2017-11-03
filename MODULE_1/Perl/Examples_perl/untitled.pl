#!usr/bin/perl

use warnings;
use strict;

################################################

# # Indivs
# # Adolfo 0,1,1110, I, Bernat 0, 0, 1111, S, Carlitos 0,0, 1110, I Dora 0,0, 1111, I Ernesto 0,0, 1111 I 
# my @Positions = ("P", 1,2,3,4,5,6,7,8,9,10, "S1", 12,13,14,15, "S2");
# my @Info = ("0011010101I1110I\n",
# 			"0100101010S1111S\n",
# 			"0110101100I1110I\n",
# 			"0101101010I1111I\n",
# 			"0101110100I1111I\n"	);
# my @Insum = (5,16);

###################################################

# En teoria hemos puesto perl PHASEtoCHP.pl input output

	# print $ARGV[0]."\n";
	# print $ARGV[1]."\n";

#ABRIR INPUT	

	# Obrir el fasejat
	open ( FH, $ARGV[0].".out") or die "Can't open $ARGV[0].out";
	my @Phase = <FH>;
	close FH;

	# Obrir el input
	open ( FH, $ARGV[0].".inp") or die "Can't open $ARGV[0].inp";
	my @Infile = <FH>;
	close FH;

###  Number of haplotypes, Number of SNPs, positions

	# Infile [0] tiene el number of individuals.... pero lo haremos por haplotipos asi que lo multiplicamos
	my $Haplotypes = $Infile[0]*2;

	# Infile [1] tiene el number of SNPs
	# Infile [2] tiene el number of positions
	
	my @Positions = split ( " ", $Infile[2] );

	
	# Por comodidad, quitamos la P de @Positions
	shift @Positions;



### SNP values limpio, Extraer Individuals

	# Sub BEGIN_END BESTPAIRS1
	my @Info = B_E ("BEGIN BESTPAIRS1", "END BESTPAIRS1", @Phase);

	# Netejar
		my @Individuals;

		for (my $i = 0; $i < scalar @Info; $i++ ) {
			# Si tiene el patron ^numespacio#numeros,
			if ($Info[$i] =~ /^\d?\s?#\s?(\S+)/){
				# Limpiar el nombre
				$Info[$i] =~ s/^\d?\s?#//;

				chomp $Info[$i];
				#Guardar el nombre x2
				push @Individuals, "$Info[$i]_1";
				push @Individuals, "$Info[$i]_2";
				# delete $Info[$i];
			}
			# si no, quitar los parentesis
			else { $Info[$i] =~ s/[() ]//g;}	
		}

## Fusion, breakage points, no informatius...
	# HASH OF ARRAYS : POSITION => ARRAY(PINDI1,PINDI2, PINDI3...)
		
		my %big_info;

		# KEYS = POSITIONS
	
		foreach my $Name (@Positions){ # Totes les posicions
			$big_info{$Name} = ();     # De moment buides
		 }

		 # KEYS ordenadas = foreach @Position
						

		 # ARRAYS = INDIVIDUALS INFO

		 # En info, cada row es un individu
		 # Foreach key, foreach row en el Info, poner el valor que corresponde

		 # Foreach key = foreach position in array (de 0 a n)						
		 
		# for (my $i = 0; $i < scalar @Positions; $i++) { # $i es la nostra posicio === $Positions[$i] === positioninline. Pej. añadiremos las posiciones 0 al valor 0 del array

			#print "\nStarting position $i";
			# Per cada linia de SNPs			
			foreach my $line (@Info) {
				   if ($line =~ /^\w\w\d+$/){
				# if (defined $line){ #Es treu una posició 
					print $line;
					# push(@{$big_info{$Positions[$i]}}, substr($line,$i, 1)) # I es fica en el nostre array del hash

		 		}
			  }
		# }

# Subrutina BEGIN_END
sub B_E {
		my ($Word1, $Word2, @File) = @_;

		#print $Word1.$Word2."\n";
		#print @File."\n";
		my @Fragment;
		my $Begin = 0;
		my $End = 0;
		

		foreach my $line (@File) {
			#print $line;

			 if ($line =~  /$Word1/){$Begin = 1;}
			 if ($line =~  /$Word2/){$End = 1;}

			

			  if ($Begin eq 1 && $End eq 0) { # Quan troba el principi (pattern inicial 1, final 0)
			   		
			   	
			   	push @Fragment, $line; #Se'l guarda

			   }

				
			  elsif ($Begin eq 1 && $End eq 1) {
			  	
			  	$Begin = 0;
			  	$End = 0;
			  	shift @Fragment;
			 	return @Fragment;

			  }

		}

	}

