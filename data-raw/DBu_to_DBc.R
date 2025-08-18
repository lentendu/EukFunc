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

# Use only main and secondary functional classes to condense the taxonomy, with additional detail for symbiotroph
DBu_symb<-rowwise(DBu) %>%
  mutate(main_functional_class=ifelse(main_functional_class=="symbiotroph" &
                                        !is.na(detailed_functional_class) &
                                        detailed_functional_class!="",
                                      get_symbio_det(detailed_functional_class),
                                      main_functional_class),
         secondary_functional_class=ifelse(secondary_functional_class=="symbiotroph" &
                                             !is.na(detailed_secondary_functional_class) &
                                             detailed_secondary_functional_class!="",
                                           get_symbio_det(detailed_secondary_functional_class),
                                           secondary_functional_class)) %>%
  ungroup() %>%
  data.frame()

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


