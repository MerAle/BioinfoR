# encoding: utf-8

###########################
#	ASSIGNMENT NUMBER 3	  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# INPUT: A DNA string s of length at most 1000 nt (nucleotides).
#
# OUTPUT: Four integers (separated by spaces) counting the respective number of
# times that the symbols 'A', 'C', 'G', and 'T' occur in s.
# 
# ASSUMPTIONS: It has been assumed that the input is given in a file, and that 
# other characters besides ACGT don't interfere with the count, they are simply
# not considered, including 'a', 'c', 't', and 'g'. 

#--------------------------------------------------------------------------------------------------

# Get the string from a file & check that the maximum length is accomplished
import sys

if ( len( sys.argv ) > 1 ):
	f = open( sys.argv[1], "r" )
	string = f.read()
	f.close()

	if ( len( string ) >= 1000 ):
		quit( "The string is too long" )
else:
	quit( "You must give a file name" )

# Count nucleotides
A, C, G, T = 0, 0, 0, 0

for s in string:
	if ( s == "A" ):
		A = A + 1
	elif ( s == "C" ):
		C = C + 1
	elif ( s == "G" ):
		G = G + 1
	elif ( s == "T" ):
		T = T + 1

# OUTPUT
print str(A) + " " + str(C) + " " + str(G) + " " + str(T)

