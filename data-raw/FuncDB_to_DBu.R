# Soil Eukaryotes Functional Database - species level -------------------------------------

library(usethis)
library(tidyverse)

load("R/sysdata.rda")

DB <- read.table("data-raw/FuncDB_species.tsv", h=T, sep="\t", stringsAsFactors=F, quote="\"", check.names=F) %>%
  rename_all(~gsub("[\\. ]", "_", .))

# update taxonomy and functional class names if needed
tr <- colnames(DB)[1:which(colnames(DB)=="species")]
if ( any(all.equal(taxonomic_ranks,tr)!=T) ) {
  print("found changes in taxonomic ranks column names")
  full_join(data.frame(from=taxonomic_ranks,join=taxonomic_ranks),
            data.frame(join=tr,to=tr)) %>%
    select(-join) %>%
    filter(is.na(from) | is.na(to) | from!=to) %>%
    print()
  if (askYesNo("Warning: changing the number and name of taxonomic rank columns may break package functions, use with caution.\nApply changes?")) {
    taxonomic_ranks<-tr
    use_data(taxonomic_ranks, func_classes, internal = TRUE, overwrite = TRUE)
  } else {
    stop("taxonomic rank columns kept unchanged; stop here")
  }
}

fc <- colnames(DB)[which(colnames(DB)=="main_functional_class"):which(colnames(DB)=="potential_human_pathogen")]
if ( any(all.equal(func_classes,fc)!=T) ) {
  print("found changes in functional classes column names")
  full_join(data.frame(from=func_classes,join=func_classes),
            data.frame(join=fc,to=fc)) %>%
    select(-join) %>%
    filter(is.na(from) | is.na(to) | from!=to) %>%
    print()
  if (askYesNo("Warning: changing the number and name of functional classes columns may break package functions, use with caution.\nApply changes?")) {
    func_classes<-fc
    use_data(taxonomic_ranks, func_classes, internal = TRUE, overwrite = TRUE)
  } else {
    stop("functional classes columns kept unchanged; stop here")
  }
}

# create DBu
# nDBu <- mutate(DB, across(all_of(c(taxonomic_ranks, func_classes)), as.factor)) %>%
nDBu <- arrange(DB,across(!!taxonomic_ranks)) %>%
  mutate(comment=stringi::stri_escape_unicode(comment))

# export if different
load("data/DBu.rda")
if( any(all.equal(nDBu,DBu)!=T) ) {
  print("found differences in DBu:")
  # report differences
  for (i in c(taxonomic_ranks,func_classes)) {
    if( any(all.equal(pull(nDBu,!!i),pull(DBu,!!i))!=T)) {
    print(paste("# changes in column:",i))
    data.frame(from=pull(DBu,!!i),to=pull(nDBu,!!i)) %>%
      mutate(across(everything(),~as.character(.))) %>%
      filter(from!=to) %>%
      count(from,to) %>%
      print()
    }
  }
  # overwrite if ok
  if (askYesNo("apply changes to DBu?")) {
    DBu<-nDBu
    use_data(DBu, overwrite = TRUE)
    # apply changes for the other database formats
    if (askYesNo("apply same changes to DBc and DBf too?")) {
      source("data-raw/DBu_to_DBc.R")
      source("data-raw/DBu_to_DBf.R")
    }
  }
} else {
  print("no change to apply to DBu")
}
