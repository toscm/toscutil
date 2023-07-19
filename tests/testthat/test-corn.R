testthat::test_that(
  desc = "corn",
  code = {
    testthat::expect_equal(
      object = corn(matrix(1:100, 10), 1),
      expected = matrix(c(1, 10, 91, 100), 2)
    )
  }
)
