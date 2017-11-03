#!usr/bin/perl

use warnings;
use strict;

# PER JUNTAR POBLACIONS

# INPUT Llista de chromopainter inputs separados con comas

# $ARGV[1] es una lista de las ubicaciones del in y out separadas por comas, $ARGV[2] es el prefijo del output

# Crear HASH
	
	# Separar cada ubicacion
	my @Poploc = split (",", $ARGV[0]);

	foreach my $P (@Poploc){
		print "Location: $P\n";
	}

	# Crear el superhash
	my %Superhash;

	# Añadir las ubicaciones
	foreach my $Pop (@Poploc){
		$Superhash{$Pop}{Location} = $Pop; 
	}

	# Añadir el haplo
	foreach my $Pop (@Poploc){
		open ( FH, $Pop.".out") or die "Can't open $Pop.out";
		@{$Superhash{$Pop}{Haplofile}} = <FH>;
		close FH;
	}

	# Sacar solo las posiciones de BEGIN END
	
	foreach my $Pop (@Poploc){
		
		@{$Superhash{$Pop}{Infofull}} = B_E ("BEGIN BESTPAIRS1", "END BESTPAIRS1", @{$Superhash{$Pop}{Haplofile}});
		
	}

	# Añadir las cabeceras

	foreach my $Pop (@Poploc){
		open ( FH, $Pop.".inp") or die "Can't open $Pop.inp";
		@{$Superhash{$Pop}{IDfile}} = <FH>;
		close FH;
	}



	
# Crear el nuevo .out

	open (my $Outfile, ">", $ARGV[1].".out") or die "Can't open $ARGV[1].out";
		print $Outfile "BEGIN BESTPAIRS1\n";
		foreach my $Pop (@Poploc){
			foreach my $line (@{$Superhash{$Pop}{Infofull}}){
				print $Outfile $line;
			} 
		}
		print $Outfile "END BESTPAIRS1\n";
	close $Outfile;

# Crear el nuevo .in	

	my $Inds=0;
	my $order = 0;

	foreach my $Pop (@Poploc){


		chomp ${$Superhash{$Pop}{IDfile}}[0];
		$Inds = $Inds+${$Superhash{$Pop}{IDfile}}[0];

		my $Numpos = ${$Superhash{$Pop}{IDfile}}[1];
		my $Pos = ${$Superhash{$Pop}{IDfile}}[2];

		if ($Numpos eq ${$Superhash{$Pop}{IDfile}}[1]){

			$Numpos = ${$Superhash{$Pop}{IDfile}}[1];
			if ($Pos eq ${$Superhash{$Pop}{IDfile}}[2]){

				$Pos = ${$Superhash{$Pop}{IDfile}}[2];
					
					
			}	
		}
		else {
			print "\nCoincidence problem\n";
			$order++;
		}	

	}

	
	open (my $Inpfile, ">", $ARGV[1].".inp") or die "Can't open $ARGV[1].inp";
	
		print $Inpfile $Inds."\n";
		
	
		if ($order == 0){
			print $Inpfile  ${$Superhash{$Poploc[0]}{IDfile}}[1].${$Superhash{$Poploc[0]}{IDfile}}[2];
		
		}	
		
		
		print $Inpfile "\nTHIS COMES FROM\n";	

		foreach my $Pop (@Poploc){
			for (my $i = 0; $i <3; $i++){
			print $Inpfile ${$Superhash{$Pop}{IDfile}}[$i]."\n";
		
			}	
		}

	close $Inpfile;

	


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

