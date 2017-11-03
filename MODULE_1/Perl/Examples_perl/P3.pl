#!/usr/bin/perl

use warnings;
# vale, ya hemos hecho lo de siempre

# Per metodes iteratius, hi ha abreviatures dels operadors.
	# $+=  = sumar un numero a $
	# $-=  = restar un numero a $
	# $*=  = multiplicar un numero a $
	# $/=  = dividir un numero a $
	# $.=  = concatenar un numero a $

# .-. ESTRUCTURES DE CONTROL .-. #
# Ens permeten aterar i gestionar entrada processament i sortida de les dades
# Basicament repeteien conjunts de forma automatica
# Amb exit sortim del programa 

#################
# IF ELSIF ELSE #
#################
# Realitza accoins condicionals
# la seva estructura es
	# si (algo) {feim aixo;}
# per afegir coses :
#aixo es una funcio i , i  , i
	# if (algo&&algo2&&algo3) {feim aixo}
	# elsif (algo) [feim aixo altre}
	# elsif (algo) {feim una altra cosa}
	# else no hi ha condicions {per fecte}
# aixo es una funcio o, o , o 
	# if (algo || algo || algo)
	
# Normalment s'empleen per eemple per comparar:
	# == compara numeros
	# eq compara cadenes de text
	# ne no iguals (es el contrari de equal) 
	# != no igual
	# lt less than
	# gt greater than
	# le less or equal
	# ge greater or equal
print "\n ESCALARS \n";

#  Creem les sequencies
	$S1= ATGATGATGATGATGATG;
	$S2= ATGATGATGATGATGATG;
	$S3= ATGATGATGATGATGATGATGATGATG;
# Miram la seva llargaria
	$S1l= length ($S1);
	$S2l= length ($S2);
	$S3l= length ($S3);
# Comprovem que tot ha funcionat
	print "\n COMPARAR SEQUENCIES \n\n Sequencies: \n$S1 \n$S2 \n$S3 \n \n Longituds: \n$S1l \n$S2l \n$S3l\n" ;
# Feim les comparacions
	print "\n Ara farem les comparacions\n";
	print "\n 1 i 2 \n\n";
	if ($S1l == $S2l) 
		{if ($S1 eq $S2) 
			{print "Les dues sequencies son iguals\n";}
		}
	else {print "Les dues sequencies no son iguals\n";}
	print "\n 2 i 3 \n\n";
	if ($S2l == $S3l) 
		{if ($S2 eq $S3) 
			{print " Les dues sequencies son iguals\n";}
		}
	else {print "Les dues sequencies no son iguals\n";}

##################
# WHILE = bucles #
##################

# Mentre la condició sigui certa anirà repetint
	# While (condicio) {fas aixo}
# Hem d'anar posant $x++ sumam 1. $x-- restam 1

#una altra variant de while ,el contrari, seria
# UNTIL (){}
print "\n\n WHILE \n\n";
	
# Creem la nostra variable chachi
	$x = 3;
	print "LA nostra variable inicial sera $x\n";
# ara el bucle
	while ($x >= 0) {
		if ($x >0) {
			print "$x \n";
			$x--;
		}
		else {
			print "BOOM!!!\n";
			$x--;
		}
	}
	
#****************++
# defined = comprueba si la variable esta llena
# last = acaba el bucle, sin salir del programa, es como un warn sin aviso
# *******************

###########
# FOREACH #
###########

#Esto lo que hace es aplicar algo a toda la matrix
# Haremos
	# foreach $variable (@matriu) {accion;}
# Para hacerlo en toda
	# foreach (@ matriu) {accion}
print "\n\n FOREACH \n\n";	

# primer crearem la sequencia
	$Sequ= ATGTACGTGCACGTACGAGTCTGACGTACGTACCAGTGAC;
	print "$Sequ\n";
	@Sequ= split("",$Sequ);
	print "@Sequ\n";
# Creem el que ens acumula els numeros
	$A = 0;
	$C = 0;
	$T = 0;
	$G = 0;
