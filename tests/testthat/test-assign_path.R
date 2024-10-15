test_that("main function works", {
  expect_equal(select(taxo_exa[4:6,], !!taxonomic_ranks) %>%
                 apply(1,paste,collapse=";") %>%
                 gsub(";NA","",.) %>%
                 unname() %>%
                 assign_path() %>%
                 pull(main_functional_class),
               c("saprotroph",NA,"symbiotroph"))
  expect_equal(assign_path(taxo_exa[4:6,])$main_functional_class,
               c("saprotroph",NA,"symbiotroph"))
  expect_equal(assign_path(taxo_exa[4:6,1:8])$main_functional_class,
               c(NA,NA,"symbiotroph"))
})
test_that("error works", {
  expect_error(assign_path(taxo_exa[4:6,1:4]),regexp="does not contain a 'taxonomy' or ")
  expect_error(assign_path(1:4),regexp="Input format error")
})
