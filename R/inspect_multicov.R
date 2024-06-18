library(dplyr)
library(purrr)
library(readr)
library(stringr)
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
    setNames(mc_names)

plot(density(mc$Med1))
