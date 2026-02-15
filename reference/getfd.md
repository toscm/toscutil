# Get File Directory

Return full path to current file directory

## Usage

``` r
getfd(
  on.error = stop("No file sourced. Maybe you're in an interactive shell?", call. =
    FALSE),
  winslash = "/"
)
```

## Arguments

- on.error:

  Expression to use if the current file directory cannot be determined.
  In that case, `normalizePath(on.error, winslash)` is returned. Can
  also be an expression like `stop("message")` to stop execution
  (default).

- winslash:

  Path separator to use for windows

## Value

Current file directory as string

## Examples

``` r
getfd(on.error = getwd())
#> [1] "/home/runner/work/_temp"
if (FALSE) { # \dontrun{
getfd()
} # }
```
