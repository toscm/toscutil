# Get Function Environment as List

Returns the function environment as list. Raises an error when called
outside a function. By default, objects specified as arguments are
removed from the environment.

## Usage

``` r
function_locals(without = c(), strip_function_args = TRUE)
```

## Arguments

- without:

  character vector of symbols to exclude

- strip_function_args:

  Whether to exclude symbols with the same name as the function
  arguments

## Value

The function environment as list

## Details

The order of the symbols in the returned list is arbitrary.

## Examples

``` r
f <- function(a = 1, b = 2) {
    x <- 3
    y <- 4
    return(function_locals())
}
all.equal(setdiff(f(), list(x = 3, y = 4)), list())
#> [1] TRUE
```
