library(SummarizedExperiment)
library(readxl)
#load("2002UNHP-0326.obj/rse_gene_Jlab_experiment_n2.Rdata")
load('RTI/rse_gene_Jlab_experiment_n242.Rdata')
rse_g1 <- rse_gene
#this loads rse_gene again
#load("2006UNHP-0481.obj/rse_gene_Jlab_experiment_n24.Rdata")
#load('RTI/rse_gene_Jlab_experiment_n242.Rdata')
#now rse_gene has the object loaded last 

# read the metadata from an Excel file:
phenodata <- read_xlsx("SampleInformation.xlsx")

#reorder the phenodata so rows match the order and the entried in the rse_gene data
pdreord=phenodata[match(rse_gene$SAMPLE_ID,phenodata$SampleID),]
rse_md=as.data.frame(colData(rse_gene))
rse_md$Age <- pdreord$Age
rse_md$Sex <- pdreord$Sex
rse_md$Race <- pdreord$Race
rse_md$Dx <- pdreord$Dx
rse_md$BrNum <- paste('Br',pdreord$BrainNum, sep='')

# columns : the sample data, including their metadata and summaries for the assays involved  
#rse_md1 <- as.data.frame(colData(rse_g1))
#rse_md2 <- as.data.frame(colData(rse_gene))

#--- What if we want to rearrange the columns? Here it is a simple function that just takes a column name
#--- and the new position it should be in
##arrange data frame vars by position
##'vars' must be a named vector, e.g. c("var.name"=1)
arrange.vars <- function(data, vars){
    ##stop if not a data.frame (but should work for matrices as well)
    stopifnot(is.data.frame(data))
    ##sort out inputs
    data.nms <- names(data)
    var.nr <- length(data.nms)
    var.nms <- names(vars)
    var.pos <- vars
    ##sanity checks
    stopifnot( !any(duplicated(var.nms)), 
               !any(duplicated(var.pos)) )
    stopifnot( is.character(var.nms), 
               is.numeric(var.pos) )
    stopifnot( all(var.nms %in% data.nms) )
    stopifnot( all(var.pos > 0), 
               all(var.pos <= var.nr) )

    ##prepare output
    out.vec <- character(var.nr)
    out.vec[var.pos] <- var.nms
    out.vec[-var.pos] <- data.nms[ !(data.nms %in% var.nms) ]
    stopifnot( length(out.vec)==var.nr )

    ##re-arrange vars by position
    data <- data[ , out.vec]
    return(data)
}

## now we can rearrange the columns:
rse_mdre <- arrange.vars(rse_md, c("BrNum"=2))
rse_mdre <- arrange.vars(rse_mdre, c("Race"=3))
rse_mdre <- arrange.vars(rse_mdre, c("Age"=4))
rse_mdre <- arrange.vars(rse_mdre, c("Sex"=5))
rse_mdre <- arrange.vars(rse_mdre, c("Dx"=6))

## and finally we need to assign colData back to the rse_gene
## NOTE: we have to convert the data frame back to Bioconductor's DataFrame type!
colData(rse_gene) <- as(rse_mdre, "DataFrame")

### now we can finally save this updated rse_gene object
save(rse_gene, file="rse_gene_2006UNHP-0481_n24.Rdata")

### apply the same for the exon data:
load("2006UNHP-0481.obj/rse_exon_Jlab_experiment_n24.Rdata")
rse_exon_md <- as.data.frame(colData(rse_exon))

## making sure the same phenodata mapping is identical with the one we used previously (pdreord)
pdexonre=phenodata[match(rse_exon$SAMPLE_ID,phenodata$SampleID),]
all.equal(pdexonre, pdreord) #must show TRUE

