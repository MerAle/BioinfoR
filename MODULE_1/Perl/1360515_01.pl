#!/usr/bin/perl

use warnings;
use strict;

# Author: Ruth Gómez Graciani
# Date: 201711.02
# Description: Testing Perl possibilities - first lecture exercise

print "Hello, user. In this script we'll learn about Perl programming\n\n";

# 1. Numbers: integers, floats, hexadecimal. 

my $number_int = 3;
my $number_fl = 3.0003;
my $number_hex = '0xAf';

print "FIRST LESSON: there are different kind of numbers:
  \n\t This is an integer: $number_int 
  \n\t This is a float: $number_fl 
  \n\t This is an hexadecimal: $number_hex, but it has to be interpreded to ";
print hex $number_hex;
print "\n\n";

# 2. Strings. 

my $string = 'Hello, this is a string named $string';

print "SECOND LESSON: text is also accepted: 
	\n\t $string \n\n";

# 3. Arrays. Including automatic extension and range selection.

my @array = ("A","C","T","G");

print "THIRD LESSON: we can store scalars into arrays: 
  \n\t Here we get access to the first element in te array: $array[0] 
  \n\t Now the first to the third elements: @array[0..2]
  \n\t Here we have the entire array: @array";
my @array_rev = reverse(@array);
print "
  \n\t Finally, you can have your array reversed: @array_rev \n\n";
  
# 4. Interpolation: of scalars and arrays. 

print "FOURTH LESSON: In the previous statements we have been interpolating scalars and arrays\n\n";

#5.Hashes. Defined with fat commas. 

my %Type = ("A" => "Purine", "G" => "Purine", "C" => "Pirimidine", "T" => "Pirimidine");

print "FIFTH LESSON: We can associate values to keys and access them easily:
  \n\t The raw hash doesn't make any sense: ";
  print %Type;
print "\n\n\t But we can print the hash in a visible way: 
	\n\t\t T: $Type{'T'}
	\n\t\t A: $Type{'A'}
	\n\t\t G: $Type{'G'}
	\n\t\t C: $Type{'C'}\n\n";

# 6. Operators. Numeric and strings. 

my $string_cont = " and it was updated with an += operator";
$string .= $string_cont;
$number_int *= 1000;
print "SIXTH LESSON: Operators update our values fastly:
  \n\t Do you remember our first string? It has evolved!: \n $string
  \n\t And the first integer we saw has been multiplied by 1000!: $number_int\n\n";

# 7. Assignments. Operators and List assignments. 

my ($a, $b, $c, $d) = ('First is ', 'Second is ', 'Third is ', 'Fourth is ');
print "SEVENTH LESSON: We can make our variables all at once: 
	\n\t These variables were made with a list assignment: \n\t $a, $b, $c, $d
	\n\t But they lack information!! we can use a .= operator to improve them: \n\t";

$a .= 'a';$b .= 'b';$c .= 'c';$d .= 'd';

print "$a, $b, $c, $d \n\n";

# 8. Conditional execution. 

print "EIGTH LESSON: The program can obey our desires with conditionals:
	\n\t Do you remembrer $number_int? Now we will print it only if it's larger than 1000: \n";

if ($number_int > 1000)
	{
	print "\n\t$number_int succeeded!";
	} else {
	print "\n\t This number is too small :(";	
	}


# 9. Loops. Foreach and while. 

print "\n\nNINTH LESSON: We can repeat our orders:
	\n\t Remember the hash printing? It was awfully manual, we can repeat it with a loop: \n";

foreach my $key (keys %Type) {
	print "\n\t\t $key: $Type{$key}";
}

print "
	\n\t That is much shorter to write!\n\n";

# 10. Stacks

my $last_el = "U";

print "TENTH LESSON: Stacks
	\n\tDo you remember the array? @array";

push(@array, $last_el);
print "
  \n\t We can include new scalars, like $last_el, to the end with push: @array";
unshift(@array, $last_el);
print "
  \n\t and to the head of the array with unshift: @array
  \n\t If you want to reverse that, you only have to execute pop or shift!\n";


