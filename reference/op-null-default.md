# Return Default if None

Returns the second operand if the first operand is `NULL`, `FALSE`, `0`,
`NA`, an empty list, or an empty string. Otherwise returns the first
operand.

## Usage

``` r
x %none% y
```

## Arguments

- x:

  object to test

- y:

  object to return if `is.none(x)`

## Value

Returns `y` if `is.none(x)` else `x`

## See also

[`is.none()`](https://toscm.github.io/toscutil/reference/is.none.md)

## Examples

``` r
FALSE %none% 2 # returns 2
#> [1] 2
0 %none% 2 # returns 2
#> [1] 2
NA %none% 2 # returns 2
#> [1] 2
list() %none% 2 # returns 2
#> [1] 2
"" %none% 2 # returns 2
#> [1] 2
1 %none% 2 # returns 1
#> [1] 1
```
