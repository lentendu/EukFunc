# Soil Eukaryotes Functional Database - condensed -------------------------------------

library(usethis)
library(tidyverse)

load("data/DBu.rda")
load("R/sysdata.rda")
devtools::load_all()

nDBc <- functionize(DBu, taxonomic_ranks, func_classes) %>%
  mutate(across(!!taxonomic_ranks, ~na_if(., ""))) %>%
  tidyr::unite(taxonomy, !!taxonomic_ranks, sep=";", na.rm = T)

# dplyr::count(DBc, dplyr::across(tidyselect::ends_with("_functional_class")))

# Use only main and secondary functional classes to condense the taxonomy
symb1<-filter(DBu,main_functional_class=="symbiotroph") %>%
  select(species,detailed_functional_class) %>%
  separate(detailed_functional_class,c("d1","d2","d3","d4","d5"),sep="; ",fill="right") %>%
  pivot_longer(-species,names_to="lev",values_to="detailed") %>%
  filter(!is.na(detailed),!grepl("lichenized",detailed)) %>% # lichenized and host phototroph always make two detailed annotation per species (semi-column separated), so remove one
  mutate(det=ifelse(grepl("parasite|pathogen",detailed),"parasite symbiotroph",
                    ifelse(grepl("mycorrhiz",detailed),"mycorrhiza symbiotroph",
                           ifelse(grepl("host phototroph",detailed),"host phototroph symbiotroph","other symbiotroph")))) %>%
  group_by(species) %>%
  summarize(det=paste(unique(sort(det)), collapse="; "))

symb2<-filter(DBu,secondary_functional_class=="symbiotroph") %>%
  select(species,detailed_secondary_functional_class) %>%
  separate(detailed_secondary_functional_class,c("d1","d2","d3","d4","d5"),sep="; ",fill="right") %>%
  pivot_longer(-species,names_to="lev",values_to="detailed") %>%
  filter(!is.na(detailed),!grepl("lichenized",detailed)) %>%
  mutate(det=ifelse(grepl("parasite|pathogen",detailed),"parasite symbiotroph",
                    ifelse(grepl("mycorrhiz",detailed),"mycorrhiza symbiotroph",
                           ifelse(grepl("host phototroph",detailed),"host phototroph symbiotroph","other symbiotroph")))) %>%
  group_by(species) %>%
  summarize(det=paste(unique(sort(det)), collapse="; "))

DBu_symb<-select(DBu, !!taxonomic_ranks, !!func_classes[c(1,3)]) %>%
  full_join(symb1) %>%
  mutate(main_functional_class=ifelse(is.na(det),as.character(main_functional_class),det)) %>%
  select(-det) %>%
  full_join(symb2) %>%
  mutate(secondary_functional_class=ifelse(is.na(det),as.character(secondary_functional_class),det)) %>%
  select(-det)

nDBc_main <- functionize(DBu_symb, taxonomic_ranks, func_classes[c(1,3)]) %>%
  mutate(across(!!taxonomic_ranks, ~na_if(., ""))) %>%
  unite(taxonomy, !!taxonomic_ranks, sep=";", na.rm = T)

nDBu_main<-select(DBu, !!taxonomic_ranks) %>% assign_path(ref=nDBc_main)

#dplyr::count(nDBc_main, dplyr::across(tidyselect::ends_with("_functional_class")))

# use only the main functional class to condense the taxonomy
nDBc_minimal<-functionize(DBu, taxonomic_ranks, func_classes[1]) %>%
  mutate(across(!!taxonomic_ranks, ~na_if(., ""))) %>%
  unite(taxonomy, !!taxonomic_ranks, sep=";", na.rm = T)

# export if different
load("data/DBc.rda")
if( any(all.equal(nDBc,DBc)!=T) ) {
  print("apply changes to DBc")
  DBc<-nDBc
  use_data(DBc, overwrite = TRUE)

  load("data/DBu_main.rda")
  if( any(all.equal(nDBu_main,DBu_main)!=T) ) {
    print("apply changes to DBu_main")
    DBu_main<-nDBu_main
    use_data(DBu_main, overwrite = TRUE)
  } else {
    print("no change to apply to DBu_main")
  }

  load("data/DBc_main.rda")
  if( any(all.equal(nDBc_main,DBc_main)!=T) ) {
    print("apply changes to DBc_main")
    DBc_main<-nDBc_main
    use_data(DBc_main, overwrite = TRUE)

    if( any(all.equal(nDBc_minimal,DBc_minimal)!=T) ) {
      print("apply changes to DBc_minimal")
      DBc_minimal<-nDBc_minimal
      use_data(DBc_minimal, overwrite = TRUE)
    } else {
      print("no change to apply to DBc_minimal")
    }

  } else {
    print("no change to apply to DBc_main")
  }
} else {
  print("no change to apply to DBc")
}


