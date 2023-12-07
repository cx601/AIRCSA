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
- numpy 1.16.3
- pandas 0.24.2
- scipy 1.2.1
- SimpleITK 1.2.0
- Keras 2.2.4
- scikit-learn 0.21.1

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
