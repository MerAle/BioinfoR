#!/usr/bin/perl
# SEMPRE COMENÇAM AIXI
#GUARDAR CON CTRL S
use warnings; 
# use warnings nos soluciona los problemas
# una vez hecho esto ya podemos programar, y para seleccionarlo hacemos
# en la CMD: cd link de la carpeta
# y despues perl nombre_archivo.pl
#_____print "Hello";
# print "sample" escribe el texto que queramos...
#las dobles comillas interpretan el texto
# si pongo
#_____print "no";
# me imprime Hellono, así qeu hago
#_____print "\n no";

# .-. VARIABLES PERL .-. #

######################
# VARIABLES ESCALARS #
######################
# Proporcionen un lloc  a la memoria per guardar dades temporalment. És una acdena
# Son LLETRES, NUMEROS, _; començam per LLETRA
# El text entre "", si hi ha d'haver un caracter del programa, s'escapa amb \
# El . es per concatenar
# Tots els operadors aritmetics funcionen (+-*/) > ** es exponencial
# Funcions aplicables:
	# length =  ens dona la llargada
	# lc = passa de majuscules a minuscules
	# uc =  de minuscules a majuscules
print "\n ESCALARS \n";

# Creamos e imprimimos la secuencia 1
	$ Seq1 = "ATGAAATTCTTCCTGCTGCTTTCCCTCATTGGATTCTGCTGGGCCCAATAGCTATAGT";
	print "\n SEQUENCIA 1: $ Seq1";
# Creamos  e imprimimos la secuencia 2
	$ Seq2 = "AAAGTCTATGTTGGCAATGATGGCAAAGCTCACTTTTCTAAATTGCTAGTAGTCAGTA";
	print "\n SEQUENCIA 2: $ Seq2";
# Concatenamos e imprimimos secuencias 1 y 2
	$ Seq1_2 = $ Seq1.$ Seq2;
	print "\n SEQUENCIA 1+2: $ Seq1_2";
#Creamos la variable length y la imprimimos, y esto lo haremos para todos
	$ length_Seq1 = length $ Seq1 ;
	print "\n \n LONG S1: $ length_Seq1";
	$ length_Seq2 = length $ Seq2 ;
	print "\n LONG S2: $ length_Seq2";
	$ length_Seq1_2 = length $ Seq1_2 ;
	print "\n LONG S1+2: $ length_Seq1_2";
#Comprovam que hem fet be la seq 1_2, sumant les dues lengths
	$ length_prova = length ($ Seq1)+ length($ Seq2);
	print "\n LONG PROVA: $ length_prova";

###########
# MATRIUS #
###########
# Emmagatzemen mes d'un valor (son com un conjunt d'escalars)
# Els valors els indiquem amb $matriu, i estan numerats entre [] començant per 0
print "\n \n MATRIUS \n";

# Generam la matriu
	@ BP = ("A","C","G","T");
# Podem imprimir tot aixi
	print "\n  Primer element: $BP[0]";
	print "\n  Segon element: $BP[1]";
	print "\n  Tercer element: $BP[2]";
	print "\n  Quart element: $BP[3]";
# Contar els elements de la matriu convertintla en var. escalar que ens dona el nombre d'elements de la matriu
	$ length_BP = @BP;
	print "\n \n Long. BP: $ length_BP";
# Mirar el darrer index (de 0 a n) $#
	$ length_ind_BP = $#BP;
	print "\n Long.var.BP: $ length_ind_BP";
# Mes funcions
# push: Afegeix un element al ultim lloc de la matriu
# pop : Treu el darrer element d'una matriu (emmagatzemable)
# shift : Treu el primer element d'una matriu (emmagatzemable)
# unshift : Afegeix un element al primer lloc de la matriu
# reverse : Inverteix l'ordre dels elements en una matriu 
# sort: ordena per ordre alfabetic DE PERL 1,11,2,...

##########
# HASHES #
##########
# Son matrius associatives que donen un key i un valor associat.
# Les key no es poden repetir
# Els valors no es poden treure per posicio o numero, cal la key
# Els valors els indiquem amb $hash, i {key}
print "\n \n HASHES \n";

# Generam un Hash
	%Tipus = ("A" => "Purina", "G" => "Purina", "C" => "Pirimidina", "T" => "Pirimidina");
# Convertim el Hash en variables
# PERO NO CAL
# $ A = $Tipus{"A"};
# $ G = $Tipus{"G"};
# $ C = $Tipus{"C"};
# $ T = $Tipus{"T"};
# IMPRIMIM

