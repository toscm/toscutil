# Format and Print

Same as `cat2(sprintf(fmt, ...))`

Warning: this function is deprecated and should no longer be used. The
function is guaranteed to be available as part of the package until the
end of 2023 but might removed at any time after 31.12.2023.

## Usage

``` r
catfn(
  fmt,
  ...,
  end = "\n",
  file = "",
  sep = " ",
  fill = FALSE,
  labels = NULL,
  append = FALSE
)
```

## Arguments

- fmt:

  passed on to [`base::sprintf()`](https://rdrr.io/r/base/sprintf.html)

- ...:

  passed on to [`base::sprintf()`](https://rdrr.io/r/base/sprintf.html)

- end:

  passed on to
  [`cat2()`](https://toscm.github.io/toscutil/reference/cat2.md)

- file:

  passed on to
  [`cat2()`](https://toscm.github.io/toscutil/reference/cat2.md) (which
  passes it on to [`base::cat()`](https://rdrr.io/r/base/cat.html))

- sep:

  passed on to
  [`cat2()`](https://toscm.github.io/toscutil/reference/cat2.md) (which
  passes it on to [`base::cat()`](https://rdrr.io/r/base/cat.html))

- fill:

  passed on to
  [`cat2()`](https://toscm.github.io/toscutil/reference/cat2.md) (which
  passes it on to [`base::cat()`](https://rdrr.io/r/base/cat.html))

- labels:

  passed on to
  [`cat2()`](https://toscm.github.io/toscutil/reference/cat2.md) (which
  passes it on to [`base::cat()`](https://rdrr.io/r/base/cat.html))

- append:

  passed on to
  [`cat2()`](https://toscm.github.io/toscutil/reference/cat2.md) (which
  passes it on to [`base::cat()`](https://rdrr.io/r/base/cat.html))

## Value

No return value, called for side effects

## Examples

``` r
catfn("A%dB%sC", 2, "asdf") # prints "A2BasdfC\n"
#> Warning: This function is deprecated and should no longer be used. The function is guaranteed to be available as part of the package until 31.12.2023 but might be removed at any later timepoint.
#> A2BasdfC
```
