## Artificial Intelligence-driven Radiomic Categorization to predict Survival benefit of Adjuvant chemotherapy method

### Introduction
This is the code for the paper entitled "Multimodal data integration for explainable artificial intelligence to guide adjuvant chemotherapy in stage II colorectal cancer"

This code includes the custom R script and radiomics data in this study and used to train predictive models.

### Methods
Analysis flowchart.
- Automated colorectum and CRC segmentation by [
DeepCRC
](https://github.com/cx601/AIRCSA/blob/main/DeepCRC/MICCAI2022_Colonrectal_Cancer.pdf)
- Radiological radiomic features extraction ([
Radiomic feature extraction
](https://github.com/cyxie601/ESCC_ML/tree/master/Feature%20Extraction))
- The survival-by-treatment interaction test to select top significant features
- The discovery of treatment decision-related subtypes
- Model evaluation

### Data
rd_features_survival.csv - extracted radiomic data used for the discovery of treatment decision-related subtypes and survival analysis

### run
All analysis are running under R version 3.3.3

ImageModel.R -- To perform the survival-by-treatment interaction test, select top significant featuresfor unsupervised clustering of radiological subtypes, and conduct survival analysis for treatment decision-related subtypes.

RadiogenomicAnalysis.R -- To explore the underlying different biological pathways and to quantify the relative abundance of stromal and immune cell. 

### Requirement

#### R requirements
- ggplot2 3.4.3 
- survival 3.5.5
- survminer 0.4.9
- ggpubr 0.6.0
- cvTools 0.3.2
- xCell 1.1.0
- GSEABase 1.60.0
- GSVA 1.46.0
- dplyr 1.1.1
- ComplexHeatmap 2.14.0
- dendextend 1.17.1
- RColorBrewer 1.1.3
