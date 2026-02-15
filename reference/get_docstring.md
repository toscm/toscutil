# Get docstring for a Function

The [roxygen2](https://roxygen2.r-lib.org/) package makes it possible to
write documentation for R functions directly above the corresponding
function. This function can be used to retrieve the full documentation
string (docstring).

## Usage

``` r
get_docstring(content, func, collapse = TRUE, template = DOCSTRING_TEMPLATE)
```

## Arguments

- content:

  R code as string.

- func:

  Name of function to get docstring for.

- collapse:

  Whether to collapse all docstring into a single string.

- template:

  String to return in case no docstring could be found.

## Value

A character vector of length 1 containing either the docstring or the
empty string (in case no documentation could be detected).

## Examples

``` r
uri <- system.file("testfiles/funcs.R", package = "toscutil")
content <- readLines(uri)
func <- "f2"
get_docstring(content, func)
#> [1] "#' @title Sum of Vector Elements\n#' @description f3 returns the sum of all the values present in its arguments.\n#' @param b TODO\n#' @param a Already documented\n#' @export\n#' @param z Multiline description\n#'\n#' of parameter z.\n#'\n#' @param ... unused\n#' @details This is a generic function: methods can be defined for it directly\n#' or via the Summary group generic. For this to work properly, the arguments\n#' ... should be unnamed, and dispatch is on the first argument.\n"
get_docstring(content, func, collapse = TRUE)
#> [1] "#' @title Sum of Vector Elements\n#' @description f3 returns the sum of all the values present in its arguments.\n#' @param b TODO\n#' @param a Already documented\n#' @export\n#' @param z Multiline description\n#'\n#' of parameter z.\n#'\n#' @param ... unused\n#' @details This is a generic function: methods can be defined for it directly\n#' or via the Summary group generic. For this to work properly, the arguments\n#' ... should be unnamed, and dispatch is on the first argument.\n"
```
