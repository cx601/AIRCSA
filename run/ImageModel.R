.rs.restartR()
rm(list=ls())
library(ggpubr)
library(ggplot2)
library(survival)
library(survminer)
library(cvTools)

#Import dataset
data<-read.csv(".../dataset/rd_features_survival.csv",row.names=1)

## The survival-by-treatment interaction test to select top significant features
uni_cox <-list()
for (i in 4:ncol(data)){
  uni<-coxph(Surv(os_fumon,os_fustat)~data[,i]*data[,3],data=data, na.action=na.exclude)
  uni<-as.data.frame(as.matrix(coef(summary(uni))))
  uni$feature<-colnames(data)[[i]]
  uni_cox[[i]]<-uni
}
cox_result <- do.call(rbind,uni_cox)

idx=c()
for(i in 1:dim(cox_result)[1]){
  if(i%%3==0){idx=c(idx,i)} 
}
new_cox_result=cox_result[idx,]
mark <- new_cox_result[which(as.numeric(as.character(new_cox_result[,5]))<=0.05), ]

list1<-mark$feature
dataset_s<-data[,list1]

# Data normalization 
maxs <- apply(dataset_s, 2, max)
mins <- apply(dataset_s, 2, min)
sample_all<-scale(dataset_s, center=(maxs+mins)/2, scale=(maxs-mins)/2)
sample_all[is.na(sample_all)] <- 0

# The discovery of treatment decision-related subtypes
col_dend = hclust(d = dist(sample_all, method = 'euclidean'), method = 'ward.D')
y_hc = cutree(col_dend, 2)
row_dend = hclust(d = dist(t(sample_all), method = 'euclidean'), method = 'ward.D')
sample_all<-t(sample_all)
col <- colorRampPalette(brewer.pal(10, "RdYlBu"))(256)
Heatmap<-Heatmap(sample_all, name = "Value", col =  col,
                 row_names_gp = gpar(fontsize = 6.5),
                 cluster_columns = color_branches(col_dend, k = 2,col =  c("darkgoldenrod1","darkblue")))

Heatmap

# Model evaluation for treatment-specific survival
fit.surv <-Surv(data$os_fumon,data$os_fustat)
summary(fit.surv)
km<- survfit(fit.surv~Adjuvant_chemotherapy,data = data)
all<-ggsurvplot(km, data = data,
                  legend.title = "",
                  tables.y.text = FALSE, 
                  legend =c(0.80,0.15),
                  legend.labs = c("Adjuvant chemotherapy", "Intensive observation"),
                  pval = TRUE,
                  palette = c("#E7B800", "#2E9FDF"),
                  tables.theme = theme_cleantable(),
                  xlim = c(0, 120),
                  break.time.by = 30,    
                  xlab="Time in months",title="Pre-categorized (GDPH cohort)")+
  ylab('Probability of Overall Survival')+
  xlab('Follow-up (months)')
all

data$RiskGroup<-y_hc

dataset1<-subset(data,data$RiskGroup=='1')
fit.surv <-Surv(dataset1$os_fumon,dataset1$os_fustat)
head(fit.surv)

km_1<- survfit(fit.surv~Adjuvant_chemotherapy,data = dataset1)
survdiff(fit.surv~Adjuvant_chemotherapy,data = dataset1,
         rho = 0)
trt1<-ggsurvplot(km_1, data = dataset1,
                   legend.title = "",
                   tables.y.text = FALSE, 
                    legend =c(0.80,0.15),
                    legend.labs = c("Adjuvant chemotherapy", "Intensive observation"),
                   pval = TRUE,
                   palette = c("#E7B800", "#2E9FDF"),
                   tables.theme = theme_cleantable(),
                   xlim = c(0, 120),
                   break.time.by = 30,    
                   xlab="Time in months",title="Cluster 1 (GDPH cohort)")+
  ylab('Probability of Overall Survival')+
  xlab('Follow-up (months)')
trt1


dataset1<-subset(data,data$RiskGroup=='2')
fit.surv <-Surv(dataset1$os_fumon,dataset1$os_fustat)
head(fit.surv)
km_2<- survfit(fit.surv~Adjuvant_chemotherapy,data = dataset1)
survdiff(fit.surv~Adjuvant_chemotherapy,data = dataset1,
         rho = 0)
trt2<-ggsurvplot(km_2, data = dataset1,
                 legend.title = "",
                 tables.y.text = FALSE, 
                 legend =c(0.80,0.15),
                 legend.labs = c("Adjuvant chemotherapy", "Intensive observation"),
                 pval = TRUE,
                 palette = c("#E7B800", "#2E9FDF"),
                 tables.theme = theme_cleantable(),
                 xlim = c(0, 120),
                 break.time.by = 30,    
                 xlab="Time in months",title="Cluster 2 (GDPH cohort)")+
  ylab('Probability of Overall Survival')+
  xlab('Follow-up (months)')
trt2

