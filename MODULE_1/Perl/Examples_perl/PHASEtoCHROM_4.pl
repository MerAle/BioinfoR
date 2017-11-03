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
# REVISED VERSION, deletes [] charachters
# Control of repeated positions
# Changes in indivnames detection
################################################

# En teoria hemos puesto perl PHASEtoCHP.pl inputpref outputpref 

	print $ARGV[0]."\n";
	print $ARGV[1]."\n";

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
	# my $Haplotypes = $Infile[0]*2; 
	# AL FINAL NO LO USAMOS PORQUE A VECES ESTE NUMERO PUEDE CAMBIAR

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
			if ($Info[$i] =~ /^\d?\s?#\s?(\S+)_?(\S*)/){  # empieza por 0 o 1 digito, 0 o 1 espacio, # 0 o 1 espacio, letras o digitos 1 o mas, _ 0 o 1, letras o digitos 0 o mas 
				
				# Limpiar el nombre
				my $Name1 = $Info[$i];
				$Name1=~ s/^\d?\s?#//;
				chomp $Name1;
				
				#Guardar el nombre x2
				push @Individuals, $Name1."_1";
				push @Individuals, $Name1."_2";
				
				;
				# delete $Info[$i];
			}
			# si no, quitar los parentesis
			else { $Info[$i] =~ s/[() \[\]]//g;}	
		}

		my $Haplotypes = scalar @Individuals;
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
		
		for (my $i = 0; $i < scalar @Positions; $i++) { # $i es la nostra posicio === $Positions[$i] === positioninline. Pej. añadiremos las posiciones 0 al valor 0 del array

			#print "\nStarting position $i";
			# Per cada linia de SNPs			
			foreach my $line (@Info) {
				 if ($line !~ /^\d?\s?#\s?(\S+)_?(\S*)/){
				 	
				# if (defined $line){ #Es treu una posició 
					
					push(@{$big_info{$Positions[$i]}}, substr($line,$i, 1)) # I es fica en el nostre array del hash

		 		}
			}
		}

	# YA ESTA EL HASH OF ARRAYS

	# EVALUACION 	

	# SINGLETONS
	# Foreach key, si su posicion contiene letras, o es un singleton extraer a breaks y posiciones malas, y contar +1 

		my $Wrong = 0;
		my $Single = 0;
		my $Mono=0;
		my $Good=0;
		
		my %Breaks;
		my %Bad;
		my %Good;

		foreach my $key (keys %big_info){ # Para cada key (no hace falta que esten ordenadas)
				
							 		# print "Normal: $key > ";
  			 			 #  foreach my $val (@{$big_info{$key}}) {
     				 # 		 print "$val";
   		 				# 	}
   						 # print "\n";

			
			# Comptadors
			my $T = 0;
			my $F = 0;
			my $Others = 0;

			# Per cada posicio en la linia avaluada 
			foreach my $comp (@{$big_info{$key}}) {	

				# Mirar si es 0 o 1, o SI
				if ($comp eq 1){$T++;}
				elsif ($comp eq 0){$F++;} 
				elsif ($comp =~ /[SI]/g){$Others++;}
						
		 	}
	 

			# Mirar si es un break
			
			if ($Others > 0){
				# Si es un break		
				# Posar tots els valors d'aquell break en el nou	
				foreach my $line (@{$big_info{$key}}) {	
					if (defined $line){ 
						push (@{$Breaks{$key}}, $line); 
					}	
		 		}
		 		# Comptar una nova posicio dolenta
				$Wrong++;	
				
			}
	
		 	# Si no es aixo, mirem i si esta malament va  a Bad
 	
			 # elsif (($T <= 1 || $F <= 1 )){
		
			 # 	foreach my $line (@{$big_info{$key}}) {	
				# 	if (defined $line){ 
				# 		push (@{$Bad{$key}}, $line); 
				# 	}
				# }	
				# # Comptar una nova posicio dolenta
				# $Wrong++;		
			 # }
		 	
		 	
		 	
		 	else {# si no passa res d'aixo	
		 		$Good++;
		 		foreach my $line (@{$big_info{$key}}) {	
					if (defined $line){ 
						push (@{$Good{$key}}, $line); 
					}	
		 		}

		 	}
			
		}

	

# Ajustar el numero de posiciones
	
		#$Infile[1] = $Infile[1]-$Wrong;



# OUTPUT

# .IDFILE.TXT
#Individual_copy Population <S o I> 0/num

	open (my $Idfile, ">", $ARGV[1].".idfile.txt") or die "Can't open $ARGV[1].idfile.txt";

	# Para cada individuo de Individuals
	for (my $p = 0 ; $p < scalar @Individuals; $p++ ){
		# imprimir el individuo
		print $Idfile $Individuals[$p]." ";	
		
		# mirar su  posicion de la string de uno de los breakage points

		my$con = 1;
		foreach my $key (keys %Breaks){ # buscar en la primera key de breakage
			
			print $Idfile ${$Breaks{$key}}[$p]; # imprimir el valor de ese individuo dentro del primer breakage
			

			last if $con ==1;
		}
		
		#imprimir el final
		print $Idfile " 1\n";
	
	}

	close $Idfile;

