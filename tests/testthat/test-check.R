library("testthat")

test_that("is.none works correctly", {
  # Test NULL
  expect_true(is.none(NULL))
  
  # Test NA
  expect_true(is.none(NA))
  
  # Test FALSE
  expect_true(is.none(FALSE))
  
  # Test 0
  expect_true(is.none(0))
  
  # Test empty string
  expect_true(is.none(""))
  
  # Test empty list
  expect_true(is.none(list()))
  
  # Test empty character vector
  expect_true(is.none(character()))
  
  # Test empty numeric vector
  expect_true(is.none(numeric()))
  
  # Test empty logical vector
  expect_true(is.none(logical()))
  
  # Test TRUE returns FALSE
  expect_false(is.none(TRUE))
  
  # Test 1 returns FALSE
  expect_false(is.none(1))
  
  # Test non-empty string returns FALSE
  expect_false(is.none("hello"))
  
  # Test non-empty list returns FALSE
  expect_false(is.none(list(1, 2, 3)))
  
  # Test non-empty vector returns FALSE
  expect_false(is.none(c(1, 2, 3)))
})

test_that("%none% operator works correctly", {
  # Test with NULL
  expect_equal(NULL %none% 2, 2)
  
  # Test with NA
  expect_equal(NA %none% 2, 2)
  
  # Test with FALSE
  expect_equal(FALSE %none% 2, 2)
  
  # Test with 0
  expect_equal(0 %none% 2, 2)
  
  # Test with empty string
  expect_equal("" %none% 2, 2)
  
  # Test with empty list
  expect_equal(list() %none% 2, 2)
  
  # Test with character()
  expect_equal(character() %none% 2, 2)
  
  # Test with numeric()
  expect_equal(numeric() %none% 2, 2)
  
  # Test with logical()
  expect_equal(logical() %none% 2, 2)
  
  # Test with non-none value (should return first argument)
  expect_equal(1 %none% 2, 1)
  expect_equal(TRUE %none% 2, TRUE)
  expect_equal("hello" %none% 2, "hello")
  expect_equal(list(1) %none% 2, list(1))
})

test_that("ifthen works correctly", {
  # Test first condition TRUE
  x <- 2
  y <- 2
  z <- 1
  result <- ifthen(x == 0, "foo", y == 0, "bar", z == 1, "baz")
  expect_equal(result, "baz")
  
  # Test second condition TRUE
  result <- ifthen(x == 1, "foo", y == 2, "bar", z == 0, "baz")
  expect_equal(result, "bar")
  
  # Test first condition TRUE (should return first value)
  result <- ifthen(x == 2, "first", y == 2, "second")
  expect_equal(result, "first")
  
  # Test no conditions TRUE (should return NULL)
  result <- ifthen(FALSE, "a", FALSE, "b", FALSE, "c")
  expect_null(result)
})
