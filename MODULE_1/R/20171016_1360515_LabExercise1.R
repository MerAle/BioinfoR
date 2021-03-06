#
# Lesson	I.	R	language	Programming	Environment
# 
# Ruth Gomez Graciani - 1360515
# 2017/10/02
# Please write	the	code	and	the	final	value	of	the	variables	for	each	question.
#
#------------------------------------------------------------------------------------------
# 1-Create	a	vector	called	v	and	assign	the	values	(3.14,	123,	0.01)

v<-c(3.14,	123,	0.01)
v

#2- Create	a	new	vector	that	stores	three	values:	v,	123	and	v
a<-c('v', 123, 'v')
b<-c(v, 123, v)

# 3- Calculate	the	square	root	of	vector	v	and	store	it	in	a	new	varieble
my_sqrt<-sqrt(v)

# 4- Now	calculate	the	value	of	v	divided	by	my_sqrt
v/my_sqrt

# 5- Add	this	two	vectors:	(1,	2,	3,	4)	and	(0,100).	What	do	you	see?	Can	two	vectors	of	different	length	be	added?
c(1,2,3,4) + c(0,100)
# Yes, they can, because the largest vector is a multiple from the smaller one. The small vector is repeated twice in order to add it to the first one.

# 6- Create	a	sequence	of	numbers	from	1	to	19	using	the	:	operator
1:19

# 7- Now	use	seq()	to	create	a	sequence	from	1	to	10	incrementing	by	0.5
seq(1,10,0.5)

# 8- Use	seq()	to	generate	a	list	of	50	numbers	between	50	and	999	and	store the	list	in	a	variable	n
n<-seq(50, 999, length.out = 50)

# 9- Apply	the	length()	function	to	the	variable	n.	Which is	the	result?
length(n)

# 10- Now	generate	a	new	list	of	numbers	starting	from	1	that	has	the	same length	as	n	variable
l<-list(1:length(n))

# 11- Create	a	vector	with	100	zeros
d<-rep(0, 100)

# 12- Create	a	new	vector	with	10	repetitions	of	the	vector	("a",	"b",	"c")
e<-rep(c('a', 'b', 'c'), 10)

# 13- Now	create	a	new	vector	that	contains	10	a	letters,	then	10	b's,	then	10 c's	and	save	it	into	a	variable	called	abc
abc<-c(rep('a',10),rep('b',10),rep('c',10))

# 14- Create	a	vector	with	the	values	(1,100,-25,365)	and	save	it	into	v1	variable
v1<-c(1,100,-25,365)

# 15- now	create	a	new	variable	bool	that	gets	the	result	of	v1<1.	What	is	the result	of this	operation?	What	kind	of	value	you	see?
bool<-v1<1
# The result of the operation is TRUE when the inequality is accomplished, and FALSE when not, for each value of the vector. The value is a logical operator (str(bool[1]))

# 16- Now	take	abc	variable	from	question	13	and	generate	a	single	string	 value.	That	is,	something	like:	(a,b,c)	->	"abc"
abc<-paste(abc, collapse="")

# 17- Create	a	new	matrix	with	4	rows	and	5	columns	from	a	new	vector	that	contains	the	values	from 1	to	20.	Store	the	results	in	variable	m1
f<-c(1:20)
m1<-matrix(1:20, 4,5)

# 18- Now	create	a	vector	called	students	with	the	values ("Ana","John","Pedro","Joan")	and	create	a	new	matrix	adding	students	as a	new	column	to	m1	matrix.	What	happens	to	numeric	values?
names<-c ("Ana","John","Pedro","Joan")
m2<-matrix(c(m1,names),4,6)
# The numerical values have been converted to characters

# 19- Now	create	a	new	data.frame()	called	df	with	students	vector	and	m1 matrix.	What	difference	do	you	see	with	the	previous	matrix?
df<-data.frame(m1, names)
# The fata frame canplants$Precip_Min contain different value types

# 20- create	a	new	vector	with	the	labels	"name",	"age", "weight",	"bp",	 "rate",	"test".	Now	use	colnames()	to	set	the	colnames	attribute of	our	data	frame	df.	Show	your	final	data	frame 
labels<-c("name",	"age", "weight",	"bp",	 "rate",	"test")
colnames(df)<-labels
df

# 21- Calculate	the	mean	of	a	vector	with	values	(10,11,12)
g<-c(10,11,12)
mean(g)

# 22- Now	create	a	new	function	call	new_mean	that	receives	a	vector	as	a	 parameter,	then	calculates	the	sum	of	the	vector,	the	length	of	the	vector and	return	the	mean	of	the	vector.
new_mean<- function(vector){
  summatory<-sum(vector)
  numofels<-length(vector)
  return(summatory/numofels)
}

new_mean(g)

# 23- Use	sample()	function	to	simulate	a	rolling	dice.	That	is,	randomly	select four	numbers	between	1	and	6	with	replacement.
sample(1:6,4,replace = T)

# 24- Simulate	50	flips	of	an	unfair	two-sided	coin.	The	probabilities	here are 0.7	for	heads	and	0.3	for	tails.	Use	sample()	to	draw	a	sample	of	size	50.	 Store	the	results	in	variable	flip.	How	would	you	test	if	the	results	follow the	probability	defined?
coin<-c('heads', 'tails')
prob<-c(0.7,0.3)
flip<-sample(coin, 50, prob, replace = T)
table(flip)/50