# .POPLIST.TXT
# Population D/R 

	open (my $poplist, ">", $ARGV[1].".poplist.txt") or die "Can't open $ARGV[1].poplist.txt";

	print $poplist "S D\nS R\nI D\nI R";

	close $poplist;


# .HAPLOTYPES
# #Number of haplotypes
# #Number of SNPs
# #P Positions separated by " "
# #Aaaaaaall information

	open (my $Haplo, ">", $ARGV[1].".haplotypes") or die "Can't open $ARGV[1].haplotypes";

	# Primers parametres
	print $Haplo $Haplotypes ."\n"; 

	print $Haplo scalar (keys %Good)."\n";

	
	# Imprimir les posicions bones en la mateixa linia
	# Estan per ordre a @Positions, i les bones son a %Good
	print $Haplo "P ";
	
	my $anteloc = "a";
	foreach my $loc (@Positions){ # Per cada posicio (bona o dolenta, per ordre)
		
		foreach my $key (sort keys %Good){ # Miro cada key bona

			if ($loc eq $key){ # Si hi ha una key bona que coincideix amb la que estem mirant. Imprimint $key ens assegurem de que es bona
				if ($loc !~ $anteloc){
				$anteloc = $loc;	
				print $Haplo $key. " "; # imprimeix el lloc i un espai
				}

			}
		}

	}
	print $Haplo "\n";

	# Imprimir linia per linia, EN ORDRE dels bons 	
	# Per cada individu del 0 fins els que hi hagi (els individus que hi ha són $Insum [0] == nombre d'haplotips)

	for (my $i = 0; $i < $Haplotypes ; $i++ ){

		# Mirar les posicions per ordre
			my $anteloc = "a";
		foreach my $loc (@Positions){ # Per cada posicio (bona o dolenta, per ordre)
			
			foreach my $key (keys %Good){ # Miro cada key bona

				if ($loc eq $key){ # Si hi ha una key bona que coincideix amb la que estem mirant. Imprimint $key ens assegurem de que es bona
					# print "\nLocation $loc = $key  (anteloc was $anteloc)";
					# Imprimir la info de aquella posicio en aquell individu
					if ($loc !~ $anteloc){
						$anteloc = $loc;
						
					 print $Haplo ${$big_info{$key}}[$i];
					}	
				}
			}

		}
		# Salt de linia
		print $Haplo "\n";		
	}

	close $Haplo;

# .BREAK

	open (my $Break, ">", $ARGV[1].".breaks") or die "Can't open $ARGV[1].breaks";

		foreach my $Key (keys %Breaks){
			print $Break $Key."\n";
		}
	close $Break;	

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



