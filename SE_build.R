library(tibble) #needed for column_to_rownames()
library(SummarizedExperiment)
#must be run in the directory where these files are present
pdata=read.csv('miRNA_sampleInformation_1462.csv')
counts=read.csv('all_samples.xcsv', sep="\t")
rpmCounts=read.csv('all_samples.norm.xcsv', sep="\t")
stats=read.csv('all_samples.stats', sep="\t")
#---
counts <- column_to_rownames(counts, 'sample')
rpmCounts <- column_to_rownames(rpmCounts, 'sample')

pdata <- column_to_rownames(pdata, 'RNum')[rownames(counts),]
#intersected to keep only phenotypes having an entry in the counts assay data
# assumes rpmCount has the same set of samples
counts <- t(counts) #transpose the counts matrix
rpmCounts <- t(rpmCounts) #transpose the counts matrix

#Build the SummarizedExperiment objects and save them

se <- SummarizedExperiment(counts, colData=pdata)
#and save it
save(se, file='se_counts.Rdata')

rpmse <- SummarizedExperiment(rpmCounts, colData=pdata)
#and save it
save(rpmse, file='se_rpm.Rdata')
