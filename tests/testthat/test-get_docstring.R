testthat::test_that(
  desc = "get_docstring",
  code = {
    uri <- system.file("testfiles/funcs.R", package = "toscutil")
    content <- readLines(uri)
    f1_docstring <- get_docstring(content, "f1")
    f2_docstring <- get_docstring(content, "f2")
    f4_docstring <- get_docstring(content, "f4", template = "")
    f2_docstring_expected <- paste(
      "#' @title Sum of Vector Elements",
      "#' @description f3 returns the sum of all the values present in its arguments.",
      "#' @param b TODO",
      "#' @param a Already documented",
      "#' @export",
      "#' @param z Multiline description",
      "#'",
      "#' of parameter z.",
      "#'",
      "#' @param ... unused",
      "#' @details This is a generic function: methods can be defined for it directly",
      "#' or via the Summary group generic. For this to work properly, the arguments",
      "#' ... should be unnamed, and dispatch is on the first argument.",
      sep = "\n"
    )
    testthat::expect_equal(f1_docstring, DOCSTRING_TEMPLATE)
    testthat::expect_equal(f2_docstring, f2_docstring_expected)
    testthat::expect_equal(f4_docstring, "")
  }
)
