tmp<-filter(DBu,supergroup=="Amoebozoa" | division=="Alveolata") %>%
  functionize(taxonomic_ranks, func_classes)
test_that("DBc is corresponding to current functionize", {
  expect_equal(mutate(tmp,across(!!taxonomic_ranks, ~na_if(., ""))) %>%
                 tidyr::unite(taxonomy, !!taxonomic_ranks, sep=";", na.rm = T),
               filter(DBc,grepl("^Eukaryota;TSAR;Alveolata|^Eukaryota;Amoebozoa",taxonomy)))
})
test_that("counting works", {
  expect_equal(sum(tmp$count), nrow(filter(DBu,supergroup=="Amoebozoa" | division=="Alveolata")))
})