# ara farem el foreach
#quan diem $name, estem creant una variable que acumulara l'element de @
#amb el que esta treballant en aquellñ moment
	foreach $name (@Sequ) {
		if ( $name eq "A"){ $A++;}
		elsif ( $name eq "C"){ $C++;}
		elsif ( $name eq "T"){ $T++;}
		elsif ( $name eq "G"){ $G++;}
	}
	print "\n A:$A \n C:$C \n T:$T \n G:$G \n";

#######
# FOR #
#######
# enera un bucle on tenim molt control de cada iteració
print "\n\n FOR \n\n";

# esto funciona
#$a=1;
#print "@Sequ[$a]";

#utilitzarem la mateixa sequencia d'abans
# per aixo necessitem 
	$LS = length ($Sequ);
	$A2 = 0;
	$C2 = 0;
	$T2 = 0;
	$G2 = 0;
	print "\n abans \n A:$A2 \n C:$C2 \n T:$T2 \n G:$G2 \n\n ";
	for ($i=0; $i < $LS; $i++){ # en aquest cas no podem posar <=
		if ( $Sequ[$i] eq "A"){ $A2++;}
		elsif ( $Sequ[$i]  eq "C"){ $C2++;}
		elsif ( $Sequ[$i]  eq "T"){ $T2++;}
		elsif ( $Sequ[$i]  eq "G"){ $G2++;}
	}
	print "\n despres \n A:$A2 \n C:$C2 \n T:$T2 \n G:$G2 \n";

#**************+++
# next = si se cumple la condicion, no sigue, acumula +1 en el contador y vuelve a empezar
##**********

# .-. ITERAR SOBRE FILES DUN ARXIU .-. #

#Podem fer servir el FILEHANDLE o sobrenom de l'arxiu obert per llegir-lo fila per fila si envoltem aquest sobrenom entre els símbols < >. 
# Open (ARXIU,ruta_arxiu) or die $! ;
	#while (<ARXIU>) {
        #instruccions
	#}
# close (ARXIU);

# Tambe podem guardar les fileres primer en un array i aixi tancam l'arxiu mes rapid

#open (ARXIU,ruta_arxiu) or die $! ;
#@arxiu = <ARXIU>;
#close (ARXIU);
#foreach $fila (@arxiu) {
        #instruccions
	#}

# .-. CERQES DE PATRO.-. #

## LA cerca de patró dins una cadena de text :
	# $escalar=~ /patro/;
# per cercar que no passi algo, :
	# $escalar !~ /patro/;
# Hem d'anar alerta amb el ~ perque si no esteim declarant la variable
# Retorna un resultat boolea (si/no) 


# Al final de la cerca hi ha modificadors
	# g = aplicarlo a tota la variable ,per cada patro i no nomes pel primer
	# i = insensible a maj.min
	# s= el . incloura salt de linia

# Als patrons podem posar coses chachis:
	# [ATG] = Varies opcions: A o T o G
	# [^ATG] = Cap de les opcions : ni A ni T ni G
	# . = tot menos  \n$S1
	# ^ = principi de linia
	# $ = final de linia
	# \w = qualsevol alfanumeric (NEGACIO EN MAJUSCULA)
	# \s = qualsevol espaiador  (NEGACIO EN MAJUSCULA)
	# \d = qualsevol digit (NEGACIO EN MAJUSCULA)
	# ? = 0 o 1 element
	# + = 1 o + elements
	# * = 0 o mes elements
	# {N,M} = entre N i M elements
	# {N,} = minim N elements
	# {,M} = maixm M elements
	# {N} = N elements

# CAS DEL FASTA
	# /^>(\S+)\s*(.*)$/

###############	
# SUBSTITUCIO #
###############
# Comença per s, 

print "\n\n SUBSTITUCIO \n\n";

# Utilitzarem la sequencia
	print "Sequencia prova: $Sequ\n";
# Ara fem la cerca
	$Sequ =~ s/T/U/g;
	print "\n Sequencia nova: $Sequ\n";

# Sen poden fer varies?
# es muy caca
# usaremos el tr directamente

##################
# TRANSCRIPCIONS #
##################
# Tendriem:
	# escalar=~ tr/patro/sustitucio/;
