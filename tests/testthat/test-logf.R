library("testthat")

test_that("logf works", {
    x <- capture.output(logf("Hello, %s!", "world"))
    y <- capture.output(logf("Goodbye", prefix = function() "", sep1 = "", end = "!\n"))
    z <- capture.output(local({
        opts <- options(toscutil.logf.prefix = function() "LOG:", toscutil.logf.end = "\n")
        on.exit(options(opts))
        logf("Hello, %s!", "world")
    }))
    testthat::expect_match(x, "....-..-.. ..:..:..... Hello, world!")
    testthat::expect_match(y, "Goodbye!")
    testthat::expect_match(z, "LOG: Hello, world!")
})

