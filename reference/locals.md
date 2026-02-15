# Get specified Environment as List

Return all symbols in the specified environment as list.

## Usage

``` r
locals(without = c(), env = parent.frame())
```

## Arguments

- without:

  Character vector. Symbols from current env to exclude.

- env:

  Environment to use. Defaults to the environment from which `locals` is
  called.

## Value

Specified environment as list (without the mentioned symbols).

## Examples

``` r
f <- function() {
     x <- 1
     y <- 2
     z <- 3
     locals()
}
ret <- f()
stopifnot(identical(ret, list(z = 3, y = 2, x = 1)))
```
