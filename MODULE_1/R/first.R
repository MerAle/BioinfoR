# this is my first R progr

# m1<-matrix(c(1,2,3,4,5,6), 3, 3)
# 
# 
# m1[which(m1[,2]>=5),]
# m1[which(m1[,1]>=1),c(2,3)]
# 
# m1[,3]
# 
# 
# values <-sample(2:39,4)
# line1<-paste(paste(rep("-", values[1]-2), collapse=""), "> ", values[1], collapse = "", sep = "")
# line2<-paste(paste(rep("-", values[2]-2), collapse=""), "> ", values[2], collapse = "", sep = "")
# line3<-paste(paste(rep("-", values[3]-2), collapse=""), "> ", values[3], collapse = "", sep = "")
# line4<-paste(paste(rep("-", values[4]-2), collapse=""), "> ", values[4], collapse = "", sep = "")
# line5<-paste(rep(0:9,4), collapse = "")
# line6<-sprintf("%-10d%-10d%-10d%-10d", 0, 1, 2, 3)
# line1;line2;line3;line4;line5;line6
# 
# 
# seq1<- c('ATG','GCC', 'ACG', 'GCA', 'CCG','ATA')
# seq2<-c('ATG', 'CCG', 'ATA', 'ACG', 'GCC', 'GCA')
# setequal(seq2, seq2)


camel_race <- function (racer = 'Camel', participants = 4)
{
  values <-sample (2:39,participants);
  line1 <- paste( paste( rep( "-", values[1]-2), collapse="" ), ">",values[1],collapse="",sep="");
  line2 <- paste( paste( rep( "-", values[2]-2), collapse="" ), ">",values[2],collapse="",sep="");
  line3 <- paste( paste( rep( "-", values[3]-2), collapse="" ), ">",values[3],collapse="",sep="");
  line4 <- paste( paste( rep( "-", values[4]-2), collapse="" ), ">",values[4],collapse="",sep="");
  line5 <- paste( rep( 0:9, 4 ), collapse="");
  line6 <- sprintf("%-10d%-10d%-10d%-10d",0,1,2,3 );
  cat("\n");
  leader_num <- which.max( values );
  cat( sprintf( "%s %d leading the race!! At step: %d !!\n", racer, leader_num, values[ leader_num ]));
  cat("\n");
  cat(line1,"\n");
  cat(line2,"\n");
  cat(line3,"\n");
  cat(line4,"\n");
  cat(line5,"\n");
  cat(line6,"\n");
  
}



camel_race_for<- function (racer = 'Camel', participants = 4)
{
  values <-sample (2:39,participants);
  cat("\n");
  leader_num <- which.max( values );
  cat( sprintf( "%s %d leading the race!! At step: %d !!\n", racer, leader_num, values[ leader_num ]));
  cat("\n");
  
  for (i in 1:participants){
    cat( paste( paste( rep( "-", values[i]-2), collapse="" ), ">",values[i],collapse="",sep=""), "\n");
  }

  cat(paste( rep( 0:9, 4 ), collapse=""),"\n");
  cat(sprintf("%-10d%-10d%-10d%-10d",0,1,2,3 ),"\n");
  
}

camel_race_while<- function (racer = 'Camel', participants = 4)
{
  values <-sample (2:39,participants);
  cat("\n");
  leader_num <- which.max( values );
  cat( sprintf( "%s %d leading the race!! At step: %d !!\n", racer, leader_num, values[ leader_num ]));
  cat("\n");
  i <-1
  while (i <= participants){
    cat( paste( paste( rep( "-", values[i]-2), collapse="" ), ">",values[i],collapse="",sep=""), "\n");
    i <- i+1
  }
  
  cat(paste( rep( 0:9, 4 ), collapse=""),"\n");
  cat(sprintf("%-10d%-10d%-10d%-10d",0,1,2,3 ),"\n");
  
}


