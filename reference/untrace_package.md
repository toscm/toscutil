# Untraces function calls from a package

Removes tracing from all function calls in a package that were
previously traced by
[`trace_package()`](https://toscm.github.io/toscutil/reference/trace_package.md).

## Usage

``` r
untrace_package(pkg)
```

## Arguments

- pkg:

  Package name to untrace.

## Value

No return value, called for side effects

## Details

This function reverses the effects of `trace_package` by removing all
tracing from the specified package's functions.

## See also

[`trace_package()`](https://toscm.github.io/toscutil/reference/trace_package.md)

## Examples

``` r
if (FALSE) { # \dontrun{
local({
    trace_package("graphics", funign = "plot.default")
    on.exit(untrace_package("graphics"), add = TRUE)
    plot(1:10)
})
} # }
```
