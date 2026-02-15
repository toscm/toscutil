# Get Project Directory

Find the project root directory by traversing the current working
directory filepath upwards until a given set of files is found.

## Usage

``` r
getpd(root.files = c(".git", "DESCRIPTION", "NAMESPACE"))
```

## Arguments

- root.files:

  if any of these files is found in a parent folder, the path to that
  folder is returned

## Value

`getpd` returns the absolute, normalized project root directory as
string. The forward slash is used as path separator (independent of the
OS).

## Examples

``` r
local({
     base_pkg_root_dir <- system.file(package = "base")
     base_pkg_R_dir <- file.path(base_pkg_root_dir, "R")
     owd <- setwd(base_pkg_R_dir); on.exit(setwd(owd))
     getpd()
})
#> [1] "/opt/R/4.5.2/lib/R/library/base"
```
