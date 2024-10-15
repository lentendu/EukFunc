# script to generate the initial species list from PR2 for which functions are assigned by taxonomist
# remove exclusively aquatic taxa, prokaryotes, metazoa other than nematodes and embryophyceae
# relabel nematoda clades

library(usethis)
library(tidyverse)
library(DBI)

# version 4.12.0
version<-"4.12.0"
rmtaxa<-readRDS(paste0("data-raw/removed_taxa_",version,".rds"))
nema<-read.delim("data-raw/Nematoda.genus.corrected_taxonomy_vs_PR2.tsv", stringsAsFactors = F)
pr2sql<-paste0("https://github.com/pr2database/pr2database/releases/download/v",version,"/pr2_version_",version,".sqlite.gz")
download.file(pr2sql,basename(pr2sql))
R.utils::gunzip(basename(pr2sql))
mypr2 <- dbConnect(RSQLite::SQLite(), sub("\\.[^\\.]*$","",basename(pr2sql)))
# dbListTables(mypr2)
pr2taxo<-dbReadTable(mypr2,"pr2_taxonomy") %>%
  left_join(nema) %>%
  mutate(family=ifelse(is.na(corrected_family),family,corrected_family)) %>%
  select(-PR2_family,-corrected_family)
pr2species<-select(pr2taxo,!!taxonomic_ranks)
for(x in names(rmtaxa)) {
  pr2species<-filter(pr2species, ! (!!sym(x)) %in% rmtaxa[[x]])
}
write.table(arrange(pr2species,across(all_of(names(rmtaxa)))),"species.tsv",sep="\t",h=T,quote=F,row.names=F)
unlink(sub("\\.[^\\.]*$","",basename(pr2sql)))
