# Return Normalized Path

Shortcut for
`normalizePath(file.path(...), winslash = sep, mustWork = FALSE)`

## Usage

``` r
norm_path(..., sep = "/")
```

## Arguments

- ...:

  Parts used to construct the path

- sep:

  Path separator to be used on Windows

## Value

Normalized path constructed from ...

## Examples

``` r
norm_path("C:/Users/max", "a\\b", "c") # returns C:/Users/max/a/b/c
#> [1] "C:/Users/max/a\\b/c"
norm_path("a\\b", "c") # return <current-working-dir>/a/b/c
#> [1] "a\\b/c"
```
