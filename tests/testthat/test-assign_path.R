test_that("main function works", {
  expect_equal(select(taxo_exa[6:8,], !!taxonomic_ranks) %>%
                 apply(1,paste,collapse=";") %>%
                 gsub(";NA","",.) %>%
                 unname() %>%
                 assign_path() %>%
                 pull(main_functional_class),
               c("saprotroph",NA,"phototroph"))
  expect_equal(assign_path(taxo_exa[6:8,])$main_functional_class,
               c("saprotroph",NA,"phototroph"))
  expect_equal(assign_path(taxo_exa[6:8,1:8])$main_functional_class,
               c(NA,NA,"phototroph"))
})
test_that("error works", {
  expect_error(assign_path(taxo_exa[6:8,1:4]),regexp="does not contain a 'taxonomy' or ")
  expect_error(assign_path(1:4),regexp="Input format error")
})
