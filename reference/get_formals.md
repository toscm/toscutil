# Get formals of a Function

Returns the arguments of a function from a valid R file.

## Usage

``` r
get_formals(uri, content, func)
```

## Arguments

- uri:

  Path to R file.

- content:

  R code as string.

- func:

  Function name. If a function is defined multiple times inside the
  provided file, only the last occurence will be considered.

## Value

A named character vector as returned by
[`formals()`](https://rdrr.io/r/base/formals.html).

## Examples

``` r
uri <- system.file("testfiles/funcs.R", package = "toscutil")
content <- readLines(uri)
func <- "f2"
if (requireNamespace("languageserver", quietly = TRUE)) {
    get_formals(uri, content, func)
}
#> $a
#> 
#> 
#> $b
#> 
#> 
#> $x
#> [1] 1
#> 
#> $...
#> 
#> 
```
