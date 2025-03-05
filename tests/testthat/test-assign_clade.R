test_that("main function works", {
  expect_equal(select(taxo_exa[6:8,], !!taxonomic_ranks) %>%
                 apply(1,paste,collapse=";") %>%
                 gsub(";NA","",.) %>%
                 unname() %>%
                 assign_clade() %>%
                 pull(main_functional_class),
               c("saprotroph",NA,"phototroph"))
  expect_equal(assign_clade(taxo_exa[6:8,])$main_functional_class,
               c("saprotroph",NA,"phototroph"))
  expect_equal(assign_clade(taxo_exa[6:8,1:9])$main_functional_class,
               c("saprotroph",NA,"phototroph"))
  expect_equal(assign_clade(taxo_exa2[1:5,])$main_functional_class,
               c(NA,"predator","phototroph","symbiotroph","predator"))
  expect_equal(suppressWarnings(assign_clade(c("Abc;Def"))),
               data.frame(taxonomy="Abc;Def",assigned_from=NA,assigned_at_rank=NA,assigned_from_taxa=NA))
})
test_that("error works", {
  expect_error(assign_clade(taxo_exa[6:8,1:4]),regexp="does not contain a 'taxonomy' or ")
  expect_error(assign_clade(1:4),regexp="Input format error")
})
