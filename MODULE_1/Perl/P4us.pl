#!usr/bin/perl
use warnings;

use P4lib;
#RUTH GÓMEZ -1360515 
# La funció exacta i instruccions per la utilització de cada funció de la llibreria estan a l'arxiu practiques.pm
# Això és un mostrari de cada una d'elles


$S1 = "ATGGTATTCGAAT";
$S2 = "TGGGATGAGTTATGGTAT";
$S3 = "ATGGTATTCGAAT";
$S4 = "ATGGTATTCGCAT";

print "\n Utilitzarem les sequencies: \n \n\t$S1\n\n\t$S2\n\n\t$S3\n\n\t$S4\n\nper la nostra prova\n";

#CONCATENA
print "\nFuncio Concatena \n";

$Cadena = Concatena ("$S1","$S2","$S3","$S4");
print "\n\t$Cadena\n ";

#LEE
print "\nFuncio Lee \n";
@fasta = Lee ("hs6st.fasta");
print @fasta;

#TITOL_FASTA
print "\nFuncio Titol_fasta \n";
$titol = Titol_fasta ("hs6st.fasta");
print "\n\t$titol\n";

#SEQUENCIA_FASTA
print "\nFuncio Sequencia_fasta \n";
$seq = Sequencia_fasta ("hs6st.fasta");
print "\n\t$seq\n";

# TIT_SEQ
print "\nFuncio Tit_seq \n";
($tit1, $seq1) = Tit_seq ("hs6st.fasta");
print "\nTitol\n\t$tit1\nSequencia\n\t$seq1\n";

#DUPLICA
print "\nFuncio Duplica\n";
Duplica ("hs6st.fasta","Drosophila.txt");

#COMP_LLARG
print "\n\nFuncio Comp_llarg\n";
print "\n\tTotes les squencies\n\t";
Comp_llarg ("$S1","$S2","$S3","$S4");
print "\n\n\tSequencies 1 i 3\n\t";
Comp_llarg ("$S1","$S3");

#COMP_2
print "\n\nFuncio Comp_2\n";
print "\n\tSequencies 1 i 2\n\t";
Comp_2 ("$S1","$S2");
print "\n\n\tSequencies 1 i 3\n\t";
Comp_2 ("$S1","$S3");

#COMP_MULTI
print "\n\nFuncio Comp_multi\n";
print "\n\tTotes les squencies\n\t";
Comp_multi ("$S1","$S2","$S3","$S4");
print "\n\n\tSequencies 1 i 3\n\t";
Comp_multi ("$S1","$S3");

#SEQ_COUNT
print "\n\nFuncio Seq_count\n";
($a,$c,$g,$t)= Seq_count ("$S2");
print "\n\tA: $a, \tC:$c, \tT:$t, \tG:$g\n";

#HOMOLOGA_DNA
print "\n\nFuncio Homologa_DNA\n";
$germ = Homologa_DNA ("$S2");
print "\n\t$germ\n";

#TRANSCRIU_RNA
print "\n\nFuncio Transcriu_RNA\n";
$transc = Transcriu_RNA ("$S2");
print "\n\t$transc\n";

#TRANSCRIU_INVERS
print "\n\nFuncio Transcriu_invers\n";
$inv = Transcriu_invers ("$transc");
print "\n\t$inv\n";

#EXTRAE
print "\n\nFuncio Extrae\n";
$Exo = Extrae ("hs6st.fasta", 0, 362);
print "\n\t$Exo\n";

#DUPLICA_PART
print "\n\nFuncio Duplica_part\n";
Duplica_part ("hs6st.fasta","Drosophila2.txt",60);

#INTERPRETA
print "\n\nFuncio Interpreta\n";
Interpreta ("Anotacions.txt","hs6st.fasta");

#INTERPRETA_GUARDA
print "\n\nFuncio Interpreta_guarda\n";
Interpreta_guarda ("Anotacions.txt","hs6st.fasta"); 


