# encoding: utf-8

###########################
#	ASSIGNMENT NUMBER 6	  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# INPUT: An RNA string s corresponding to a strand of mRNA (of length at most 10 kbp).
# 
# OUTPUT: The protein string encoded by s
#
# OTHER REQUIREMETS: It must be a function anmed decode
#
# COMMENTS: Some documentation has been researched
#	PYTHON DICTIONARIES: https://docs.python.org/2/tutorial/datastructures.html
#	GENETIC CODE (perl hash, translated to python dictionary): https://bioperl.wordpress.com/2011/04/14/genetic-code-perl-hash/

#--------------------------------------------------------------------------------------------------

# FUNCTIONS

##### isitRNA ####
# Checks that a string is made of a certain group of characters
# The variables needed are a string and a set of values
# Example of usage: isitRNA('HELLOWORLD', set('HELO'))
def isitRNA(string, group):
	for s in string:
		if (s not in group ):
			return False
	return True

##### decode ####
# Translates an RNA string into Protein
# The variable needed is an RNA string
# Example of usage: decode('AUGUAUGUACUAGAUC')
def decode(string):
	# Genetic code
	codeDict = {
		'UCA' : 'S', # Serine
		'UCC' : 'S', # Serine
		'UCG' : 'S', # Serine
		'UCU' : 'S', # Serine
		'UUC' : 'F', # Phenylalanine
		'UUU' : 'F', # Phenylalanine
		'UUA' : 'L', # Leucine
		'UUG' : 'L', # Leucine
		'UAC' : 'Y', # Tyrosine
		'UAU' : 'Y', # Tyrosine
		'UAA' : '_', # Stop
		'UAG' : '_', # Stop
		'UGC' : 'C', # Cysteine
		'UGU' : 'C', # Cysteine
		'UGA' : '_', # Stop
		'UGG' : 'W', # Tryptophan
		'CUA' : 'L', # Leucine
		'CUC' : 'L', # Leucine
		'CUG' : 'L', # Leucine
		'CUU' : 'L', # Leucine
		'CCA' : 'P', # Proline
		'CAU' : 'H', # Histidine
		'CAA' : 'Q', # Glutamine
		'CAG' : 'Q', # Glutamine
		'CGA' : 'R', # Arginine
		'CGC' : 'R', # Arginine
		'CGG' : 'R', # Arginine
		'CGU' : 'R', # Arginine
		'AUA' : 'I', # Isoleucine
		'AUC' : 'I', # Isoleucine
		'AUU' : 'I', # Isoleucine
		'AUG' : 'M', # Methionine
		'ACA' : 'T', # Threonine
		'ACC' : 'T', # Threonine
		'ACG' : 'T', # Threonine
		'ACU' : 'T', # Threonine
		'AAC' : 'N', # Asparagine
		'AAU' : 'N', # Asparagine
		'AAA' : 'K', # Lysine
		'AAG' : 'K', # Lysine
		'AGC' : 'S', # Serine
		'AGU' : 'S', # Serine
		'AGA' : 'R', # Arginine
		'AGG' : 'R', # Arginine
		'CCC' : 'P', # Proline
		'CCG' : 'P', # Proline
		'CCU' : 'P', # Proline
		'CAC' : 'H', # Histidine
		'GUA' : 'V', # Valine
		'GUC' : 'V', # Valine
		'GUG' : 'V', # Valine
		'GUU' : 'V', # Valine
		'GCA' : 'A', # Alanine
		'GCC' : 'A', # Alanine
		'GCG' : 'A', # Alanine
		'GCU' : 'A', # Alanine
		'GAC' : 'D', # Aspartic Acid
		'GAU' : 'D', # Aspartic Acid
		'GAA' : 'E', # Glutamic Acid
		'GAG' : 'E', # Glutamic Acid
		'GGA' : 'G', # Glycine
		'GGC' : 'G', # Glycine
		'GGG' : 'G', # Glycine
		'GGU' : 'G'  # Glycine
	}
	
	start = 0
	protein = ""

	# Moves along the sequence in groups of 3 characters and translates them
	while start < len(string):
		end = start + 3
		codon = string[start:end]
		if (len(codon) == 3):
			result = codeDict[codon]
			protein = protein + result
		start = end

	# A protein is the result	
	return protein

#--------------------------------------------------------------------------------------------------

# Get the string from a file
import sys

if(len(sys.argv) > 1):
	f = open(sys.argv[1], "r")
	string = f.read()
	f.close()
else:
	quit( "You must give a file name")

# Clean the string 
string = string.replace("\n", "")
string = string.replace (" ", "")

# Check that it is RNA and translate or quit
if (isitRNA(string, set('AGCU'))):
	print decode(string)
else: 
	quit("The string is not RNA")

