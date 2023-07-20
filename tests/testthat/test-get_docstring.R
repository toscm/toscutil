testthat::test_that(
  desc = "get_docstring",
  code = {
    uri <- system.file("testfiles/funcs.R", package = "toscutil")
    content <- readLines(uri)
    f1_docstring <- get_docstring(content, "f1")
    f2_docstring <- get_docstring(content, "f2")
    f4_docstring <- get_docstring(content, "f4", template = "")
    f2_docstring_expected <- paste0(
      "#' @title Sum of Vector Elements\n",
      "#' @description f3 returns the sum of all the values present in its arguments.\n",
      "#' @param b TODO\n",
      "#' @param a Already documented\n",
      "#' @export\n",
      "#' @param z Multiline description\n",
      "#'\n",
      "#' of parameter z.\n",
      "#'\n",
      "#' @param ... unused\n",
      "#' @details This is a generic function: methods can be defined for it directly\n",
      "#' or via the Summary group generic. For this to work properly, the arguments\n",
      "#' ... should be unnamed, and dispatch is on the first argument.\n"
    )
    testthat::expect_equal(f1_docstring, DOCSTRING_TEMPLATE)
    testthat::expect_equal(f2_docstring, f2_docstring_expected)
    testthat::expect_equal(f4_docstring, "")
  }
)
