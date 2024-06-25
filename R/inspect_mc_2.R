library(dplyr)
library(ggplot2)
library(mclust)
library(purrr)
library(readr)
library(stringr)

options(bitmapType='cairo')

cfg <- list(
    analysis_dir = str_glue(
        "{Sys.getenv('PROJ')}/hay2016_emulation_20240604/ana_1"
        ),
    mcov_file = "mbw_ATAC_Med1.tab"
)
# read the raw multicov file
mc_raw <- read_tsv(
    file.path(cfg$analysis_dir, cfg$mcov_file),
) 

mc_names <- names(mc_raw) |>
    map(\(n) str_replace_all(n, "'", "") ) |>
    map(\(n) str_replace(n, "#", "" ))

mc <- mc_raw |>
    setNames(mc_names) |>
    mutate(atac_1 = log10(pmax(1, ATAC-200))) |>
    mutate(med1_1 = log10(pmax(1, Med1-400)))

summary(mc)

sample( mc$ATAC, 10)
pmin(1, log10(mc$ATAC[3:5] - 100))
ggplot(mc, aes(x = log10(med1_1))) +
    geom_density() 
    

plot(density(mc$))

