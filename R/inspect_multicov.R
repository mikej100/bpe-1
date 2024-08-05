library(dplyr)
library(ggplot2)
# library(GenomicRanges)
library(mclust)
library(purrr)
library(readr)
library(stringr)

# set purrr::map as default map
map <- purrr::map
################################################################################
#                                                                              #
#           Inspect multiBigWigSummary results                                 #
#                                                                              #
#  Processes results from multiBigWigSummary runs.                             #
#  Takes results from multiple .tab output file and binds the columns, keepingp#
#  the first three columns (chr, start and end) of the first set. So the       #
#  data sets need to have been generated from corresponding versions of a      #
#  bed file.                                                                   #
################################################################################
################################################################################
#           Configuration                                                      #
################################################################################
# Get the analysis directory and other configuration from config.yml
cfg <- config::get()
# For graphical rendition, setting for molbiol.ox.ac.uk.
Options(bitmapType='cairo')

################################################################################
#                                                                              #
#           Assimilate the data                                                #
#                                                                              #
################################################################################
# read the raw multicov files and combine
analysis_path <- file.path(cfg$proj_path, cfg$model_dir, cfg$analysis_dir)

mc_raw <- cfg$mcov_file |>
    map(\(f)
      read_tsv(file.path(analysis_path, f))
        ) |>
    bind_cols()

# Strip wrapper of quotations from the names, and the hash
# and remove '...<1, 2  or 3>' so can keep first 
# set of names as 'chr', 'start' and 'end'
mc_names <- names(mc_raw) |>
    map(\(n) str_replace_all(n, "'", "") ) |>
    map(\(n) str_replace(n, "#", "" )) |>
    map(\(n) str_replace(n, "\\.\\.\\.[123]$", "" ))
# check names look correct.
mc_names

# Set the new names and drop redundant chr, start and end columns
mc <- mc_raw |>
    setNames(mc_names) |>
    select( !contains("..."))
nrow(mc)

################################################################################
#                                                                              #
#           Processing stream                                                  #
#                                                                              #
################################################################################
# A function to report the count and pass value back to the pipe stream
report <- function(x, message) {
    print(str_glue("{count(x)}: {message}."))
    return(x)
}

# filter the data according to some rules, counting the rows at each step.
lower_limit = 50
mc_augmented <- mc |>
    filter((H3K4me1 >= lower_limit & H3K4me3 >= lower_limit) ) |>
    mutate(me_ratio = H3K4me3 / H3K4me1) 
# filter the data according to some rules, counting the rows at each step.
mc_filtered <- mc |>
    report("Initial count") |>
    filter(!(H3K4me1 < 10 & H3K4me3 < 10)) |>
    report("low H3K4Me count removed") |>
    filter(me_ratio < 1) |>
    report("me3/me1 count ration < 1 kept")


# Peek at the data
summary(mc)
################################################################################
#                                                                              #
#           Write data                                                         #
#                                                                              #
################################################################################
# Write data to the analysis directory. 
write_tsv(
    mc_filtered,
    file.path(analysis_path, "consolidated_multicov.tsv")
)
#
################################################################################
#                                                                              #
#          Density estimation                                                  # 
#                                                                              #
################################################################################
dens <- densityMclust(mc_augmented$me_ratio)
summary(dens, parameters = TRUE)
#
################################################################################
#                                                                              #
#          Pair plot                                                           # 
#                                                                              #
################################################################################
n = 200
clPairs( sample_n(mc_filtered, n)[ , -(1:3)]) 
mod <- Mclust( sample_n(mc_filtered, n)[ ,-(1:3)]) 
summary(mod, parameters = TRUE)
n = 500
dat <- sample_n(mc_filtered, n)[ , 'ATAC']
clPairs( dat )
mod <- Mclust( dat )
summary(mod, parameters = TRUE)
#
################################################################################
#                                                                              #
#          Clustering                                                          # 
#                                                                              #
################################################################################
mod <- Mclust(select(mc_augmented, H3K4me1:H3K4me3), G=5)
summary(mod, parameters = TRUE)
plot(mod, what = "classification")
#



