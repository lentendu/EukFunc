# Soil Eukaryotes Functional Database -------------------------------------

library(usethis)
library(tidyverse)
# devtools::install_github("pr2database/pr2database@6830b7d") for version v5.0.0
library(pr2database)

load("data/DBu.rda")
load("R/sysdata.rda")
pr2<-pr2_database() %>%
  select(pr2_accession,all_of(taxonomic_ranks))

nem<-read.delim("data-raw/Nematoda.genus.corrected_taxonomy_vs_PR2.tsv", stringsAsFactors = F)
tmp<-mutate(DBu, across(!!taxonomic_ranks, as.character)) %>%
  left_join(nem, by="genus") %>%
  mutate(family=ifelse(is.na(PR2_family), family, PR2_family)) %>%
  anti_join(pr2, by=taxonomic_ranks)
if ( nrow(tmp) > 0 ) {
  print(tmp)
  if(askYesNo("the above taxa of EukFunc where not found back in PR2, continue anyway?")) {
    print("continue and update DBf")
  } else {
    stop("DBf won't be update")
  }
}

nDBf <- inner_join(pr2,
                   mutate(DBu, across(!!taxonomic_ranks, as.character)) %>%
                     left_join(nem,by="genus") %>%
                     mutate(family=ifelse(is.na(PR2_family), family, PR2_family)),
                   by=taxonomic_ranks) %>%
  mutate(family=ifelse(is.na(corrected_family), family, corrected_family)) %>%
  select(-PR2_family, -corrected_family) %>%
  mutate(across(!!taxonomic_ranks, as.factor)) %>%
  as.data.frame()

# export if different
load("data/DBf.rda")
if( any(all.equal(nDBf,DBf)!=T) ) {
  print("apply changes to DBf")
  DBf<-nDBf
  use_data(DBf, overwrite = TRUE)
} else {
  print("no change to apply to DBf")
}
