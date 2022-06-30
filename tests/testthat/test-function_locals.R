test_that("function_locals works", {
  f <- function(w = 1, x = 2) {
    y <- 3
    z <- 4
    return(function_locals())
  }
  # browser()
  ret <- f()
  expect_equal(ret, list(y = 3, z = 4)[names(ret)])

  f <- function(w = 1, x = 2) {
    y <- 3
    z <- 4
    return(function_locals(strip_function_args=FALSE))
  }
  ret <- f()
  expect_equal(ret, list(w = 1, x = 2, y = 3, z = 4)[names(ret)])
})
