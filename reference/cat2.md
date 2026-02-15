# Concatenate and Print

Same as [`base::cat()`](https://rdrr.io/r/base/cat.html) but with an
additional argument `end`, which gets printed after all other elements.
Inspired by pythons `print` command.

## Usage

``` r
cat2(
  ...,
  sep = " ",
  end = "\n",
  file = "",
  append = FALSE,
  fill = FALSE,
  labels = NULL
)
```

## Arguments

- ...:

  R objects (see 'Details' for the types of objects allowed).

- sep:

  a character vector of strings to append after each element.

- end:

  a string to print after all other elements.

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

## See also

[`base::cat()`](https://rdrr.io/r/base/cat.html)

## Examples

``` r
x <- 1
cat("x:", x, "\n") # prints 'Number: 1 \n' (with a space between 1 and \n)
#> x: 1 
cat2("x:", x) # prints 'Number: 1\n'  (without space)
#> x: 1
```