fish_race<- function (racer = 'Squid',symbol = "<:彡" ,participants = 4, max_step = 39)
{
  if (participants >= max_step-2){
    cat (sprintf('You have made a mistake, the number of %ss will now be reduced to %d \n', racer, max_step-2))
    participants <- max_step-2
  }
  values <-sample (3:max_step,participants);
  cat("\n");
  leader_num <- which.max( values );
 
  if (values[leader_num] == max_step){
    cat( sprintf( "%s %d won the race!! At step: %d !!\n", racer, leader_num, values[ leader_num ]));
  } else {
    cat( sprintf( "%s %d leading the race!! At step: %d !!\n", racer, leader_num, values[ leader_num ]));
  }
  cat("\n");
  i <-1
  repeat{
    cat( paste( paste( rep( "~", values[i]-3), collapse="" ), symbol,values[i],collapse="",sep=""), "\n");
    i <- i+1
    if (i > participants){break}
  }
  
  cat(paste( rep( 0:9, trunc(max_step/10, 0)+1 ), collapse=""),"\n");
  c<-""
  e<-""
   for (i in (0:(trunc(max_step/10, 0)))){
     cat(sprintf("%-10d", i))
   }
  cat("\n");
}


fish_race('Eye', '<o>',10, 20)

# ---------------

# eset <-ALL[,ALL$mol.biol %in% c('BCR/ABL', 'ALL1/AF4')]
# heatmap(exprs(eset[1:100,]))

m = c(1,3,5,7,3,4,5,3,2,4,9,14,5,14)
table(m)/length(m)
hist(m)
mean(m)
min(m)
quantile(m, .4)
pie(table(m))
summary(m)

classTraits <- read.table('http://mscbioinformatics.uab.cat/base/documents/bioinformaticsintranet1718/databla/CLASS_TRAITS.txt', header = TRUE)

cT<- as.data.frame(classTraits)

cT$IMC <- cT$weight / ((cT$height/100)**2)


cor(classTraits[4:5])


mean(classTraits[[4]])

hist(classTraits[[4]])

plot(weight~gender, data=classTraits)

pairs(classTraits[4:5])

BMI = classTraits[5]/(classTraits[4]/100)^2 

summary(BMI)

names(BMI)<-c('BMI')

cT[which (cT$ABO == 'A' & cT$Rh == 'rh+'),]

detach(classTraits)

sample(1:15,8, replace = T)

class_names=classTraits[,1]

table(sample(class_names, 50, replace =T))

samplein<-sample(class_names, length(class_names))
g1<-samplein[1:5]

color <- c('Red', 'Green')
prob <- c(2/3, 1/3)
sample10<-sample(color, 10, prob = prob, replace = T)
table(sample10)

nucleotide<-c('A', 'C', 'T', 'G')
prob<-c(0.3, 0.2, 0.4,0.1)
nsample = 100

genotype<-c ('AA', 'noAA')
proc <- c(0.25, 0.75)
nsample <-1000
propA<-function(nsample){
  
  genotype<-c ('AA', 'noAA')
  proc <- c(0.25, 0.75)
 return( table(sample(genotype, nsample,proc, replace = T))/nsample)
}

propA(50)

responses <- c('Correct', 'Wrong')
prob = c(0.25, 0.75)
table(sample(responses, 10000,prob, replace = T))

nucleotide
sample(nucleotide, 500, replace = T)

humangen<-read.table("http://bioinformatica.uab.cat/base/documents/bioinformaticsintranet1516/summary_human_genome2015_10_18D22_6.txt", header = T)
complete_genome_size<-sum(as.numeric(humangen$Size_.Mb.))
humangen$propsize = humangen$Size_.Mb./complete_genome_size
GCglobal<-sum((humangen$GC.*humangen$Size_.Mb.)/complete_genome_size)
prob = c((100-GCglobal)/2, (100-GCglobal)/2, (GCglobal)/2, (GCglobal)/2)/100

nucleotide<-c('A', 'T', 'G', 'C')


#---------

sample(nucleotide, 500, prob = prob, replace =T)

observations =500
tabledata<-data.frame(matrix(ncol = 2, nrow = observations))
colnames(tabledata)<-c('X1.100', 'samples')
tabledata$X1.100<-c(1:observations)
for (i in (1:observations)){
  tabledata[which(tabledata$X1.100 == i),'samples']<-mean(sample(c(1,0), i, replace = T)  )
  }

library(ggplot2)

ggplot(tabledata)+geom_line(aes(x = X1.100, y = samples))+labs(title = 'Large number Law', x = 'Number of samples', y = 'Mean probability')+
  theme(plot.title = element_text(hjust = 0.5))

















