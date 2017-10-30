# encoding: utf-8

######STDIN#######
# nombre = raw_input("Como te llamas? ")
# print "Encantado, " + nombre

#######ARGV#######
# import sys

# if(len(sys.argv) > 1):
# 	print "Abriendo " + sys.argv[1]
# 	f = open("name.txt", "r")
# 	completo = f.read()
# else:
# 	print "Debes indicar el nombre del archivo"


# print "Encantado, " + completo

###########################
#	ASSIGNMENT NUMBER 2	  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# INPUT: Two positive integers a and b, a<b<10000 
# OUTPUT: The sum of all odd integers from a through b, inclusively


# START LOGIC


# # Get the two numbers
# import sys

# if(len(sys.argv) > 2):
# 	a = sys.argv[1]
# 	b = sys.argv[2]

# 	try:
# 		a = int(a)
# 	except ValueError:
# 		print "Your fist value is not a number"
# 		quit()

# 	try:
# 		b = int(b)
# 	except ValueError:
# 		print "Your second value is not a number"
# 		quit()

# 	if (a > b):
# 		print "The first given value must be lower than the second one"
# 		quit()

# 	if ((a|b)<0):
# 		print "Both numbers must be positive integers"
		
# 		quit()
# 	if ((a|b)>10000):
# 		print "Both numbers must be lower than 10000"
# 		quit()
# else:
# 	print "You must give two numbers"
# 	quit()

# # Get all the numbers that have to be processed

# numbers = range (a, b+1)

# # Set final result

# result = 0

# # Find the odd numbers & sum them to final result

# for n in numbers:
# 	if (n % 2 == 1):
# 		result = result + n

# # Give result 

# print result





###########################
#	ASSIGNMENT NUMBER 3	  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# INPUT: A DNA string s of length at most 1000 nt (nucleotides).
# OUTPUT: Four integers (separated by spaces) counting the respective number of times 
# that the symbols 'A', 'C', 'G', and 'T' occur in s.


# START LOGIC

# Get the string from a file
# import sys

# if(len(sys.argv) > 1):
# 	f = open(sys.argv[1], "r")
# 	string = f.read()
# 	f.close()
# else:
# 	quit( "You must give a file name")


# # Clean the string 
# string = string.replace("\n", "")
# string = string.replace (" ", "")


# # Check that the maximum length is accomplished
# if (len(string) >= 1000):
# 	quit( "The string is too long")

# # Count nucleotides
# A,C,G,T = 0,0,0,0

# for s in string:
# 	if (s == "A"):
# 		A = A+1
# 	elif (s == "C"):
# 		C = C+1
# 	elif (s == "G"):
# 		G = G + 1
# 	elif (s == "T"):
# 		T = T+1

# # Output
# print str(A) + " " + str(C) + " " + str(G) + " " + str(T)


###########################
#	ASSIGNMENT NUMBER 4	  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# INPUT: Two positive integers a and b, a<b<10000 
# OUTPUT: The sum of all odd integers from a through b, inclusively
#
# COMMENTS: It has been assum ed that the input is given in a file


# START LOGIC


# # Get the string from a file
# import sys

# if(len(sys.argv) > 1):
# 	f = open(sys.argv[1], "r")
# 	string = f.read()
# 	f.close()
# else:
# 	quit( "You must give a file name")


# # Clean the string 
# string = string.replace("\n", "")
# string = string.replace (" ", "")


# # Check that the maximum length is accomplished
# if (len(string) >= 1000):
# 	quit( "The string is too long")

# # Replace T by U
# string = string.replace ("T", "U")

# # Output
# print string

###########################
#	ASSIGNMENT NUMBER 5	  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# INPUT:  At most 10 DNA strings in FASTA format (of length at most 1 kbp each).
# 
# OUTPUT: The ID of the string having the highest GC‐content, followed by the GC‐content of that string (a default error of 0.001)


# # START LOGIC

# # Get the string from a file
# import sys

# if(len(sys.argv) > 1):
# 	with open(sys.argv[1]) as f:
# 		content = f.readlines()
# 	f.close()
# else:
# 	quit( "You must give a file name")

# # Count and compare the GC content of each FASTA entry
# oldGC = 0
# oldname = ""
# gccount = 0
# total = 0.0

# for c in content:
# 	if (c[0] == ">"):
# 		c = c.replace("\n", "")
# 		# When the line is an ID, the GC content is calculated and compared with the old one
# 		newGC = gccount/total
		
# 		if (newGC > oldGC):
# 			# The current best mark is updated as needed
# 			oldGC = newGC
# 			oldname = newname

# 		newname = c
# 		gccount = 0
# 		total = 0.0
# 	else:
# 		# When the line is not an ID, it is cleaned and the characters counted
# 		c = c.replace("\n", "")
# 		c = c.replace (" ", "") 
		
# 		for i in c:
# 			total = total +1
			
# 			if (i == ("G"|"C")):
# 				gccount = gccount + 1

# # OUTPUT
# print oldname + format(oldGC, '.3f')



###########################
#	ASSIGNMENT NUMBER 6  #	
###########################
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
#
# Input: A sorted list L of n numbers, and a number v. The list L can contain repeated values
# Output: Position of first occurrence of v in L, or raise a value error if v is not found in L 

import sys

if(len(sys.argv) > 3):
	v= int(sys.argv[1])
	L = sys.argv[2:]
	L = [int(i) for i in L]
else:
	quit("Debes indicar un numero y una lista")

def find_binary(L, v):
	left,right=0,len(L)
	# Simplest solution, as the only error is not finding the position when it is 0
	if (L[0] == v):
		return 0
	else:
		while (right - left) > 1:
			m= (left+right)/2
			if (L[m] == v):
				return m
			if (L[m] < v):
				left= m
			else:
				right= m
	raise ValueError('Value is not in list') 

	

def myMax( L ):
	if len(L)==0:
		raise ValueError('Empty list')
	mx=L[0]
	for i in L[1:]:
		if i > mx:
			mx= i
	return mx 

def findB(L,V):
	N = len(L)
	print N
	if N==0:
		raise ValueError('Value is not in list')
	if N==1:
		if L[0]== V:
			return 0
		raise ValueError('Value is not in list')
	m = N/2
	print m
	print "---"
	if V<L[m]:
		return findB(L[:m],V)
	return m + findB(L[m:],V)



result = findB(L,v)
print result
# raise ValueError('Value is not in list') 

# ASSIGNMENT number 7

# Input: A list L of n numbers. The list L can contain repeated values
# Output: Maximum value in L, or raise a value error if L is empty ( like built-in function max() ) 

