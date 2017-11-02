#!usr/bin/perl
use warnings;

# .-. EL MY Y OUR .-. #
# Las variables globales (our) son para todo el programa, las locales (my) solo en la parte del programa que se declara
# El use strict obliga a declarar las variables siempre
# Controlaremos errores tipograficos en las nuevas variables que creemos

# FUNCION EXTRA: 
	# rand crea un numero aleatorio 
		# $var = rand (19);

# .-. SUBRUTINAS .-. # 
# Ens serveixen per emmagatzemar una tasca que volguem repetir
# Es poden emmagatzemar en llibreries i moduls

###########
# DEFINIR #
###########
# Para crear una subrutina hacemos
# sub nombre {};
# La subrutina puede estar en cualquier lugar, incluso despues de un exit, que sale del programa
# Cuando tu invocas la subrutina la busca por TODO EL DOCUMENTO
# Por convenio se ponen abajo del todo
print "\n DEFINIR \n";

#Exemple
	Holi();
	sub Holi {
		print "\nHoli desde la subrutina";
	}
#####################
# PASSAR PARAMETRES #
#####################
# Ens permet aplicar la subrutina a lo que noltros volguem
# @_ almacena los valores que le pasamos el ejecutar la subrutina
	# ($,$) = separa en variables escalares
	# (@) = copia @_ entero en la matrixz nuevas
	# ($,$,@) = quitamos titulo, subtitulo, y guardamos secuencia
	### NOT (@,@) = no tiene sentido
print "\n PASSAR PARAMETRES \n";

# Exemple
	$val1 = 10;
	$val2 = 25;
	sumValues ($val1, $val2);
	sub sumValues {
        my ($var1, $var2) = @_ ; #Los valores se guardan en esta matriz 
        my $total = $var1 + $var2;# El my hace que estos valores esten en la subrutina solamente 
		print "\n\nLa suma es $total";
	}
# Exercici 1
	print "\n\n como te llamas?\n";
	$nombre = <STDIN>;
	chomp ($nombre);
	saludame ($nombre);
	sub saludame {
		my ($nombre) = @_;
		print "\n\nHoli $_[0]";
	}

#####################
# TORNAR PARAMETRES #
#####################
# Ens permet emmagatzemar el resultat de la subrutina
# Per retornar valors, no cal (no se sol) imprimirlos, basta dirli "return"
print "\n TORNAR PARAMETRES \n";

#Exemple
	$val1 = 10;
	$val2 = 25;
	$total = sumValues ($val1, $val2);
	print "\n\nEl total es $total";
	sub sumValues {
        my ($var1, $var2) = @_ ;
        my $result = $var1 + $var2;
        return ($result);
	}
#Los returns se pueden devolver con ifs incluidos
	$compara = compareValues (11,11);
	print "\n$compara";
	sub compareValues {
        my ($var1, $var2) = @_ ;
		if ($var1 > $var2) {
                return ($var2);
        }
		elsif ($var1 < $var2) {
                return ($var1);
        }
		else {return ("les variables son iguals");}
}
# Ademas el return es como un pequeño exit; finaliza la subrutina

# .-. LLIBRERIES I MODULS .-. # 
#Les subrutines 
#ens serveixen per reutilitzar el mateix codi diverses vegades, però,
# i si volem reutilitzar les subrutines en programes diferents? 
#En aquest cas podem crear Mòduls o Paquets (Modules/Packages).
# En aquest cas, l’arxiu d’un mòdul acaba amb .pm.
# Tant el programa com l’arxiu del mòdul han d’estar 
#a la mateixa carpeta, si no, hauríem d’indicar 
#a quina carpeta es troba el mòdul.

#LLIBRERIA
# Una llibreria es un arxiu de perl que te les notres subrutines
# El seu nom es nom.pm (perl module)
#Dins d'un mòdul és obligatori acabar amb "1;". 
# use nombre sin .pm;
# y ponemos las sub directamente

#PAQUET
#lA primera instrucció del mòdul es "package" més el nom del paquet.
# L’arxiu s’ha de dir igual (més l’extensió .pm).
#La unica diferencia es que empieza por package nombre sin .pl
#Para invocarlo use y nombre, pero tenemos qeu decir 
#nombre del paquete->subrutina, porque nos obliga a especificar la subrutina
# Tambien acaba en 1;

# Podem utilitzar les subrutines amb el nostre codi actual, utilitzant la llibreria
# amb use!! (com si fos una bdd de mysql)

#>> P4lib.pm es la llibreria
#>> P4us.pl utilitza la llibreria


