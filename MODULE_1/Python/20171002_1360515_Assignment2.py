# encoding: utf-8

###########################
#	ASSIGNMENT NUMBER 2	  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# INPUT: Two positive integers a and b, a<b<10000 
#
# OUTPUT: The sum of all odd integers from a through b, inclusively
#
# ASSUMPTIONS: Here it is assumed that a and b must be given in order (first a and then b)
#
# COMMENTS: There are many ways to do the checkpoint; in this case if the input is not correct 
# the program warns about the first error to be found and closes. Other options are to request 
# numbers until the input is correct without turning off the program, or quit the program warning 
# about all the errors that have occured, for example. 

#--------------------------------------------------------------------------------------------------

# Get the two numbers & check that the format is correct
import sys

if ( len( sys.argv ) > 2 ):
	a = sys.argv[1]
	b = sys.argv[2]

	try:
		a = int(a)
	except ValueError:
		quit( "Your fist value is not a number" )

	try:
		b = int(b)
	except ValueError:
		quit( "Your second value is not a number" )

	if ( a > b ):
		quit( "The first given value must be lower than the second one" )
		

	if ( ( a | b ) < 0 ):
		quit( "Both numbers must be positive integers" )
		
	
	if ( ( a | b ) > 10000 ):
		quit( "Both numbers must be lower than 10000" )
else:
	quit( "You must give two numbers" )
	
# From all the range of numbers, find the odd ones & sum them to the final result 
result = 0

for n in range ( a, b + 1 ):
	if ( n % 2 == 1 ):
		result = result + n

# OUTPUT
print result











