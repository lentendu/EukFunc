test_that("main function works", {
  expect_equal(assign_sp(taxo_exa[3,])$main_functional_class,"saprotroph")
  expect_equal(assign_sp("Spathidium_foissneri")$main_functional_class,"predator")
  expect_equal(assign_sp(taxo_exa$species[c(3,6,12)])$main_functional_class, c("saprotroph", "saprotroph", "symbiotroph"))
})
test_that("error messages ok", {
  expect_error(assign_sp(TRUE), regexp="A vector or data-frame is expected as input")
  expect_error(assign_sp(c(2,5,7)), regexp="A vector or data-frame is expected as input")
  expect_error(assign_sp(data.frame(genus=c(2,5,7))), regexp="A 'species' or 'Species' column is expected in the input data-frame")
  expect_error(assign_sp(data.frame(sp=c(2,5,7))), regexp="A 'species' or 'Species' column is expected in the input data-frame")
})
