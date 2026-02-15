# Capture output from a command

Like classic
[`capture.output()`](https://rdrr.io/r/utils/capture.output.html), but
with additional arguments `collapse` and `trim`.

## Usage

``` r
capture.output2(..., collapse = "\n", trim = FALSE)
```

## Arguments

- ...:

  Arguments passed on to
  [`capture.output()`](https://rdrr.io/r/utils/capture.output.html).

- collapse:

  If `TRUE`, lines are collapsed into a single string. If `FALSE`, lines
  are returned as is. If any character, lines are collapsed using that
  character.

- trim:

  If `TRUE`, leading and trailing whitespace from each line is removed
  before the lines are collapsed and/or returned.

## Value

If `collapse` is `TRUE` or `"\n"`, a character vector of length 1. Else,
a character vector of length `n`, where `n` corresponds to the number of
lines outputted by the expression passed to
[`capture.output()`](https://rdrr.io/r/utils/capture.output.html).

## See also

[`capture.output()`](https://rdrr.io/r/utils/capture.output.html)

## Examples

``` r
x <- capture.output2(str(list(a = 1, b = 2, c = 1:3)))
cat2(x)
#> List of 3
#>  $ a: num 1
#>  $ b: num 2
#>  $ c: int [1:3] 1 2 3
```
