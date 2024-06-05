library(Rsamtools)
library(stringr)
#library(rtracklayer)
#TODO try megadepth library

cfg <- list(
    "proj_dir" = "/project/higgslab/mjenning/proj/hay2016_emulation_20240604",
    "model" = c("ATAC", "H3K4me1", "H3K4me3", "Med1")
)
cfg$model[1]
filename_1 <- file.path(cfg$proj_dir,cfg$model[1],str_glue("{cfg$model[1]}.bam"))
filename_1
info <- scanBamHeader(filename_1)

which <- GRanges(c(
    "chr11:1000-2000",
    "chr12:100-1000",
    "chr12:1000-2000"
))

what <- c("rname", "strand", "pos", "qwidth", "seq")
param <- ScanBamParam(which=which, what=what)
bam <- scanBam(filename_1, param=param)
