test_that("stub works", {
  f <- function(x, y = 2, z = 3) x + y + z
  args <- stub(f, x = 1)
  expect_equal(x, 1)
  expect_equal(y, 2)
  expect_equal(z, 3)
  expect_equal(args, list(x = 1, y = 2, z = 3))
})
