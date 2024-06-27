library("testthat")

test_that("check_pkg_docs works", {
    df <- get_pkg_docs("tools")
    nchars <- as.data.frame(apply(df, 2, function(col) sapply(col, nchar)))
    expect_true(nrow(df) >= 40) # In 2024/06/27 `tools` had 50 functions , but let's test for 40 in case they remove some.
    expect_true(ncol(df) == 6)
    expect_true(all(nchars$class > 0))
    expect_true(all(nchars$title > 0))
    expect_true(all(nchars$description > 0))
    expect_true(sum(nchars$value == 0) <= 15) # In 2024/06/27, 8 functions didn't have a documented return value, but let's test for 15 in case they add some new functions without documenting their return value.
    expect_true(sum(nchars$examples == 0) <= 30) # In 2024/06/27, 22 functions didn't have examples, but let's test for 30 in case they add some new functions without examples.
})

