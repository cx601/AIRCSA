library(xCell)
library('GSEABase')
library(GSVA)
library(stringr)
library(dplyr)

#Stromal and immune cell infiltration analysis
setwd(dir = "...")
exp1<-read.csv("normalized_mtx.txt", stringsAsFactors = F, sep = "\t", header = T, check.names = F)

res1<-xCellAnalysis(exp1,
  rnaseq = TRUE, # RNA-seq
  parallel.sz = 1,
  parallel.type = "SOCK", scale = TRUE) 

res<-t(res1)
write.table(res,"xcell_infiltration.CSV",sep = ",",row.names = T)


#GSVA_hall analysis
exp <- as.matrix(exp1)
geneSets <- getGmt('h.all.v7.5.1.symbols.gmt')   
GSVA_hall <- gsva(expr=exp, 
                  gset.idx.list=geneSets, 
                  mx.diff=T, 
                  kcdf="Gaussian",parallel.sz=4) 
head(GSVA_hall)
rownames(GSVA_hall)

Radiogenomic_dataset<-read.csv("...",row.names=1)
group_list<-Radiogenomic_dataset$RiskGroup
group_list[group_list ==  '1' ] <- "Radiologicalcluster1"
group_list[group_list ==  '2' ] <- "Radiologicalcluster2"
group<-as.factor(group_list)

design <- model.matrix(~0+group)
colnames(design) = levels(factor(group))
rownames(design) = colnames(GSVA_hall)

compare <- makeContrasts(Radiologicalcluster1 - Radiologicalcluster2, levels=design)
fit <- lmFit(GSVA_hall, design)
fit2 <- contrasts.fit(fit, compare)
fit3 <- eBayes(fit2)
Diff <- topTable(fit3, coef=1, number=200)

#barplot
tempOutput = topTable(fit3,coef=1,n=Inf,adjust="BH") 
dat_gsva <- data.frame(id = row.names(tempOutput),
                         t = tempOutput$t)
dat_gsva$id <- str_replace(dat_gsva$id , "HALLMARK_","")
dat_gsva$threshold = factor(ifelse(dat_gsva$t  >-2, ifelse(dat_gsva$t >= 2 ,'Up','NoSignifi'),'Down'),levels=c('Up','Down','NoSignifi'))
dat_gsva <- dat_gsva %>% arrange(t)
dat_gsva$id <- factor(dat_gsva$id,levels = dat_gsva$id)

write.csv(dat_gsva,"gsva1.csv", row.names = FALSE)