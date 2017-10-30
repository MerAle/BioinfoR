# encoding: utf-8

###########################
#	ASSIGNMENT NUMBER 4	  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# INPUT: A DNA string t of length at most 1000 nt (nucleotides).
#
# OUTPUT: The trasnscribed RNA string of t
#
# ASSUMPTIONS: It has been assumed that the input is given in a file, 
# and that it can be written in mayusc. or small caps.
# 
# COMMENTS: The mayusc. or small caps format will be conserved

#--------------------------------------------------------------------------------------------------

# Get the string from a file & check that the maximum length is accomplished
import sys

if( len( sys.argv ) > 1 ):
	f = open( sys.argv[1], "r" )
	string = f.read()
	f.close()

	if ( len( string ) >= 1000 ):
		quit( "The string is too long" )
else:
	quit( "You must give a file name" )

# Replace T by U
string = string.replace ( "T", "U" )
string = string.replace ( "t", "u" )

# OUTPUT
print string