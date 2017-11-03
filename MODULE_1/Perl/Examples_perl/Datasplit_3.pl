#!usr/bin/perl

use warnings;

use strict;

######################
# V3 modifications: it accepts males
####################


# OBJECTIU

# Tenir tots els arxius d'input de chromopainter separats per les dues poblacions


# INPUT: tots els arxius de chromopainter i la llista de poblacions

# OUTPUT: una carpeta amb el nom de cada població

#  Els ARGV

	print " Arxius de chromopainter a $ARGV[0]\n Llista de poblacions a $ARGV[1]\n L'output sera guardat a $ARGV[2]\n"; 

# 1. OBRIR ARXIUS 

	
	open ( FH, $ARGV[0].".idfile.txt") or die "Can't open $ARGV[0].idfile.txt";
	my @Idfile = <FH>;
	close FH;

	open ( FH, $ARGV[1]) or die "Can't open $ARGV[1]";
	my @Poplist = <FH>;
	close FH;

# 2. FER EL DIAGNOSTIC : Llista de individus Poblacio seva: necessitarem el .idfile.txt i la llista de poblacions

	# Separar @Idfile en mascles i femelles

	my %Idfilenet; #femelles
	my %Idfilemale; #mascles

	foreach my $line (@Idfile){ #es diferencien en que un te _lletres i l'altre_numero

		if ($line =~ /\d+_\w\w/ ){
			$Idfilemale{$line}=0;
			
		}
		else {
			$Idfilenet{$line}=$line;
		
		}
	}


	# FEMELLES
	# Netejar el Idfilenet: esborrar a partir de _ 
	
	foreach my $file (keys %Idfilenet){

		$Idfilenet{$file}=~ s/_\d \w \d\n$//;
		
	}

	# MASCLES
	# Netejar el Idfilemale: Esborrar a partir de _ si acaba en _1, o despres de _ si acaba en _2, i ficar aquesta informacio en un hash de nom -> significat

	foreach my $key (keys %Idfilemale){
		

		if ($key =~ /is_a_man/){
			my $value = $key;
			$value =~ s/_is_a_man_\d \w \d\n$//;
			$Idfilemale{$key}= $value;
			
		}

		elsif ($key =~ /_1 \w \d/){

			my $value = $key;
			$value =~ s/_\w+\d+_\d \w \d\n//;
			$Idfilemale{$key}=$value;
			
		}	
	
		elsif ($key =~ /_2 \w \d/){
			my $value = $key;
			$value =~ s/^\w\w\d+_//;
			$value =~ s/_\d \w \d\n$//;
			$Idfilemale{$key}=$value;
			
		}
	}


	# Netejar el poplist: esborrar a partir del tab tot i afegir un salt de linia

	my @Poplistnet = @Poplist;

	foreach my $pop (@Poplistnet){
		$pop=~ s/\t/ /;
		$pop=~ s/\t.*//;
	}


	# FEMELLES 
	# Per cada linia del Idfilenet
	foreach my $file (keys %Idfilenet){

		# mirar totes les files de poplistnet
		foreach my $pop (@Poplistnet){

			# quan =~ /idfilenet/
			if ($pop =~ /$Idfilenet{$file}/){
				# afegir un index al array de idfilenet
				$Idfilenet{$file} = $pop;
				
			}	
		}
	}

	# MASCLES
	foreach my $file (keys %Idfilemale){
		foreach my $pop (@Poplistnet){

			if ($pop =~ /$Idfilemale{$file}/){
				$Idfilemale{$file} = $pop;
				
			}
		}
	}


# 3. OUTPUT

	# El IDPOP FILE

	open (my $IDpopfile, ">", "$ARGV[2].idpopfile.txt") or die "Can't open .idpopfile.txt";

			# Para cada file del ID file
			foreach my $values (@Idfile){

				if (defined $Idfilenet{$values}){
					my $print = $values ;
					$print =~ s/ \w \d\n$//;
					print $IDpopfile $print." ";
					print $IDpopfile substr $Idfilenet{$values}, -4;
				}
				elsif (defined $Idfilemale{$values}){
					my $print = $values ;
					$print  =~ s/ \w \d\n$//;
					print $IDpopfile $print." ";
					print $IDpopfile substr $Idfilemale{$values}, -4;

				}
		
			}

			# Para cada key del 

		close $IDpopfile;


	
