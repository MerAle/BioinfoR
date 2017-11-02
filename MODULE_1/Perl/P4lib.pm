#!usr/bin/perl
use warnings;
use strict;
# LLIBRERIA P4lib.pm
# RUTH GÓMEZ - 1360515

#2

# Funció de concatenar
# $escalar = Concatena (valores, valores, ...);

#PROVA
#$a = ATTG;
#$b = TTGA;
#$c = Concatena ($a,$b);
#print $c;

sub Concatena { #Todos los valores que quieras
	my @Seq = @_;
	my $Cadena = join ("",@Seq);
	return $Cadena;

}

# Funció d'obrir arxius en mode lectura(per exemple fastas ) i guardarlos en una matriu
# Lee ("nom.arxiu");
# PROVA
 #@fasta = Lee ("hs6st.fasta");
# print @fasta; 
sub Lee { 
	my ($arx)  = @_;
	open (FILEHANDLE, "$arx") or die "No es troba l'arxiu"; # Obrir el fitxer
	my @Seq = <FILEHANDLE>; # Ara guarda tot en una matriu
	close (FILEHANDLE);
	return (@Seq);
}

# Funció d'obrir i guardarte el titol de fastas
# Titol_fasta ("nom.arxiu");

# PROVA
#$titol = Titol_fasta ("hs6st.fasta");
#print "$titol";

sub Titol_fasta {#posar ("arxiu") 
	my ($arx)  = @_;
	my @Seq = Lee ($arx);
	my $linia1 = shift @Seq ; # Guardar la primera posició en una variable escalar
 	return ($linia1);
}

#Funció d'obrir i guardarte la sequencia de fastas en una var. escalar
#Sequencia_fasta ("nom.arxiu");

#PROVA
# $seq = Sequencia_fasta ("hs6st.fasta");
# print "$seq";

sub Sequencia_fasta { #posar ("arxiu")
	my ($arx)  = @_;
	my @Seq = Lee ($arx);
	my $linia1 = shift @Seq ; # Guardar la primera posició en una variable escalar
 	chomp @Seq; 
	my $Seq_1 = join ("", @Seq); # Ara convertim aquesta matriu en una variable escalar
	return ($Seq_1);
}


# Funció de copiar un fasta amb titol i sequencia
# Tit_seq ("arxiu.fasta");

#PROVA
# ($tit,$seq) Tit_seq ("hs6st.fasta");

sub Tit_seq { #posar ("arxiu")
	my ($arx)  = @_;
	my ($linia_1) = Titol_fasta ($arx);
	my ($Seq_1) = Sequencia_fasta ($arx);
	return ($linia_1, $Seq_1);
}

# Funció de duplicar un fasta a txt (o el que sigui)
#Duplica ("arxiu.fasta","nouarxiu.txt");

#PROVA
#Duplica ("hs6st.fasta","Drosophila.txt");

sub Duplica { #posar ("arxiu", "nom del nou arxiu")
	my ($arx, $nom)  = @_;
	my ($linia1, $Seq_1) = Tit_seq ($arx);
	my %GenDM = ("$linia1" => "$Seq_1"); # Ara cream el hash
	# Ara l'imprimim a fora
	open (FILEHANDLE, ">$nom") or die "Hi ha hagut un error";
	print FILEHANDLE "\n$nom \n \n 
	Gen: \n $linia1 \n
	Sequencia: \n " . $GenDM{"$linia1"} . "\n ";
	print "\nS'ha creat el vostre arxiu $nom";
}


#3
# Funció que diu si totes les sequencies son igual de llarques o no
#Comp_llarg (seq1,seq2,...);

#PROVA
#$seq1 = ATTGTTGA;
#$seq2 = ATGTGGTA;
#Comp_llarg ("$seq1","$seq2","ATGGATTTGA","GGTATTA");


sub Comp_llarg { #posar totes les sequencies desitjades
	my @data = @_;
	my $LS = @data;
	my $j = 0;
	my $iguals = 0;
	for (my $i=0; $i < $LS; $i++){
		my $j++;
		my $li = length $data[$i];
		my $lj = length $data[$j]; 
		if ( $li == $lj){
			$iguals++;}
		}
	
	if ($iguals == $LS) {print "\n Totes les sequencies tenen la mateixa longitud";}
	else { warn "\n Les sequencies no tenen la mateixa longitud";}
}

# Funció de comparar contingut de sequencies

# Versio 2 sequencies
# Comp_2 ("seq1","seq2")

#PROVA
#Comp_2 ("ATG","ATG");

sub Comp_2 { #donar dues sequencies
	my ($val1,$val2) = @_;
	if ($val1 eq $val2) 
		{print " \n Les dues sequencies son iguals";}
	
	else {warn "\n Les dues sequencies no son iguals";}
}

#Versio moltes sequencies
# Comp_multi ("seq1","seq2",...)

#PROVA
#$seq1 = ATTGTTGA;
#$seq2 = ATTGTTTA;
#Comp_multi ("AGT","AGT","AGT","AGT");

sub Comp_multi { #posar totes les sequencies desitjades
	my @data = @_;
	my $LS = @data;
	my $j = 0;
	my $iguals = 0;
	for (my $i=0; $i < $LS; $i++){
		my $j++;
		if ( $data[$i] eq $data[$j]){
			$iguals++;}
		
	}
	if ($iguals == $LS) {print "\n Totes les sequencies son iguals";}
	else { warn "\n Les sequencies no son totes iguals";}
}

# Contar el tipo de cada elemento en una secuencia 
# Seq_count ("secuencia"), retorna 4 variables escalars de les 4 bases per ordre alfabetic
	
