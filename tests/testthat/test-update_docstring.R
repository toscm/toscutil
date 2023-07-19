test_that("update_docstring works", {
    uri <- system.file("testfiles/funcs.R", package = "toscutil")
    content <- readLines(uri)
    updated_docstring <- update_docstring(uri, "f2")
    expected_docstring <- paste(
      "#' @title Sum of Vector Elements",
      "#' @description f3 returns the sum of all the values present in its arguments.",
      "#' @param a Already documented",
      "#' @param b TODO",
      "#' @param x TODO",
      "#' @param ... unused",
      "#' @export",
      "#' @details This is a generic function: methods can be defined for it directly",
      "#' or via the Summary group generic. For this to work properly, the arguments",
      "#' ... should be unnamed, and dispatch is on the first argument.",
      sep = "\n"
    )
    message("\nUPDATED DOCSTRING:")
    message(updated_docstring)
    message("\nEXPECTED DOCSTRING:")
    message(expected_docstring)
    message("")
    testthat::expect_equal(expected_docstring, updated_docstring)
})
