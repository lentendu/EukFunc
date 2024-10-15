test_that("main function works", {
  expect_equal(assign_genbank("AB918716.1,EU039893.1,JF747215.1")$main_functional_class,"predator")
  expect_equal(assign_genbank("EU039893.1, JF747215.1")$main_functional_class,"predator")
  expect_equal(assign_genbank(c("EU039893.1, JF747215.1","AB918716.1,EU039893.1,JF747215.1"))$main_functional_class,c("predator","predator"))
})
