# Update docstring for a Function

The [roxygen2](https://roxygen2.r-lib.org/) package makes it possible to
write documentation for R functions directly above the corresponding
function. This function can be used to update the parameter list of a
documentation string (docstring) of a valid function of a valid R file.
The update is done by comparing the currently listed parameters with the
actual function parameters. Outdated parameters are removed and missing
parameters are added to the docstring.

## Usage

``` r
update_docstring(uri, func, content = NULL)
```

## Arguments

- uri:

  Path to R file.

- func:

  Function name. If a function is defined multiple times inside the
  provided file, only the last occurence will be considered.

- content:

  R code as string. If provided, uri is ignored.

## Value

A character vector of length 1 containing the updated docstring.

## Examples

``` r
uri <- system.file("testfiles/funcs.R", package = "toscutil")
func <- "f4"
update_docstring(uri, func)
#> [1] "#' @title TODO (e.g. 'Sum of Vector Elements')\n#' @description TODO (e.g. 'sum returns the sum of all the values present in its arguments.'\n#' @param a TODO\n#' @param b TODO\n#' @param x TODO\n#' @param ... TODO\n"
```
