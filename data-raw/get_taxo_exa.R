library(biomformat)
library(dplyr)
library(tibble)

load("R/sysdata.rda")
rename_ranks<-function(x) taxonomic_ranks[as.numeric(sub(".*([0-9])$","\\1",x))]

taxo_exa<-read_biom("https://raw.githubusercontent.com/lentendu/V4_SSU_ASV_bioinformatic_pipeline/main/V4_SSU_example.ASV_table.biom") %>%
  observation_metadata() %>%
  rownames_to_column("repseq") %>%
  rename_with(rename_ranks,starts_with("taxonomy"))

usethis::use_data(taxo_exa, overwrite = TRUE)
