# Get USERPROFILE or HOME

Returns normalized value of environment variable USERPROFILE, if
defined, else value of HOME.

## Usage

``` r
home(winslash = "/")
```

## Arguments

- winslash:

  path separator to be used on Windows (passed on to `normalizePath`)

## Value

normalized value of environment variable USERPROFILE, if defined, else
value of HOME.

## Examples

``` r
home()
#> [1] "/home/runner"
```
