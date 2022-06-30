library("testthat")

test_that("caller works", {
  f <- function() caller(1)
  g <- function() f()
  expect_equal(f(), "f")
  expect_equal(g(), "f")

  f <- function() caller(2)
  g <- function() f()
  expect_equal(g(), "g")
  expect_equal(f(), "eval_bare")
  # caller(0): caller
  # caller(1): f
  # caller(2): eval_bare
  # caller(3): quasi_label
  # caller(4): expect_equal
  # ...
  # caller(40): test_local()
  
  f <- function() caller(100)
  expect_null(f())
})