# No cal g al final, s'aplica a tot, i sustitueix els caracters de lesquerra
# per els de la dreta, un per un
print "\n\n TRANSCRIPCIONS \n\n";

	$Sequ =~ tr/UACG/ATGC/;
	print "\n Sequencia comp: $Sequ\n";

#############
# SUBSTRING #
#############
# substr ens treu fragments mes petits d'un text gra, i supos qeu els podem emmagatzemar
# va de 0 cap envant, o al reves, crec que tambe, i sempre extreu de esquerra a dreta
# substr( variable, inici, llargada)
print "\n\n SUBSTRING \n\n";

# Ara hem d'emmagatzemar l'arxiu fasta
# Obrir el fitxer
	open (FILEHANDLE, "hs6st.fasta") or die "No es troba l'arxiu";
# Guardar la primera posició en una variable escalar
	$linia1 = <FILEHANDLE>;
	print "En hem guardat aixo: \n $linia1 \n";
# Ara guardam la resta en una matriu
	@Seq = <FILEHANDLE>;
	chomp @Seq;
# Ara convertim aquesta matriu en una variable escalar
	$Seq_1 = join ("", @Seq);
	print "Ara tenim la sequencia escalar: \n \n $Seq_1 \n";

# Ara extreim informació d'aquesta variable escalar
	$Exo1 = substr ($Seq_1, 0, 362 );
	print "\n Primer exo: $Exo1 \n";

#########
# INDEX #
#########
# Ens diu la posicio que ocupa un escalar en un altre escalar, començant per 0

$abcd = "adcdefgh";
$letra = "e";
$posicion = index ($abcd,$letra);
print = "$letra esta en la posicion $posicion";

$abcd = "adcdefgh";
$letra = "efg";
$posicion = index ($abcd,$letra);
print = "$letra estan a partir de la posicion $posicion";

# ********
# que quiere decir el ultimo caso? pag16 perl IV
#*************

#########################
# EXERCICI PER ENTREGAR #
#########################

# Obrir el fitxer
	open (FILEHANDLE, "hs6st.fasta") or die "No es troba l'arxiu";
# Ara guardam TOT en una matriu
	@Seq = <FILEHANDLE>;
	close (FILEHANDLE);
# Guardam la primera posicio
	$linia_1 = shift @Seq;
	print $linia_1;
# Ara convertim aquesta matriu en una variable escalar
	$Seq_1 = join ("", @Seq);
	$Seq_1 =~ s/\s//g;
	print "Ara tenim la sequencia escalar: \n \n$Seq_1 \n";

# Crear nou arxiu
	open (FILEHANDLE, ">Drosophila.txt") or die "Hi ha hagut un error";
	print FILEHANDLE "DROSOPHILA MELANOGASTER \n \n 
		Gen: \n $linia1 \n\n";
#Omplir l'arxiu
	for ($i = 0; $i<length ($Seq_1); $i+50) {
	$Ex = substr ($Seq_1, $i , 50);
		print FILEHANDLE " $Ex \n";
	}

	
#####################
# EXERCICI OPCIONAL # 		
#####################		

# Passa 1: llegir el fitxer
	open (FILEHANDLE, "hs6st.fasta") or die "No es troba l'arxiu";
	$linia1 = <FILEHANDLE>;
	@Seq = <FILEHANDLE>;
	close (FILEHANDLE);
	$Seq = join ("", @Seq);
	$Seq =~ s/\n//g;
	$l = length $Seq;
	print "\n REVISIÓ \n\n Nom: $linia1 \n Sequencia: \n$Seq \n Longitud: $l\n\n";
# Passa2: llegir l'arxiu "Anotaicons"
	open (FILEHANDLE, "Anotacions.txt") or die "No es troba l'arxiu;";
	@Anot = <FILEHANDLE>;
	close (FILEHANDLE);
# Passa3: Extreure les sequencies
	foreach $var (@Anot) {
		@mat = split ("\t",$var);
		$num1 = $mat[1]-1;
		$num2 = $mat[2]-$num1+1;
		$print  = substr ($Seq, $num1, $num2);
		print "\n C: $mat[0] \\ Nom: $mat[3]\n$print\n";
	}





# perl P3.pl
