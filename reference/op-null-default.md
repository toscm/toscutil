# Return Default if None

Like
[`rlang::%||%()`](https://rlang.r-lib.org/reference/op-null-default.html)
but also checks for empty lists and empty strings.

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
