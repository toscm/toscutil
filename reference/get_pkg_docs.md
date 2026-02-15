# Get Documented Functions in a Package

Lists all documented functions in a package together with some of their
documentation elements as raw text. Only works for installed packages.

## Usage

``` r
get_pkg_docs(pkg = NULL, unload = TRUE, reload = TRUE)
```

## Arguments

- pkg:

  The package name. If NULL, the package name is inferred from the
  DESCRIPTION file in the current directory or any parent directory. If
  no DESCRIPTION file is found, the function stops with an error
  message.

- unload:

  Whether to try to unload a potential currently developed package using
  [`devtools::unload()`](https://devtools.r-lib.org/reference/reexports.html)
  before checking the documentation. Required when the package was
  loaded with
  [`devtools::load_all()`](https://devtools.r-lib.org/reference/load_all.html)
  as the documentation database only exists for installed packages. If
  the unloading fails, the function silently continues, as the unloading
  is only necessary for checking the documentation of currently
  developed packages.

- reload:

  Whether to reload the package using
  [`devtools::load_all()`](https://devtools.r-lib.org/reference/load_all.html)
  after checking the documentation.

## Value

Returns a dataframe with columns `title`, `description`, `value`,
`examples` and rows corresponding to the documented functions in the
package.

## Examples

``` r
df <- get_pkg_docs("tools")
nchars <- as.data.frame(apply(df, 2, function(col) sapply(col, nchar)))
head(nchars)
#>                class title description value format examples
#> HTMLheader         8    42          71   114      0       53
#> R                  8    35          68   692      0      398
#> Rcmd               8    15          33    30      0        0
#> Rd2HTML            8    15         181   644      0      321
#> Rd2txt_options     8    36          61   154      0      205
#> RdTextFilter       8    25          87   128      0        0
try(df <- check_pkg_docs())
```
