library("testthat")

test_that("caller works", {
    x <- local({
        trace_func("ls.str", "utils")
        on.exit(untrace_func("ls.str", asNamespace("utils")))
        capture.output(utils::ls.str(1), type = "message")
    })
    testthat::expect_match(x[1], "....-..-.. ..:..:..... .0. utils..ls.str.1.")
    testthat::expect_match(x[2], "....-..-.. ..:..:..... .0. exit")
})