# if TRUE, we can assign the data like before and then reorder
rse_exon_md$Age <- pdreord$Age
rse_exon_md$Sex <- pdreord$Sex
rse_exon_md$Race <- pdreord$Race
rse_exon_md$Dx <- pdreord$Dx
rse_exon_md$BrNum <- paste('Br',pdreord$BrainNum, sep='')
## now rearrange the column order:
## now we can rearrange the columns:
rse_exon_md <- arrange.vars(rse_exon_md, c("BrNum"=2))
rse_exon_md <- arrange.vars(rse_exon_md, c("Race"=3))
rse_exon_md <- arrange.vars(rse_exon_md, c("Age"=4))
rse_exon_md <- arrange.vars(rse_exon_md, c("Sex"=5))
rse_exon_md <- arrange.vars(rse_exon_md, c("Dx"=6))

## and finally we need to assign colData back to the rse_gene
## NOTE: we have to convert the data frame back to Bioconductor's DataFrame type!
colData(rse_exon) <- as(rse_exon_md, "DataFrame")

### now we can finally save this updated rse_gene object
save(rse_exon, file="rse_exon_2006UNHP-0481_n24.Rdata")

### apply the same for the tx data:
load("2006UNHP-0481.obj/rse_tx_Jlab_experiment_n24.Rdata")
rse_tx_md <- as.data.frame(colData(rse_tx))
## making sure the same phenodata mapping is identical with the one we used previously (pdreord)
pdtxre=phenodata[match(rse_tx$SAMPLE_ID,phenodata$SampleID),]
all.equal(pdtxre, pdreord) #must show TRUE

# if TRUE, we can assign the data like before and then reorder
rse_tx_md$Age <- pdreord$Age
rse_tx_md$Sex <- pdreord$Sex
rse_tx_md$Race <- pdreord$Race
rse_tx_md$Dx <- pdreord$Dx
rse_tx_md$BrNum <- paste('Br',pdreord$BrainNum, sep='')
## now rearrange the column order:
## now we can rearrange the columns:
rse_tx_md <- arrange.vars(rse_tx_md, c("BrNum"=2))
rse_tx_md <- arrange.vars(rse_tx_md, c("Race"=3))
rse_tx_md <- arrange.vars(rse_tx_md, c("Age"=4))
rse_tx_md <- arrange.vars(rse_tx_md, c("Sex"=5))
rse_tx_md <- arrange.vars(rse_tx_md, c("Dx"=6))

## and finally we need to assign colData back to the rse_gene
## NOTE: we have to convert the data frame back to Bioconductor's DataFrame type!
colData(rse_tx) <- as(rse_tx_md, "DataFrame")

### now we can finally save this updated rse_gene object
save(rse_tx, file="rse_tx_2006UNHP-0481_n24.Rdata")


## --- Add phenotype data to junction data:

### apply the same for the tx data:
load("2006UNHP-0481.obj/rse_jx_Jlab_experiment_n24.Rdata")
rse_jx_md <- as.data.frame(colData(rse_jx))

## making sure the same phenodata mapping is identical with the one we used previously (pdreord)
pdjxre=phenodata[match(rse_jx$SAMPLE_ID,phenodata$SampleID),]
all.equal(pdjxre, pdreord) #must show TRUE

# if TRUE, we can assign the data like before and then reorder
rse_jx_md$Age <- pdreord$Age
rse_jx_md$Sex <- pdreord$Sex
rse_jx_md$Race <- pdreord$Race
rse_jx_md$Dx <- pdreord$Dx
rse_jx_md$BrNum <- paste('Br',pdreord$BrainNum, sep='')
## now rearrange the column order:
## now we can rearrange the columns:
rse_jx_md <- arrange.vars(rse_jx_md, c("BrNum"=2))
rse_jx_md <- arrange.vars(rse_jx_md, c("Race"=3))
rse_jx_md <- arrange.vars(rse_jx_md, c("Age"=4))
rse_jx_md <- arrange.vars(rse_jx_md, c("Sex"=5))
rse_jx_md <- arrange.vars(rse_jx_md, c("Dx"=6))

## and finally we need to assign colData back to the rse_gene
## NOTE: we have to convert the data frame back to Bioconductor's DataFrame type!
colData(rse_jx) <- as(rse_jx_md, "DataFrame")

### now we can finally save this updated rse_gene object
save(rse_jx, file="rse_jx_2006UNHP-0481_n24.Rdata")

