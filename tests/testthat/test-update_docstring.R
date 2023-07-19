test_that("update_docstring works", {
    uri <- system.file("testfiles/funcs.R", package = "toscutil")
    content <- readLines(uri)
    local({ # Content of uri looks like this:
      #' @title Sum of Vector Elements
      #' @description f3 returns the sum of all the values present in its arguments.
      #' @param b TODO
      #' @param a Already documented
      #' @export
      #' @param z Multiline description
      #'
      #' of parameter z.
      #'
      #' @param ... unused
      #' @details This is a generic function: methods can be defined for it directly
      #' or via the Summary group generic. For this to work properly, the arguments
      #' ... should be unnamed, and dispatch is on the first argument.
      f2 <- function(a, b, x = 1, ...) {
        cat("f3")
      }
    })
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
    testthat::expect_equal(expected_docstring, updated_docstring)
})
