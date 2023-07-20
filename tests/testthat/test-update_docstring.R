test_that("update_docstring works", {
    uri <- system.file("testfiles/funcs.R", package = "toscutil")
    content <- readLines(uri)
    updated_docstring_f2 <- update_docstring(uri, "f2")
    expected_docstring_f2 <- paste0(
      "#' @title Sum of Vector Elements\n",
      "#' @description f3 returns the sum of all the values present in its arguments.\n",
      "#' @param a Already documented\n",
      "#' @param b TODO\n",
      "#' @param x TODO\n",
      "#' @param ... unused\n",
      "#' @export\n",
      "#' @details This is a generic function: methods can be defined for it directly\n",
      "#' or via the Summary group generic. For this to work properly, the arguments\n",
      "#' ... should be unnamed, and dispatch is on the first argument.\n"
    )
    updated_docstring_f4 <- update_docstring(uri, "f4")
    expected_docstring_f4 <- paste0(
      "#' @title .*\n",
      "#' @description .*\n",
      "#' @param a TODO\n",
      "#' @param b TODO\n",
      "#' @param x TODO\n",
      "#' @param ... TODO\n"
    )
    updated_docstring_f5 <- update_docstring(uri, "f5")
    expected_docstring_f5 <- paste0(
      "#' @title The Title\n",
      "#' @description some description\n",
      "#' @param a Aaaaaa\n",
      "#' @param b BbbBbb\n",
      "#' @param x TODO\n",
      "#' @details Some details\n",
      "#' @export\n"
    )
    testthat::expect_equal(updated_docstring_f2, expected_docstring_f2)
    testthat::expect_match(updated_docstring_f4, expected_docstring_f4, perl = TRUE)
    testthat::expect_equal(updated_docstring_f5, expected_docstring_f5)
})
