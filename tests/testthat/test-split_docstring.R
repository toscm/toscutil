test_that("update_docstring works", {
    uri <- system.file("testfiles/funcs.R", package = "toscutil")
    content <- readLines(uri)
    docstring <- get_docstring(content, "f2")
    dfs <- split_docstring(docstring)
    head_expected <- c(
      header = "",
      title = "#' @title Sum of Vector Elements\n",
      description = "#' @description f3 returns the sum of all the values present in its arguments.\n"
    )
    param_expected <- c(
      b = "#' @param b TODO\n",
      a = "#' @param a Already documented\n",
      z = "#' @param z Multiline description\n#'\n#' of parameter z.\n#'\n",
      ... = "#' @param ... unused\n"
    )
    tail_expected <- c(
      export = "#' @export\n",
      details = "#' @details This is a generic function: methods can be defined for it directly\n#' or via the Summary group generic. For this to work properly, the arguments\n#' ... should be unnamed, and dispatch is on the first argument."
    )
    testthat::expect_equal(dfs$head, head_expected)
    testthat::expect_equal(dfs$param, param_expected)
    testthat::expect_equal(dfs$tail, tail_expected)
})
