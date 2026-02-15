# Test Near Equality

Tests whether two objects are nearly equal using
[`all.equal()`](https://rdrr.io/r/base/all.equal.html). This provides a
more readable alternative to `isTRUE(all.equal(x, y))`, particularly
useful for comparing objects with length greater than one (vectors,
lists, data frames, etc.) where standard equality operators may not
behave as expected. The operator `%==%` is provided as a shorthand for
`equal()`, but note that the operator form does not accept additional
arguments (use the function form to pass custom tolerance or other
parameters).

## Usage

``` r
equal(x, y, ...)

x %==% y
```

## Arguments

- x, y:

  objects to compare

- ...:

  additional arguments passed to
  [`all.equal()`](https://rdrr.io/r/base/all.equal.html), such as
  `tolerance` to control the comparison threshold. Uses
  [`all.equal()`](https://rdrr.io/r/base/all.equal.html)'s default
  tolerance (currently `sqrt(.Machine$double.eps)`) if not specified.

## Value

`TRUE` if `x` and `y` are nearly equal, `FALSE` otherwise

## See also

[`all.equal()`](https://rdrr.io/r/base/all.equal.html),
[`isTRUE()`](https://rdrr.io/r/base/Logic.html)

## Examples

``` r
# Basic numeric comparisons
equal(1.0, 1.0) # TRUE
#> [1] TRUE
equal(1.0, 1.0 + 1e-9) # TRUE (within default tolerance)
#> [1] TRUE
equal(1.0, 2.0) # FALSE
#> [1] FALSE

# Comparing vectors
equal(c(1, 2, 3), c(1, 2, 3)) # TRUE
#> [1] TRUE
equal(c(1, 2, 3), c(1, 2, 4)) # FALSE
#> [1] FALSE

# Using the operator (note: cannot pass custom arguments)
1.0 %==% 1.0 # TRUE
#> [1] TRUE
1.0 %==% (1.0 + 1e-9) # TRUE (within default tolerance)
#> [1] TRUE
c(1, 2, 3) %==% c(1, 2, 3) # TRUE
#> [1] TRUE

# Comparing lists
equal(list(a = 1, b = 2), list(a = 1, b = 2)) # TRUE
#> [1] TRUE
equal(list(a = 1, b = 2), list(a = 1, b = 3)) # FALSE
#> [1] FALSE

# Special values
equal(NA, NA) # TRUE
#> [1] TRUE
equal(NULL, NULL) # TRUE
#> [1] TRUE
equal(NaN, NaN) # TRUE
#> [1] TRUE
equal(Inf, Inf) # TRUE
#> [1] TRUE
equal(-Inf, -Inf) # TRUE
#> [1] TRUE
equal(Inf, -Inf) # FALSE
#> [1] FALSE

# Pass additional arguments (requires function form)
equal(1.0, 1.1, tolerance = 0.2) # TRUE
#> [1] TRUE
```
