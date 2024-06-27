library("testthat")

test_that("cat2 works", {
    x <- capture.output(cat2("x:", 1))
    expect_equal(x, "x: 1")
})
