test_that("main function works", {
  expect_equal(select(taxo_exa[17:19,], !!taxonomic_ranks) %>%
                 apply(1,paste,collapse=";") %>%
                 gsub(";NA","",.) %>%
                 unname() %>%
                 assign_func() %>%
                 pull(main_functional_class),
               c("parasite symbiotroph","predator",NA))
  expect_equal(assign_func(taxo_exa[17:19,])$main_functional_class,
               c("parasite symbiotroph","predator",NA))
  expect_equal(assign_func(taxo_exa2[1:5,])$main_functional_class,
               c("parasite symbiotroph","predator","phototroph","parasite symbiotroph","predator"))
  expect_equal(suppressWarnings(assign_func(c("Abc;Def"))),
               data.frame(taxonomy="Abc;Def",assigned_from=NA,assigned_at_rank=NA,assigned_from_taxa=NA))
})
