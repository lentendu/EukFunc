test_that("main function works", {
  expect_equal(assign_genbank("AB918716.1,EU039893.1,JF747215.1")$main_functional_class,"predator")
  expect_equal(is.na(assign_genbank("EU039893.1, JF747215.1")$main_functional_class),TRUE)
  expect_equal(assign_genbank(c("EU039893.1, JF747215.1","AB918716.1,EU039893.1,JF747215.1"))$main_functional_class,c(NA,"predator"))
})
