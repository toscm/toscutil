# Update Function Reference in README

Updates the function reference section in README.md by categorizing all
exported functions according to the categories defined in \_pkgdown.yml.
The function reference is placed between HTML comments
`<!-- BEGIN_FUNCTION_REFERENCE -->` and
`<!-- END_FUNCTION_REFERENCE -->`. This is an internal maintenance
helper specific to this package's repository and is not part of the
public API.

## Usage

``` r
update_reference_in_readme(
  readme_path = "README.md",
  pkgdown_path = "_pkgdown.yml",
  pkg = NULL,
  unload = TRUE,
  reload = TRUE
)
```

## Arguments

- readme_path:

  Path to the README.md file. Defaults to "README.md" in the current
  directory.

- pkgdown_path:

  Path to the \_pkgdown.yml file. Defaults to "\_pkgdown.yml" in the
  current directory.

- pkg:

  The package name. If NULL, the package name is inferred from the
  DESCRIPTION file.

- unload:

  Whether to try to unload a potential currently developed package using
  [`devtools::unload()`](https://pkgload.r-lib.org/reference/unload.html)
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

Invisibly returns TRUE if the update was successful.

## Examples

``` r
if (FALSE) { # \dontrun{
# Update function reference in README.md
toscutil:::update_reference_in_readme()
} # }
```
