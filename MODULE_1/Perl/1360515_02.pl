#!/usr/bin/perl

use warnings;
use strict;

open (FILEHANDLE, $ARGV[0]) or die "File not found";

my @Text = <FILEHANDLE>;
close (FILEHANDLE);

open (FILEWRITE, ">Newfile.txt") or die "File creation error";

my $counter = 0;
foreach my $line (@Text){
	printf FILEWRITE "%03s %s",$counter, $line;
	$counter ++;
}

close (FILEWRITE);