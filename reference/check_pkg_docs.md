# Check Documented Functions in a Package

Lists all documented functions in a package and checks their
documentation elements for potential issues. The following checks are
performed:

1.  Title is present and doesn't start with regex "Function".

2.  Description is present and doesn't start with "This function".

3.  Value is present.

4.  Example is present.

## Usage

``` r
check_pkg_docs(pkg = NULL, unload = TRUE, reload = TRUE)
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
package. Each cell contains a string describing the check result for the
corresponding documentation element of that function.

## Examples

``` r
df <- check_pkg_docs("tools")
try(df <- check_pkg_docs())
```
