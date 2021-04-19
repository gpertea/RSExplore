# load packages
library("SummarizedExperiment")
library("ggplot2")
library("plotly")

#load the rse_gene object
load("../Phase1/dlpfc_polyA_brainseq_phase1_hg38_rseGene_merged_n732.rda")
# rows = the features (gene data: length, IDs, gene symbol, meanExpression in the assays?)
rse_g_phase1 <- rse_gene
rse_g_phase1_ft=as.data.frame(rowData(rse_gene))

# columns : the sample data, including their metadata and summaries for the assays involved  
rse_g_phase1_md=as.data.frame(colData(rse_gene))

#see sample metadata columns:
colnames(rse_g_phase1_md)
# show some specific metadata columns for specific samples
rse_g_phase1_md[c('R3036', 'R3597','R3646', 'R3907'),c('BrNum', 'RIN', 'bamFile')]

## load the big all-merge file
load("RNAseq_Collection_postQC_n5544_11dataset_2020-09-07_geneRSE.Rdata")
rse_g_all <- rse
rm(rse) #free memory
rse_g_md <- as.data.frame(colData(rse_g_all))
rse_g_ft <- as.data.frame(rowData(rse_g_all))

#-----------------
# load the largest file: junctions:
load("../Phase1/dlpfc_polyA_brainseq_phase1_hg38_rseJxn_merged_n732.rda")
rse_jxn_md=as.data.frame(colData(rse_jxn))
rse_jxn_ft=as.data.frame(rowData(rse_jxn))
##-- if you want to load the BIG merge gene object across all Phases:
load("RNAseq_Collection_postQC_n5498_10dataset_2020-04-28_geneRSE.Rdata")
rse_all_md=as.data.frame(colData(rse))
rse_all_ft=as.data.frame(rowData(rse))
#let's say we want to see entries for a few RNums of interest:
rnums=c('R3036', 'R3597','R3646', 'R3907')
#grep the indexes or matching rows:
ndx=grep(paste0('^(',paste0(rnums,collapse = '|'),')'), rownames(rse_all_md))
#subset the table:
md_subset=rse_all_md[ndx,]