# PROVA
#$Sequ= ATGTACGTGCACGTACGAGTCTGACGTACGTACCAGTGAC;
#($a,$c,$g,$t)= Seq_count ("$Sequ");
#print "A: $a, C:$c, T:$t, G:$g";

sub Seq_count {
	my ($S) = @_;
	my @Sequ= split("",$S);

	# Creem el que ens acumula els numeros
	my $A = 0;
	my $C = 0;
	my $T = 0;
	my $G = 0;

	foreach my $name (@Sequ) {
		if ( $name eq "A"){  $A++;}
		elsif ( $name eq "C"){  $C++;}
		elsif ( $name eq "T"){  $T++;}
		elsif ( $name eq "G"){  $G++;}
	}

return ($A,$C,$G,$T);

}

# Traducir a homologa
# Homologa_DNA ("secuencia");

#PROVA
#$germ = Homologa_DNA ("TGGAGTTCTGG");
#print "$germ";

sub Homologa_DNA {
	my ($Sequ)=@_;
	$Sequ =~ tr/TACG/ATGC/;
	return ($Sequ);
}


#Traducir dna a rna 
# Transcriu_RNA ("secuencia");


#PROVA
#$germ = Transcriu_RNA ("TGGAGTTCTGG");
#print "$germ";

sub Transcriu_RNA {
	my ($Sequ)=@_;
	$Sequ =~ tr/T/U/;
	return ($Sequ);
}

#Traducir rna a dna
# Transcriu_invers ("secuencia");

#PROVA
#$germ = Transcriu_RNA ("TGGAGTTCTGG");
#$germ2 = Transcriu_invers ($germ);
#print $germ2;

sub Transcriu_invers {
	my ($Sequ)=@_;
	$Sequ =~ tr/U/T/;
	return ($Sequ);
}

#Extraer una secuencia de un largo determinado de un filehandle
# Extrae ("filehandle, posicio1, posicio2")

#PROVA
#$Exo = Extrae ("hs6st.fasta", 0, 362);
#print $Exo;

sub Extrae { #posar ("filehandle, posicio1, posicio2")
	my ($arx, $pos1, $pos2)  = @_;
	my ($Seq_1) = Sequencia_fasta ($arx);
	my $Exo = substr ($Seq_1, $pos1, $pos2 ); # Ara extreim informació d'aquesta variable escalar
	return ($Exo);
}

# Separar la secuencia de un fasta de n en n y imprimirla en un nou arxiu
# Duplica_part ("arxiu","nou arxiu", n); >> separara la sequencia del fasta de n en n

#PROVA
#Duplica_part ("hs6st.fasta","Drosopila.txt",60);

sub Duplica_part { #posar ("arxiu", "nom del nou arxiu", n)
	my ($arx, $nom, $n)  = @_;
	my ($linia1, $Seq_1) = Tit_seq ($arx);
	# Ara imprimim a fora el titol i la linia 1
	open (FILEHANDLE, ">$nom") or die "Hi ha hagut un error";
	print FILEHANDLE "\n$nom \n \n 
	Gen: \n $linia1 \n";
	#Omplir l'arxiu
	my $num = 0;
	my $l_Seq = length ($Seq_1);
	my $count = $n-1;

	while ($num < $l_Seq ){
		my $Ex = substr ($Seq_1, $num , $n);
		$num = $num + $count;
		print FILEHANDLE " $Ex \n"; 
	}
	close (FILEHANDLE);
	print "\n S'ha creat el vostre arxiu $nom";
}


#entrega
#Separar una escuencia fasta segun un archivo con informacion especificada como en  ej.opcional 3
# Interpreta ("Arxiu separador", "fasta");

#PROVA
# Interpreta ("Anotacions.txt","hs6st.fasta");

sub Interpreta {
	
	my ($arx, $nom)  = @_;
	#Llegim el fasta
	my ($Seq_1) = Sequencia_fasta ($nom);
	# Llegim "Arxiu separador"
	open (FILEHANDLE, "$arx") or die "No es troba l'arxiu separador;";
	my @Anot = <FILEHANDLE>;
	close (FILEHANDLE);
	# Passa3: interpretam 
	foreach my $var (@Anot) {
	my @mat = split ("\t",$var);
	# Ara tenim la sequencia que ens interessa qye es la de $mat[1] i $mat [2]
	my $num1 = $mat[1]-1;
	my $num2 = $mat[2]-$num1;
	# ara tenim les variables necessaries
	my $print  = substr ($Seq_1, $num1, $num2);
	print "\n C: $mat[0] \\ Nom: $mat[3]\n$print\n";

	}
}

#versio 2
# Interpreta_guarda ("Arxiu separador", "fasta");

#PROVA
#Interpreta_guarda ("Anotacions.txt","hs6st.fasta");

sub Interpreta_guarda {
	
	my ($arx, $nom)  = @_;
	#Llegim el fasta
	my ($Seq_1) = Sequencia_fasta ($nom);
	# Llegim "Arxiu separador"
	open (FILEHANDLE, "$arx") or die "No es troba l'arxiu separador;";
	my @Anot = <FILEHANDLE>;
	close (FILEHANDLE);
	
	# Passa3: interpretam 
	our @resultat;
	foreach my $var (@Anot) {
		my @mat = split ("\t",$var);
	# Ara tenim la sequencia que ens interessa qye es la de $mat[1] i $mat [2]
		my $num1 = $mat[1]-1;
		my $num2 = $mat[2]-$num1;
	# ara tenim les variables necessaries
		my $print  = substr ($Seq_1, $num1, $num2);
		push @resultat, "$print";
	}
	print "\n S'ha creat una matriu \@resultat amb contingut ";
	foreach my $val (@resultat) {print "\n$val\n";}
	}


1; 

