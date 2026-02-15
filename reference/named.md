# Create automatically named List

Like normal [`list()`](https://rdrr.io/r/base/list.html), except that
unnamed elements are automatically named according to their symbol

## Usage

``` r
named(...)
```

## Arguments

- ...:

  List elements

## Value

Object of type `list` with names attribute set

## See also

[`list()`](https://rdrr.io/r/base/list.html)

## Examples

``` r
a <- 1:10
b <- "helloworld"
l1 <- list(a, b)
names(l1) <- c("a", "b")
l2 <- named(a, b)
stopifnot(identical(l1, l2))
l3 <- list(z = a, b = b)
l4 <- named(z = a, b)
stopifnot(identical(l3, l4))
```
