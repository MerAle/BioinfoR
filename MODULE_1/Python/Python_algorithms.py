# encoding: utf-8

# ALGORITHMS IN PYTHON

import sys

#------------------------------------------------------------------

# BASIC ALGORITHMS ON STRINGS, LISTS, TUPLES AND DICITIONARIES

## Reverse & Reverse-Complement string

### Compute the reverse of a sequence

def rev( sequence ) :
  reverse = ""
	i = len( sequence ) - 1

	while i >= 0 :
		reverse += sequence[i] 
		i = i - 1
	
  return reverse

def rev2( sequence ) :
	reverse = ""
	
  for p in range( len( sequence ) - 1, -1, -1 ) :
		reverse += sequence[p]
	
  return reverse

# "" . join( sequence[i] for i in range( len( sequence ) - 1, -1, -1 ) )

### Compute the reverse complement of a sequence

def rc( sequence) :
	codeDict = {
		'A' : 'T', 
		'T' : 'A', 
		'G' : 'C', 
		'C' : 'G', 
		'N' : 'N' 
	}
	
	# reverse = ""
	# for p in range( len( sequence ) - 1, -1, -1 ) :
	# 	reverse += codeDict[ sequence[i] ]

	return "" . join( codeDict[ sequence[i] ] for i in range( len( sequence ) - 1, -1, -1 ) )

## Hard-trim & Quality-trim of FASTQ sequences

### Return tuple of sequence and qualities hard-trimmed to the left and right

def hardtrim( sequence, qualities, left, right ) :
  sequence = sequence[ left : len( sequence ) - right ]
  qualities = qualities[ left : len( qualities ) - right ]
  return ( sequence, qualities )

### Returnt tuple of seqeunce and qualities quality-trimmed 

def quality_trim( sequence, qualities, min_qscore ) :
 	for p in range( len( qualities ) - 1, -1, -1 ) :
		if ( ord( qualities[p] ) - 33 < min_qscore ) :
			qualities = qualities[ : p ]
			sequence = sequence[ : p ]
		else :
			break	
	return (sequence, qualities)

def quality_trim2( sequence, qualities, min_qscore ) :
  left, right = 0, 0
  
  for p in range( len( qualities ) - 1, -1, -1 ) :
    if ( ord( qualities[p] ) - 33 < min_qscore ) :
      right += 1
    else:
      break

  for p in range( 0, len( qualities ) ) :
    if ( ord( qualities[p] ) - 33 < min_qscore ) :
      left += 1
    else :
      break

  return  hardtrim( sequence, qualities, left, right )

# ALSO, we can count the right trim and after that call hardtrim

## Exact string matching

### Assess if two strings are exactly the same

def exact_match( pattern, text ) :
  return pattern == text # DONT OvERTHINK!!!!

### Find a pattern (fragment) in a database (reference genome)

def all_exact_matches( pattern, reference ) :
  result = []
  
  for i in range( 0, len( reference ) - len( pattern ) + 1 ) :
 	  if exact_match( pattern, reference[ i : i + len( pattern ) ] ) :
 	    result += [i]

  return result

# ----------------------------------------------------------------

# CASES OF USE

# -----------------------------------------------------------------

# GREEDY ALGORITHMS

## Sequence pairwaise mismatch distance

### Hamming distance between two strings

def hamming_distance( pattern, text ) :
	if len( pattern ) != len( text ) : return float( 'inf' )
	result = 0
	
  for i in range( 0, len( pattern ) ) : 
	  if pattern[i] != text[i] :
		  result += 1
	
  return result

### Given a pattern and a database, list the positions of the database with a hamming distance below a threshold

def all_hamming_matches( pattern, reference, threshold ) :
  result = []
  
  for i in range( 0, len( reference ) - len( pattern ) + 1 ) :
 	  if hamming_distance( pattern, reference[ i : i + len( pattern ) ] ) <= threshold :
 	    result += [i]
  
  return result

## Profiling DNA coverage and transitions/transversions

### Find the coverage of a reference from a list of patterns that have to be located in the best position

def coverage( patternlist, reference ) : 
	result = ""
	dicc = {}

	for i in range(0, len( reference ) ) :
		dicc[i] = 0
	
  for pattern	in patternlist :
		bestmatch = len( pattern )
		bestfirstposition = ""
		
    for i in range( 0, len( reference ) - len( pattern ) + 1 ) :
			newmatch = hamming_distance( pattern, reference[ i : i + len( pattern ) ] )
	 	
    	if newmatch < bestmatch :
	 			bestmatch = newmatch
	 			bestfirstposition = i	 			
		
    for i in range( bestfirstposition, bestfirstposition + len( pattern ) ) :
	 		dicc[i] += 1
	
  for k in dicc : 
		result += str( dicc[k] )
	
  return result

# ----------------------------------------------------------------

# CASES OF USE

## CASE OF USE 4: Naive greedy snp caller

def SNP_caller( patternlist, reference ) : 
	result = ""
	dicc = {}

	for i in range( 0, len( reference ) ) :
		dicc[i] = [ reference[i] ]
	
  for pattern	in patternlist :
		bestmatch = len( pattern )
		bestfirstposition = ""
		
    for i in range( 0, len( reference ) - len( pattern ) + 1 ) :
			newmatch = hamming_distance( pattern, reference[ i : i + len( pattern ) ] )
	 		
      if newmatch < bestmatch :
	 			bestmatch = newmatch
	 			bestfirstposition = i	 			
		
    for i in range( bestfirstposition, bestfirstposition + len( pattern ) ) :
	 		dicc[i] += pattern[ i - bestfirstposition ]
	
  finaldicc = []

	for k in dicc :
		bol = True
		
    if len( dicc[k] ) == 1 : 
      bol = False
		elif ( len( dicc[k] ) == 2 ) & ( dicc[k][0] == dicc[k][1] ) :
      bol = False
		else:
			for n in dicc[k][2:] :
				if n != dicc[k][1] :
					bol = False
			if dicc[k][1] == dicc[k][0] :
				bol = False
		
    if bol == True:
      finaldicc += [k]
	
  return finaldicc

#---------------------------------------------------------------

reference = "GABGGGGGGABCDEFGMIGUELGGGGWP"
patternlist = ['ABCP', 'BCPE', 'CPEFGM', 'PEFGMI' ]

print SNP_caller(patternlist,reference)






















