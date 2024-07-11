library(purrr)
library(stringr)

################################################################################
#                                                                              #
#           This code is not yet implemented.                                  #
#                                                                              #
################################################################################
cfg <- list(
    hub_location = "/project/higgslab/datashare/mjenning/test/hub"
)
hub_txt <- list(
    hub = "mikej_test_1",
    shortLabel = "Hub created as test",
    longLabel = "Hub created as test of bpe-1/create_hub script",
    genomesFile = "test_genomes_1.txt",
    email = "mike.jennings@imm.ox.ac.uk",
    descriptionUrl = "test_description_1.html"
)

genomes_txt <- list(
    genome <- "mm39",
    trackDb <- "mm39/trackDb.txt"
)

trackDb_txt <- list(
    track = "test track",
    longLabel = " First test track in test hub",
    shortLabel = "test track 1",
    type = "bigWig"
)

hub_path <- file.path(cfg$hub_location, hub_txt$hub)
dir.create(hub_path, showWarnings = FALSE)

hub_lines <- map2_chr(names(hub_txt), hub_txt, \(n,v) paste(n, v))
writeLines(hub_lines, file.path(hub_path, "hub.txt"))

track <- list(
    bidDataUrl 
)

model <- "ATAC"
add_track(list(track=model))
tline_in<- list(track="test_track")

add_track <- function(tline_in=list(track="track")){
    track = tline_in$track
    tline_default <- list(
        track = track,
        shortLabel = track,
        longLabel = track,
        type = "bigWig",
        visibility = "full",
        autoScale = "on"
    )
nuse_default <- map(names(tl_default), ~ ! str_detect(.x, names(tl_in)))
track_line <- imap(use_default,
     \(v, i) ifelse(v , tline_default[[i]], tline_in[[i]])) |>
     set_names(names(tl_default))

map_if(tl_default, 
        \(dl)  names(dl) %in% names(tl_in),
        tl_in[names(dl)]
)
tline <- imap(use_default, ~ ifelse(., ) )
names(tl_in)
names(tl_default) >
    map(\(n){
        print (n)
        return(n)
        }
    )
use_default <- map(names(tl_default), ~ ! str_detect(.x, names(tl_in)))

    names(tl_in)
    names(tl_default)

names(tl_default)[[1]]
attr()
imap(tl_default, ~ (names(tl_default[.y])))

map(tl_default, ~ (.x))
kkres
    src_path <- file.path(
        proj_path, model, str_glue("{model}.bw")
        )
    pub_path <- file.path(
        file.path(hub_path, str_glue("{track}.bw"))
    )
    file.copy(src_path, pub_path, overwrite = TRUE)

    remove_existing_track(track)
    write_track
    track <- list(
        track = model,
        bigDataUrl = pub_path,
        shortLabel = model,
        longLabel = model,
        type = "bigWig",
        visibility = "full",

    )
}




