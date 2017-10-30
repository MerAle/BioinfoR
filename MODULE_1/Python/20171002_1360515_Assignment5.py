# encoding: utf-8

###########################
#	ASSIGNMENT NUMBER 5	  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# INPUT:  At most 10 DNA strings in FASTA format (of length at most 1 kbp each).
# 
# OUTPUT: The ID of the string having the highest GC‐content, followed by the 
# GC‐content of that string (a default error of 0.001)
#
# ASSUMPTIONS: The 10 DNA strings and the length of the sequencewill be respected by the user

#--------------------------------------------------------------------------------------------------

# Get the string from a file
import sys

if( len( sys.argv ) > 1 ):
	with open( sys.argv[1] ) as f:
		content = f.readlines()
	f.close()
	# A fake new ID is added to ensure that all the sequences are compared in the loop
	content.append(">")
else:
	quit( "You must give a file name" )

# Count and compare the GC content of each FASTA entry
oldGC = 0
oldname = ""
gccount = 0
total = 1.0

for c in content:
	if ( c[0] == ">" ):
		# When the line is an ID, the GC content is calculated and compared with the old one
		c = c.replace( "\n", "" )
		newGC = gccount / total
		
		if ( newGC > oldGC ):
			# The current best mark is updated as needed
			oldGC = newGC
			oldname = newname

		newname = c
		gccount = 0
		total = 0.0
	else:
		# When the line is not an ID, it is cleaned and the characters counted
		c = c.replace( "\n", "" )
		c = c.replace( " ", "" ) 
		
		for i in c:
			total = total + 1
			
			if ( ( i == "G" ) | ( i == "C" ) ):
				gccount = gccount + 1

# OUTPUT
print oldname + " " + format( oldGC, '.3f' )


