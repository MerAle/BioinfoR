## DELIVERABLE


# 1. Exploratory data analysis (apply descriptive statistics and graphs for one o more 
#  variables) of non-trivial variables of the genome table. 
link <- 'http://mscbioinformatics.uab.cat/base/documents/bioinformaticsintranet1718/summary_human_genome2015_10_18D22_6.txt'

header<-read.table(link, nrows = 1, stringsAsFactors = F)

# there is a missing column name, as we can see in https://www.ncbi.nlm.nih.gov/genome/51?genome_assembly_id=214366
t<-read.table(link, skip = 1 , stringsAsFactors = F)
colnames(t)<-c(  as.character(header[1:4]), "INSDC", as.character(header[5:12]))

# Also, the last row has a typo
t[26,2:13]<-c(as.character(t[26,3:13]), as.character(t[27,1]))
t<-t[1:26,]

# The variables are transformed to numeric
t[,6:13]<-apply(t[,6:13], 2, function(x){
  x<-gsub(",","",x)
  as.numeric(x)
  })

# Univariate analysis in continuous variables (height and weight)

library(Weighted.Desc.Stat)

gensize<-sum(as.numeric(t$`Size_(Mb)`))
t$Rel_size = t$`Size_(Mb)`/gensize
sapply(t[6:13], summary)
apply(t[6:13], 2, function(x){
  w.mean(x[which(is.na(x)== FALSE)], t[which(is.na(x)== FALSE),"Rel_size"])
})

t$Genes_per_Mb<-t$Gene/t$`Size_(Mb)`
summary(t$Genes_per_Mb[1:24])
t$Pseudogene_per_Mb<-t$Pseudogene/t$`Size_(Mb)`
summary(t$Pseudogene_per_Mb[1:24])
t$ratio_gene_pseud=t$Genes_per_Mb/t$Pseudogene_per_Mb
summary(t$ratio_gene_pseud[1:24])

boxplot(t$ratio_gene_pseud)
library(ggplot2)
library(gridExtra)
require(reshape2)

ggplot(data = melt(t[1:24,15:18]), aes(x=factor(1), y=value)) + 
  geom_boxplot(aes(fill=variable))+
  facet_wrap(.~variable,  scales = 'free')+
  xlab("")+
  theme(axis.text.x=element_blank())
  
  
  # -----------

p1<-ggplot(t)+geom_boxplot(aes(x = factor(1) , y = ratio_gene_pseud))+labs(title  ="Genedens./Pseudogenedens." , y = "Gd/Pd", x = "Chromosome")+ theme(plot.title = element_text(hjust = 0.5), legend.position = 'none')
p2<-ggplot(classTraits)+geom_boxplot(aes(x = gender , y = weight,fill = gender))+labs(title = "Weight analysis", y = "Weight (kg)", x = "Gender")+ theme(plot.title = element_text(hjust = 0.5))
grid.arrange(p1,p2, nrow = 1)


library(ggplot2)
library(gridExtra)
p1<-ggplot(classTraits)+geom_boxplot(aes(x = factor(1) , y = height , fill = gender))+labs(title  ="Height analysis" , y = "Height (cm)", x = "Gender")+ theme(plot.title = element_text(hjust = 0.5), legend.position = 'none')
p2<-ggplot(classTraits)+geom_boxplot(aes(x = gender , y = weight,fill = gender))+labs(title = "Weight analysis", y = "Weight (kg)", x = "Gender")+ theme(plot.title = element_text(hjust = 0.5))
grid.arrange(p1,p2, nrow = 1)

# Distribution of categorical variables, The NAs are not counted in the proportions
sapply(classTraits[,c("gender", "degree", "ABO", "Rh", "hair_color", "eye_color", "tongue_rolling")], FUN = function(x){table(x)/sum(table(x))})

# Bi variate analysis on continuous variables, with both height and weight recorded
p<-ggplot(classTraits, aes(height, weight, color = gender)) + geom_point() 
p3 <-p+ facet_grid(.~gender)
grid.arrange(p3, p, ncol = 1)

var(classTraits[,c("height", "weight")], use= 'complete.obs')
cor(classTraits[,c("height", "weight")], use= 'complete.obs')

# Bi variate analysis deleting outliers

subset<-classTraits[which ((classTraits$gender == "M" & classTraits$height %in% c(160:190) & classTraits$weight < 91) | (classTraits$gender == "F" & classTraits$weight<80)),c("height", "weight")]

var(subset)
cor(subset)

p5<-ggplot(classTraits, aes(x = eye_color))+geom_bar( aes(fill = hair_color ), position = 'stack')
p5

# 2. Ask interesting questions (or hypotheses) about these variables or new variables (indexes...) derived from them, and try to answer appropriately the questions using the proper statistical tests 

# 3. Summarize your exploration and analysis in a clear scientific writing.
