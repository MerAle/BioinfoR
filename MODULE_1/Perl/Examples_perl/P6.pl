#!/usr/bin/perl
use warnings

# .-. PER Y BASES DE DATOS .-. #
# Conexion a bases de datos loacles desde Perl
# Nos haria falta el modilo DBI (DataBaseInterface)
# entonces pondriamos

use DBI;
use DBD::mysql;  # nos conecta con el otro programa

# DBI tiene una accion que lo que hace es importar?
# le tenemos que dar el sitio, usuario y contraseña

$dsn = "DBI:mysql:host=localhos;port=3306"; #por ejemplo
$usr = "root";
$password = "pwd";

#ahora ya tenemos todo lo necesario para usar el connect

$bdd = DBI->connect ($dsn, $usr, $password);
$bdd->do("USE bdd1");

# Ara tenim a $bdd la nostra base de dades preparada amb el USE, i la podem emplear

# Preparam una ordre en mysql, com INSERT INTO

$ordre = "INSERT INTO taula1 ( camp1, camp2)
	VALUES (?,?)"; #amb els ?, podem introduir despres les dades, es com una sub cutre
	
# I executem
	#prepare = prepara i diu si hi ha errors
	#execute
	#finish

$sth = $bdd->prepare ($ordre); #sth = statement handle
$sth -> execute (valor 1, valor 2); #si tenim els valors, es deixa ()
$sth -> execute (valor 2, valor 3);
#aqui podem introduir whiles, ifs...
$sth -> finish ();

