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

# update to PR2 v5.0.0
devtools::load_all()
library(pr2database)
pr2<-pr2_database() %>%
  select(pr2_accession,all_of(taxonomic_ranks)) %>%
  filter(domain=="Eukaryota") %>% 
  mutate(across(all_of(taxonomic_ranks),as.factor))
taxo_exa_new<-ldply(taxo_exa$reference,consensing,db=pr2) %>%
  separate(assigned_taxonomy,taxonomic_ranks,sep=";",fill="right")
count(taxo_exa_new, domain, supergroup)
taxo_exa<-select(taxo_exa,repseq,reference,similarity,starts_with("boot")) %>%
  unite("bootstrap",starts_with("boot"),sep=",") %>%
  mutate(bootstrap=sub(".*,","",sub("(,0)*$","",bootstrap))) %>%
  cbind(select(taxo_exa_new,all_of(taxonomic_ranks))) %>%
  select(repseq,all_of(taxonomic_ranks),bootstrap,similarity,reference) %>%
  filter(domain!="unknown")

usethis::use_data(taxo_exa, overwrite = TRUE)
