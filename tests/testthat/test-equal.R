library("testthat")

test_that("equal works with identical values", {
  expect_true(equal(1, 1))
  expect_true(equal(1.0, 1.0))
  expect_true(equal("a", "a"))
  expect_true(equal(TRUE, TRUE))
  expect_true(equal(c(1, 2, 3), c(1, 2, 3)))
})

test_that("equal works with nearly equal numeric values", {
  # all.equal's default tolerance is sqrt(.Machine$double.eps) ~ 1.5e-8
  expect_true(equal(1.0, 1.0 + 1e-9))
  expect_true(equal(1.0, 1 + .Machine$double.eps))
})

test_that("equal returns FALSE for different values", {
  expect_false(equal(1, 2))
  expect_false(equal(1.0, 2.0))
  expect_false(equal("a", "b"))
  expect_false(equal(TRUE, FALSE))
  expect_false(equal(c(1, 2, 3), c(1, 2, 4)))
  # Differences larger than tolerance
  expect_false(equal(1.0, 1.0001))
})

test_that("equal handles different types correctly", {
  expect_false(equal(1, "1"))
  expect_false(equal(1, TRUE))
  expect_false(equal(list(a = 1), c(a = 1)))
})

test_that("equal passes ... to all.equal", {
  # With relaxed tolerance, these should be equal
  expect_true(equal(1.0, 1.0001, tolerance = 0.001))
  expect_true(equal(1.0, 1.1, tolerance = 0.2))
  
  # With strict tolerance, they should not be equal
  expect_false(equal(1.0, 1.0 + 1e-9, tolerance = 1e-10))
})

test_that("equal handles edge cases", {
  expect_true(equal(NA, NA))
  expect_true(equal(NULL, NULL))
  expect_true(equal(list(), list()))
  expect_true(equal(character(0), character(0)))
})

test_that("%==% operator works with identical values", {
  expect_true(1 %==% 1)
  expect_true(1.0 %==% 1.0)
  expect_true("a" %==% "a")
  expect_true(TRUE %==% TRUE)
  expect_true(c(1, 2, 3) %==% c(1, 2, 3))
})

test_that("%==% operator works with nearly equal numeric values", {
  # all.equal's default tolerance is sqrt(.Machine$double.eps) ~ 1.5e-8
  expect_true(1.0 %==% (1.0 + 1e-9))
  expect_true(1.0 %==% (1 + .Machine$double.eps))
})

test_that("%==% operator returns FALSE for different values", {
  expect_false(1 %==% 2)
  expect_false(1.0 %==% 2.0)
  expect_false("a" %==% "b")
  expect_false(TRUE %==% FALSE)
  expect_false(c(1, 2, 3) %==% c(1, 2, 4))
  # Differences larger than tolerance
  expect_false(1.0 %==% 1.0001)
})

test_that("%==% operator handles edge cases", {
  expect_true(NA %==% NA)
  expect_true(NULL %==% NULL)
  expect_true(list() %==% list())
  expect_true(character(0) %==% character(0))
})

test_that("equal and %==% are consistent", {
  # Test various values to ensure equal() and %==% behave the same
  expect_equal(equal(1, 1), 1 %==% 1)
  expect_equal(equal(1, 2), 1 %==% 2)
  expect_equal(equal("a", "a"), "a" %==% "a")
  expect_equal(equal("a", "b"), "a" %==% "b")
  expect_equal(equal(c(1, 2, 3), c(1, 2, 3)), c(1, 2, 3) %==% c(1, 2, 3))
  expect_equal(equal(c(1, 2, 3), c(1, 2, 4)), c(1, 2, 3) %==% c(1, 2, 4))
})
