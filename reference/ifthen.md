# Shortcut for multiple if else statements

`ifthen(a, b, c, d, e, f, ...)` ==
`if (a) b else if (c) d else if (e) f`

## Usage

``` r
ifthen(...)
```

## Arguments

- ...:

  pairs of checks and corresponding return values

## Value

`ifelse` returns the first value for which the corresponding statement
evaluates to TRUE

## Examples

``` r
x <- 2
y <- 2
z <- 1
ifthen(x == 0, "foo", y == 0, "bar", z == 1, "this string gets returned")
#> [1] "this string gets returned"
```
