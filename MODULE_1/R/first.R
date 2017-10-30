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


# fish_race('Tuna', 10, 20)

# ---------------

# eset <-ALL[,ALL$mol.biol %in% c('BCR/ABL', 'ALL1/AF4')]
# heatmap(exprs(eset[1:100,]))

