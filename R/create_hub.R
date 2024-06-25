library(purrr)
library(stringr)

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

genome_txt <- list(
    genome <- "tbf",
    trackDb <- "test_trackDb.txt"
)

hub_path <- file.path(hub_location, hub_txt$hub)
dir.create(hub_path, showWarnings = FALSE)

hub_lines <- map2_chr(names(hub_txt), hub_txt, \(n,v) paste(n, v))
writeLines(hub_lines, file.path(hub_path, "hub.txt"))
