# Return Corners of Matrix like Objects

Similar to [`head()`](https://rdrr.io/r/utils/head.html) and
[`tail()`](https://rdrr.io/r/utils/head.html), but returns `n` rows/cols
from each side of `x` (i.e. the corners of `x`).

## Usage

``` r
corn(x, n = 2L)
```

## Arguments

- x:

  matrix like object

- n:

  number of cols/rows from each corner to return

## Value

`x[c(1:n, N-n:N), c(1:n, N-n:N)]`

## Examples

``` r
corn(matrix(1:10000, 100))
#>      [,1] [,2] [,3]  [,4]
#> [1,]    1  101 9801  9901
#> [2,]    2  102 9802  9902
#> [3,]   99  199 9899  9999
#> [4,]  100  200 9900 10000
```
