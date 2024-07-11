library(dplyr)
library(rtracklayer)
library(readr)
library(stringr)

################################################################################
#                                                                              #
#           This code is not yet implemented.                                  #
#                                                                              #
################################################################################
cfg <- list(
    proj_dir = str_glue(
        "{Sys.getenv('PROJ')}/hay2016_emulation_20240604"
        ),
    hub_location = "/project/higgslab/datashare/mjenning/test/hub",
    hub = "hay2016_emu",
    genome = "mm39",
    assay=c(
        "ATAC",
        "H3K4me1",
        "H3K4me3",
        "Med1"
    ),
    track=c(
        "ATAC_ter119_APH_spleen",
        "H3K4me1_ter119_APH_spleen",
        "H3K4me3_ter119_APH_spleen",
        "Med1_ter119_APH_spleen"
    )
)

ltron_fname <- file.path(
    cfg$proj_dir,
    cfg$assay[1],
    "Lanceotron_output",
    str_glue("{cfg$assay[1]}_L-tron.bed")
    )
toppeak_fname <- file.path(
    cfg$proj_dir,
    cfg$assay[1],
    "Lanceotron_output",
    str_glue("{cfg$assay[1]}_L-tron_toppeaks.bed")
    )
bed_fname <- toppeak_fname
bed2bigbed <- function(bed_fname){
    bed_df <- read_tsv(
        bed_fname,
        col_names = c("chr", "start", "end", "score")
    )
    bed_check <- bed_df |>
        mutate(len = end - start ) |>
        filter (len < 1)
    bed <- import(bed_fname)
}
get_ltron <- function(ltron_fname){
    ltron_df <- read_tsv(ltron_fname)
}