## ANTIC
		# my %Singletons;
		# foreach my $key (keys %big_info){ # Para cada key (no hace falta que esten ordenadas)
			
			# Mirar si es un singleton
			#print "Buscabamos esto". ${$big_info{$key}}[1]."\n" ;

			
		# Fem contadors
						
						# Des del principi fins al final de la linia  Compta 0 i 1
						# for ( my $s = 0; $s < length $big_info{$key}; $s++){ 
							
						# 	my $comp = substr ($big_info{$key}, $s, 1);
						# 	if ($comp eq 1){$T++;}
						# 	elsif ($comp eq 0){$F++;}
						# }

						# # Si T o F == 1
						# #if ($T eq 1 || $F eq 1){
						# if ($T <= 1 || $F <= 1){	
						# 	# El fiquem a singletons
						# 	$Singletons{$key} = $big_info{$key};
						# 		print "Encontrado $big_info{$key} en $key \n ";
						# 	$Wrong++;
						# 		print $Wrong;

		###################################################

		# 	print "\nAl final, queda esto:\n ";
							# 	foreach my $k (keys %big_info) {
							# 		print $k;
		  			# 			 foreach my $val (@{$big_info{$k}}) {
		     # 						 print " $val ";
		   		# 			}
		   		# 				print "\n";
							# }

		####################################################

		### Fusion, breakage points, singleton

			# Hacer un hash of arrays, cada hash tiene, de nombre la posicion,
			# y los valores en un array correspondiente
				
				# my %big_info;

				# # Los nombres de las keys estan en @Positions que no son P o un espacio
			
				# foreach my $Name (@Positions){
				# 	if ($Name eq "P"){next;}
				# 	$big_info{$Name} = ();
				#  }


								 # print "Big info keys\n";
								 # foreach my $keya (keys %big_info){

								 # 	print $keya."\n";
								 # }


			# # Foreach key, foreach row en el Info, poner el valor que corresponde

			# 	my $counter = 0;

			# 					print "\n Tenemos estas posiciones: ".scalar @Positions;


			# 	for (my $i = 1; $i < scalar @Positions; $i++) { #Per cada posicio desde despres de P

			# 					print "\n Examinando esta posicion".$Positions[$i];

			# 		#Es crea la linia
			# 		my $string;

			# 		# I per cada linia de SNPs
					
			# 		foreach my $line (@Info) {	
			# 			#Es treu una posició 
			# 	 		if (defined $line){

			# 	 				print "\nAñadiremos la $counter esima letra de la posicion $i en $line, que es" .substr($line,$counter, 1);
			# 	 			$string = $string.substr($line,$counter, 1);
			# 	 		}
			# 		}
				
			# 		# S'inclou la linia al hash
			# 		$big_info{$Positions[$i]}=$string;

			# 		# Comptador
			# 		$counter ++;

			# 	}

			# 					print "\nAl final, queda esto:\n ";
			# 					foreach my $key (keys %big_info){
			# 						print	$key." con ".$big_info{$key} ."\n";						
			# 					}
							

			# Foreach key, si line contiene letras, extraer a otro hash.
			# Lo mismo si es un singleton 

				# my $Wrong = 0;
				
				# my %Breaks;
				# foreach my $key (keys %big_info){
					
				# 	# Guardar la posicio i contarla
				# 	if ($big_info{$key} =~ /[SI]/g){
				# 				print "Encontrado $big_info{$key} en $key \n ";
				# 		$Breaks{$key} = $big_info{$key};
				# 		$Wrong++;
				# 					print $Wrong;
				# 	}
				# }

				# my %Singletons;
				# foreach my $key (keys %big_info){ # Per cada posició

				# 	if (defined $big_info{$key} ) { #ja hem borrat algunes coses
				# 		#Treure espaiadors abans de comptar
				# 		chomp $big_info{$key};

				# 		# Fem contadors
				# 		my $T = 0;
				# 		my $F = 0;
				# 		# Des del principi fins al final de la linia  Compta 0 i 1
				# 		for ( my $s = 0; $s < length $big_info{$key}; $s++){ 
							
				# 			my $comp = substr ($big_info{$key}, $s, 1);
				# 			if ($comp eq 1){$T++;}
				# 			elsif ($comp eq 0){$F++;}
				# 		}

				# 		# Si T o F == 1
				# 		#if ($T eq 1 || $F eq 1){
				# 		if ($T <= 1 || $F <= 1){	
				# 			# El fiquem a singletons
				# 			$Singletons{$key} = $big_info{$key};
				# 				print "Encontrado $big_info{$key} en $key \n ";
				# 			$Wrong++;
				# 				print $Wrong;
				# 		}
				# 	}	
				# }
# IMPRINTING VELL

	# open (my $Haplo, ">", $ARGV[1].".haplotypes") or die "Can't open $ARGV[1].haplotypes";

	# # Imprimir els dos primers parametres
	# foreach my $IS (@Insum){

	# 	 print $Haplo $IS."\n";
	# } 

	# #Imprimir les posicions que no son breaks o singletons
	# # Imprimim el principi
	# print $Haplo $Positions[0]." ";

	# my @Badpos; # Faig el comptador de posicions dolentes
	# for (my $P = 1; $P < scalar @Positions; $P++) { # Miro totes les posicions
	# #foreach my $P (@Positions){

	# 	# Posicions dolentes
			

	# 		# Miro si es un break o singleton
	# 			my $denied = "FALSE";
	# 			foreach my $key (keys %Breaks){
	# 				if ($Positions[$P] eq $key){
	# 					$denied = "TRUE";
	# 				}

	# 			}	

	# 			foreach my $sing (keys %Bad){
	# 				if ($Positions[$P] eq $sing){
	# 					$denied = "TRUE";
	# 				}

	# 			}	
			
	# 		my $BP = $P - 1;
			
	# 		# Si no es un break o singleton, print, si no, t'ho guardes
	# 		 if ($denied eq "FALSE") {print $Haplo $Positions[$P]." "}
	# 		 elsif ($denied eq "TRUE") {push @Badpos, $BP; }

		 
	# } 
	# print $Haplo "\n";


	# # Ara toca la informació 

	# foreach my $I (@Info){ # Per cada individu

	# 	if (defined $I ) { # Si esta definit

			
	# 		# Imprimir el que no son singletons
	# 		for (my $w = 0; $w < length $I ; $w++){ # Cada posicio en la linia
	# 			# Mirar si es singleton
	# 			my $del = "FALSE";
	# 			foreach my $bp (@Badpos){
	# 				if ($w eq $bp) {
	# 				$del = "TRUE"; 
	# 				}
	# 			}

	# 			# Si no es singleton 
	# 			if ($del eq "FALSE"){
	# 				# imprimir
	# 				print $Haplo substr ($I, $w, 1);
	# 			}	
				
	# 		}
	# 	#retornarli el salt de linia
			
	# 	}

	# }
		
	 

	# close $Haplo;