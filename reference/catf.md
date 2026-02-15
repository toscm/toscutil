# Format and Print

Same as `cat(sprintf(fmt, ...))`

## Usage

``` r
catf(fmt, ..., file = "", append = FALSE, fill = FALSE, labels = NULL)
```

## Arguments

- fmt:

  A character vector of format strings, each of up to 8192 bytes.

- ...:

  Up to 100 values to be passed into `fmt`. Only logical, integer, real
  and character vectors are supported, but some coercion will be done:
  see the Details section of
  [`base::sprintf()`](https://rdrr.io/r/base/sprintf.html).

- file:

  A [connection](https://rdrr.io/r/base/connections.html), or a
  character string naming the file to print to. If `""` (the default),
  `cat2` prints to the standard output connection, the console unless
  redirected by [sink](https://rdrr.io/r/base/sink.html).

- append:

  logical. Only used if the argument `file` is the name of file (and not
  a connection or `"|cmd"`). If `TRUE` output will be appended to
  `file`; otherwise, it will overwrite the contents of `file`.

- fill:

  a logical or (positive) numeric controlling how the output is broken
  into successive lines. If `FALSE` (default), only newlines created
  explicitly by `"\n"` are printed. Otherwise, the output is broken into
  lines with print width equal to the option `width` if `fill` is
  `TRUE`, or the value of `fill` if this is numeric. Linefeeds are only
  inserted *between* elements, strings wider than `fill` are not
  wrapped. Non-positive `fill` values are ignored, with a warning.

- labels:

  character vector of labels for the lines printed. Ignored if `fill` is
  `FALSE`.

## Value

No return value, called for side effects

## Examples

``` r
catf("A%dB%sC", 2, "asdf") # prints "A2BasdfC"
#> A2BasdfC
```
