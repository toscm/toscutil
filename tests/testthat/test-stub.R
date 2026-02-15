test_that("stub works", {
    f <- function(x, y = 2, z = 3) x + y + z
    args <- stub(f, x = 1)
    expect_equal(x, 1)
    expect_equal(y, 2)
    expect_equal(z, 3)
    expect_equal(args, list(x = 1, y = 2, z = 3))
})

test_that("stub returns invisibly and shows str output", {
    f <- function(x, y = 2, z = 3) x + y + z

    # Capture output - should only see str() output, not the full list
    output <- capture.output(result <- stub(f, x = 1))

    # str() should produce output
    expect_true(length(output) > 0)

    # Output should contain "List of" from str()
    expect_true(
        object = any(grepl("Created 3 variables in .*", output)),
        info = sprintf(
            "Output should be 'Created 3 variables in .*', but is '%s'",
            paste(output, collapse = "\n")
        )
    )

    # Result should still be capturable
    expect_equal(result, list(x = 1, y = 2, z = 3))

    # Variables should still be assigned
    expect_equal(x, 1)
    expect_equal(y, 2)
    expect_equal(z, 3)
})

test_that("stub uses GlobalEnv for missing args", {
    # Test basic case: missing arg exists in GlobalEnv
    f <- function(x, y = 2) x + y
    assign("x", 1, envir = .GlobalEnv)

    args <- stub(f)
    expect_equal(x, 1)
    expect_equal(y, 2)
    expect_equal(args, list(x = 1, y = 2))

    # Clean up
    rm(x, envir = .GlobalEnv)
})

test_that("stub prefers explicit args over GlobalEnv", {
    # Set up GlobalEnv value
    assign("x", 1, envir = .GlobalEnv)

    f <- function(x, y = 2) x + y
    args <- stub(f, x = 10)

    # Explicit argument should override GlobalEnv
    expect_equal(x, 10)
    expect_equal(y, 2)
    expect_equal(args, list(x = 10, y = 2))

    # Clean up
    rm(x, envir = .GlobalEnv)
})

test_that("stub fails when missing arg not in GlobalEnv", {
    # Function with required arg that doesn't exist in GlobalEnv
    g <- function(z) z * 2

    # Should fail with informative error
    expect_error(stub(g), "argument 'z' is missing, with no default and not found in .GlobalEnv", fixed = TRUE)

    # Verify it doesn't use other variables in GlobalEnv
    assign("x", 100, envir = .GlobalEnv)
    h <- function(z) z * 2
    expect_error(stub(h), "argument 'z' is missing, with no default and not found in .GlobalEnv", fixed = TRUE)

    # Clean up
    rm(x, envir = .GlobalEnv)
})

test_that("stub handles multiple missing args from GlobalEnv", {
    # Set up multiple values in GlobalEnv
    assign("a", 1, envir = .GlobalEnv)
    assign("b", 2, envir = .GlobalEnv)

    f <- function(a, b, c = 3) a + b + c
    args <- stub(f)

    expect_equal(a, 1)
    expect_equal(b, 2)
    expect_equal(c, 3)
    expect_equal(args, list(a = 1, b = 2, c = 3))

    # Clean up
    rm(a, b, envir = .GlobalEnv)
})

test_that("stub handles mix of GlobalEnv and explicit args", {
    # Set up GlobalEnv value
    assign("x", 1, envir = .GlobalEnv)

    f <- function(x, y, z = 3) x + y + z
    args <- stub(f, y = 10)

    # x from GlobalEnv, y explicit, z default
    expect_equal(x, 1)
    expect_equal(y, 10)
    expect_equal(z, 3)
    expect_equal(args, list(x = 1, y = 10, z = 3))

    # Clean up
    rm(x, envir = .GlobalEnv)
})
