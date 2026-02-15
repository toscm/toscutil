# Find DESCRIPTION File

Searches for a DESCRIPTION file starting from the current or specified
directory and moving upwards through the directory hierarchy until the
file is found or the root directory is reached.

## Usage

``` r
find_description_file(start_dir = getwd())
```

## Arguments

- start_dir:

  The starting directory for the search. Defaults to the current working
  directory.

## Value

The path to the DESCRIPTION file if found. If not found, the function
stops with an error message.

## Examples

``` r
# Start search from a specific directory
graphics_pkg_dir <- system.file(package = "graphics")
find_description_file(graphics_pkg_dir)
#> [1] "/opt/R/4.5.2/lib/R/library/graphics/DESCRIPTION"

if (FALSE) { # \dontrun{
# Below example will only work if executed from a package directory
find_description_file()
} # }
```