# Imprimim tot chachi
	print "\n TIPUS \n". 
	"\n T: ".$Tipus{"T"}.
	"\n A: ".$Tipus{"A"}.
	"\n G: ".$Tipus{"G"}.
	"\n C: ".$Tipus{"C"};

# .-. INPUTS .-. #

##########
# TECLAT #
##########
print "\n \n TECLAT \n \n";

#QUAN S'EXECUTA EL PROGRAMA
# Introduim dades que queden emmagatzemades dins @ARGV, i cada paraula es un element (espai = separador)
# A mes $0 dona el nom del programa (del script)
# ahora imprimimos los paramentro de la matriz @ARGV
	print "\n PARAMETRE 1: ".$ARGV[0];
	print "\n PARAMETRE 2: ".$ARGV[1];

# MENTRES ESTA FUNCIONANT EL PROGRAMA
# El programa <STDIN> espera que l'usuari introdueixi una var escalar
# S'ha de dir a l'usuari que ha de posar, i s'ha de fer chop per eliminar ENTER

# Vamos a hacer que nos pida un gen
	print "\n \n PER FAVOR introduir un GEN \n";
# Aqui nos pide el gen y se lo guarda
	$Gen = <STDIN>;
	chomp($Gen);
# Y nos devuelve esto
	print "\n el gen es:";
	print $Gen;
	
#******************
#printf es una funcion que te permite dar formato al texto
# ponemos printf en lugar de print y escribimos
# donde queramos poner el formato, ponemos % y modificadores
	# numero.numero f = numero de decimales
	# numero s = numero de cadenas?
	# numero d = numero de digitos
# ******************

##################################
# LECTURA I ESSCRIPTURA D'ARXIUS #
##################################
# Utilitzarem el FILEHANDLE 
# open obre
# die atura el programa i torna un missatge d'error
# close el tanca
# Nomes podem obrir per llegir o escriure, no totsdos alhora.
# Per escriure en un arxiu ja existent, s'ha de llegir, tancar, i ogrir en mode escriptura

# PRIMER llegir = open (FILEHANDLE, "nom_arxiu") or die "Missatge d'error";
	# llavors, per llegir l'emmagatzemam en una matriu (dada=linia) o escalar (dada=1a linia)
	# @arxiucomplet = <FILEHANDLE>;
# SEGON escriure = open (FILEHANDLE, ">>nom_arxiu") or die "Missatge d'error";
	#per imprimir algo en l'arxiu...
	# print FILEHANDLE "Missatge per l’arxiu";
# o per crear...
# cream en mode escriptura = open (FILEHANDLE, ">nom_arxiu") or die "Missatge d'error";

print "\n \n ARXIUS \n \n";

# son exemples:

# Hem descarregat l'arxiu 
	# l'obrim, no se si ha d'estar a la mateixa carpeta...
		open (FILEHANDLE, "hs6st.fasta") or die "No es troba l'arxiu";
	# el guardam en una variable escalar.
		$prova_variable = <FILEHANDLE>;
	# el tancam
		close FILEHANDLE;
	# i l'imprimiim
		print "Primera linia: \n".$prova_variable;

# Ara l'hem de tornar a obrir i l'hem de guardar en una matriu
# l'obrim, no se si ha d'estar a la mateixa carpeta...
		open (FILEHANDLE, "hs6st.fasta") or die "No es troba l'arxiu";
	# el guardam en una matriu
		@prova_matriu = <FILEHANDLE>;
	# el tancam
		close FILEHANDLE;
	# i l'imprimiim
		print "La nostra matriu: \n" . " @prova_matriu ";

# .-. TRANSFORMACIONS .-. #

# split : Escalar a Matriu 
# join : Matriu a escalar

# cream un escalar
	$linea="192a,UAB,GGGTCTC,CCTGGAT";
# Separam l'escalar en una matriu per les comes
	@campos = split (',', $linea);
# Tornam a juntar l'escalar, separant els valors amb un tabulador$linea_tab
	$linea_tab = join ("\t", @campos);


#####################
# SUPER PROVA FINAL #
#####################
print "\n \n PROVA FINAL \n \n";

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
# Ara cream el hash
	%GenDM = ("$linia1" => "$Seq_1");
# Ara l'imprimim a fora
	open (FILEHANDLE, ">Drosophila.txt") or die "Hi ha hagut un error";
	print FILEHANDLE "DROSOPHILA MELANOGASTER \n \n 
	Gen: \n $linia1 \n
	Sequencia: \n " . $GenDM{"$linia1"} . "\n ";
	
	
	
# perl P2.pl

















