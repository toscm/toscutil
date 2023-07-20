test_that("split_docstring works for f2", {
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
      details = paste0(
        "#' @details This is a generic function: methods can be defined for it directly\n",
        "#' or via the Summary group generic. For this to work properly, the arguments\n",
        "#' ... should be unnamed, and dispatch is on the first argument.\n"
      )
    )
    testthat::expect_equal(dfs$head, head_expected)
    testthat::expect_equal(dfs$param, param_expected)
    testthat::expect_equal(dfs$tail, tail_expected)
})

test_that("split_docstring works for f4", {
    uri <- system.file("testfiles/funcs.R", package = "toscutil")
    content <- readLines(uri)
    docstring <- get_docstring(content, "f4")
    dfs <- split_docstring(docstring)
    head_expected <- c(
      header = "",
      title = "#' @title TODO (e.g. 'Sum of Vector Elements')\n",
      description = "#' @description TODO (e.g. 'sum returns the sum of all the values present in its arguments.'\n"
    )
    param_expected <- structure(character(0), names = character(0))
    tail_expected <- structure(character(0), names = character(0))
    testthat::expect_equal(dfs$head, head_expected)
    testthat::expect_equal(dfs$param, param_expected)
    testthat::expect_equal(dfs$tail, tail_expected)
})

test_that("split_docstring works for f5", {
    uri <- system.file("testfiles/funcs.R", package = "toscutil")
    content <- readLines(uri)
    docstring <- get_docstring(content, "f5")
    dfs <- split_docstring(docstring)
    head_expected <- c(header = "", title = "#' @title The Title\n", description = "#' @description some description\n")
    param_expected <- c(a = "#' @param a Aaaaaa\n", b = "#' @param b BbbBbb\n", z = "#' @param z ZzZzZz\n")
    tail_expected <- c(details = "#' @details Some details\n", export = "#' @export\n")
    testthat::expect_equal(dfs$head, head_expected)
    testthat::expect_equal(dfs$param, param_expected)
    testthat::expect_equal(dfs$tail, tail_expected)
})
