library("testthat")

test_that("check_pkg_docs works", {
    df <- check_pkg_docs("tools")
    expect_true(nrow(df) >= 40) # In 2024/06/27 `tools` had 50 functions , but let's test for 40 in case they remove some.
    expect_equal(colnames(df), c("class", "title", "description", "value", "format", "examples"))
})