# 25- How	would	you	generate	10	random	numbers	from	a	standard	normal distribution	with	a	mean of	150	and	a	standard	deviation	of	10?
rnorm(10, 150, 10)

# 26- Now,	how	would	you	generate	100	sets	of	random	numbers	like	the previous	question?	Save	results	in	a	variable	called	rp
rp<-matrix(nrow = 10, ncol = 100)

for(i in c(1:100)){
  rp[,i]<-rnorm(10, 150, 10)
  }

# 27- Use	colMeans()	function	to	find	the	mean	of	each	column	of	rp	and	plot a	histogram	
h<-colMeans(rp)
hist(h)

# 28- Create	a	vector	X	with	10	values	and	calculate	the	cumulative	sums	for	this	vector	using	a	for	loop.	
X<-sample(100, 10)
X
for (i in c(2:length(X)) ){
  X[i]<-X[i]+X[i-1]
}
X

# 29- Create	two	vectors,	Z1	and	Z2.	Z1	is	a	vector	of	20	elements	filled	with	
# 20	random	numbers	from	a	standard	normal	distribution.	Z2	is	a	string	of	
# 20	zeros.	Design	a	for	loop	that	counts	from	1	to	20.	For	each	value,	it	has	
# to	evaluate	if	the	value	is	greater	than	0.	For	all	those	values,	it	must	write	
# a	1	in	the	same	position	of	the	vector	Z2.	For	lower	than	0	values	it	must	
# write	a	-1.	Is	it	possible	to	do	the	same	thing	using	which()? How	would	you	
# do	it?
Z1<-rnorm(20)
Z2<-rep(0,20)
for (i in c(1:20)){
  if (Z1[i]>0){
    Z2[i]<-1
  }else{
    Z2[i]<- -1
    }
}

Z2<-rep(0,20)
Z2[which(Z1 >0)]<-1
Z2[which(Z1 <0)]<- -1

# 30- Now	we	are	going	to	import	a	data	file:plants.csv	and	use	read.table()	
# function	to	store	the	new	table	in	an	object	called	plants

plants<-read.table("/media/masterbio/BIOINFO/BIOINFORMATICS/MODULE_1/R/plants2017_10_13D19_4_42 (1).csv", sep = ",")

# 31- How	do	you	find	the	rows	and	columns	of	the	variable	plants?	And	the size	in	bytes?
nrow(plants)
ncol(plants)
rownames(plants)
object.size(plants)

# 32- How	would	you	see	the	first	rows	of	the	experiment?
head(plants)

# 33- What	information	is	summary()	providing	when	applied	to	the	
# experiment	variable?	What	NA	plants$Precip_Minmeans?	What	information	is	str()	providing?
summary(plants)
summary(plants$pH_Min)
# Not Available (it is missing data)
str(plants)

# 34- Create	a	function	to	calculate	the	minimum	Temp_Min_F	and	the	
# average	Precip_Min	of	the	table	plants

Calculate_plants<-function(plants){
  minimum<-min(plants$Temp_Min_F, na.rm = TRUE)
  average<-mean(plants$Precip_Min, na.rm = TRUE)
  return(c(minimum, average))
}

Calculate_plants(plants)


# To	be	evaluated:
# Create	a	function	that:
#   • Creates	a	20	by	20	matrix	of	0	values
# • Places	in	a	random	position	inside	the	matrix	one	vector	of	size	6	and	
# represents	it	with	six	consecutive	"1"	values.	This	vector	will	be	our	
# ship
# • Receives	two	vectors	of	six	values	as	inputs.	X	and	Y.	Both	vectors	
# store	six	values	between	1	and	20	and	represent	coordinates	in	the	
# matrix
# • The	function	returns	a	vector	with	six	values	depending	if	the	
# coordinates	have	hit	or	miss	our	ship.	Example=("hit",	"miss",	"miss",	
#                                                 "miss",	"miss",	"hit")
# Make	the	number	of	ships	in	the	matrix	a	parameter	given	by	the	user	
# and	export	the	matrix	to	a	text	file.

Battleship<-function(X, Y, ships){
  # Create the empty matrix
  m1<-matrix(0, 20, 20)
  
  # Iterate over ships
  for (s in c(1:ships)){
    # We avoid solapping ships
    done<-F
    while(done == F){
      # Place in a random position, and random direction
      variablenum<-c(1:6)+sample(c(1:14),1)
      fixnum<-sample(c(1:20), 1)
      if(sample(c(0:1),1)==0){
        if (sum(m1[variablenum, fixnum]) == 0){
          m1[variablenum, fixnum]<-c(rep(1,6))
          done <-T
        }
      }else{
        if (sum(m1[fixnum, variablenum]) == 0){
          m1[variablenum, fixnum]<-c(rep(1,6))
          done <- T
        }
      }
    }
  }
  
  # Creates result
  result<-as.factor(diag(m1[X,Y]))
  levels(result)<-c('miss', 'hit')

  # Export matrix and return result
  write.table(m1, 'matrix.txt', col.names = F, row.names = F, quote =  F)
  return(as.character(result))

}



