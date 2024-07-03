library(dplyr)
library(ggplot2)
library(GenomicRanges)
library(purrr)
library(mclust)
library(purrr)
library(readr)
library(stringr)

options(bitmapType='cairo')

cfg <- list(
    analysis_dir = str_glue(
        "{Sys.getenv('PROJ')}/hay2016_emulation_20240604/ana_1"
        ),
    mcov_file = list(
        "mbws_ATAC.tab",
        "mbws_H3K4me1_3.tab",
        "mbws_cf.tab"
    )
)
# read the raw multicov files and combine
mc_raw <- cfg$mcov_file |>
    map(\(f)
      read_tsv(file.path(cfg$analysis_dir, f))
        ) |>
    bind_cols()

# Strip wrapper of quotations from the names, and the hash
mc_names <- names(mc_raw) |>
    map(\(n) str_replace_all(n, "'", "") ) |>
    map(\(n) str_replace(n, "#", "" ))

mc_names

mc <- mc_raw |>
    setNames(mc_names) |>
    select( !contains("..."))
nrow(mc)

report <- function (x, message) {
    print(str_glue("{count(x)}: {message}."))
    return (x)
}

mc_filtered <- mc |>
    report("Initial count") |>
    filter (!(H3K4me1 < 10 & H3K4me3 < 10)) |>
    report("low H3K4Me removed") |>
    mutate(me_ratio= H3K4me3/H3K4me1) |>
    filter (me_ratio < 1) |>
    report("me3/me1 < 1 kept") |>
    



summary(mc)

sample( mc$ATAC, 10)
pmin(1, log10(mc$ATAC[3:5] - 100))
ggplot(mc, aes(x = log10(med1_1))) +
    geom_density() 
    

plot(density(mc$))

