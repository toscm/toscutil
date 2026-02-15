# Truth checking as in Python

Returns `TRUE` if `x` is either `FALSE`, `0`, `NULL`, `NA`and empty
lists or an empty string. Inspired by python's
[bool](https://docs.python.org/3/library/functions.html#bool).

## Usage

``` r
is.none(x)
```

## Arguments

- x:

  object to test

## Value

`TRUE` if `x` is `FALSE`, 0, `NULL`, `NA`, an empty list or an empty
string. Else `FALSE.`

## Examples

``` r
is.none(FALSE) # TRUE
#> [1] TRUE
is.none(0) # TRUE
#> [1] TRUE
is.none(1) # FALSE
#> [1] FALSE
is.none(NA) # TRUE
#> [1] TRUE
is.none(list()) # TRUE
#> [1] TRUE
is.none("") # TRUE
#> [1] TRUE
is.none(character()) # TRUE
#> [1] TRUE
is.none(numeric()) # TRUE
#> [1] TRUE
is.none(logical()) # TRUE
#> [1] TRUE
```
