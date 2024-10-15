library(curl)
library(dplyr)
library(tidyr)

# Taxonomic data from Mazel et al., 2021 (doi.org/10.1111/1462-2920.15686)
taxo_exa2<-curl("https://sfamjournals.onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2F1462-2920.15686&file=emi15686-sup-0004-Additional_file_4.csv") %>%
  read.csv() %>%
  select(-seqs) %>%
  unite(taxonomy,starts_with("PR2_"),sep=";") %>%
  unite(bootstrap,starts_with("Boot_"),sep="|")

usethis::use_data(taxo_exa2, overwrite = TRUE)
