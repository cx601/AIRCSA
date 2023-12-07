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

### Demo data
rd_features_survival.csv - extracted radiomic data used for the discovery of treatment decision-related subtypes and survival analysis

### Requirement

#### Python requirements
- numpy 
- pandas 
- scipy 
- SimpleITK 
- scikit-learn 

#### R requirements
- ggplot2 
- survival
- survminer
- ggpubr
- cvTools
- xCell
- GSEABase
- GSVA
- dplyr
