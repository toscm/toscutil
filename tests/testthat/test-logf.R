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

test_that("logf file and append arguments work", {
    temp_file <- tempfile()
    on.exit(unlink(temp_file))
    
    # Test writing to file
    logf("First message", file = temp_file, prefix = function() "", sep1 = "", end = "\n")
    content1 <- readLines(temp_file)
    testthat::expect_equal(content1, "First message")
    
    # Test overwriting file (append = FALSE)
    logf("Second message", file = temp_file, append = FALSE, prefix = function() "", sep1 = "", end = "\n")
    content2 <- readLines(temp_file)
    testthat::expect_equal(content2, "Second message")
    testthat::expect_length(content2, 1)
    
    # Test appending to file
    logf("Third message", file = temp_file, append = TRUE, prefix = function() "", sep1 = "", end = "\n")
    content3 <- readLines(temp_file)
    testthat::expect_equal(content3, c("Second message", "Third message"))
    testthat::expect_length(content3, 2)
})

