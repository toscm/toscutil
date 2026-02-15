# Read DESCRIPTION File into a List

Reads the DESCRIPTION file of an R package and converts it into a list
where each element corresponds to a field in the DESCRIPTION file.

## Usage

``` r
read_description_file(p = NULL)
```

## Arguments

- p:

  The path to the DESCRIPTION file. If `NULL`, the function attempts to
  find the DESCRIPTION file by searching upwards from the current
  directory.

## Value

A list where each element is a field from the DESCRIPTION file.

## Examples

``` r
# Read DECRIPTION file from a specific path
graphics_pkg_dir <- system.file(package = "graphics")
graphics_pkg_descfile <- find_description_file(graphics_pkg_dir)
desc_list <- read_description_file(graphics_pkg_descfile)
str(desc_list)
#> List of 13
#>  $ Package         : chr "graphics"
#>  $ Version         : chr "4.5.2"
#>  $ Priority        : chr "base"
#>  $ Title           : chr "The R Graphics Package"
#>  $ Author          : chr "R Core Team and contributors worldwide"
#>  $ Maintainer      : chr "R Core Team <do-use-Contact-address@r-project.org>"
#>  $ Contact         : chr "R-help mailing list <r-help@r-project.org>"
#>  $ Description     : chr "R functions for base graphics."
#>  $ Imports         : chr "grDevices"
#>  $ License         : chr "Part of R 4.5.2"
#>  $ NeedsCompilation: chr "yes"
#>  $ Enhances        : chr "vcd"
#>  $ Built           : chr "R 4.5.2; x86_64-pc-linux-gnu; 2025-10-31 10:19:25 UTC; unix"

if (FALSE) { # \dontrun{
# Below example will only work if executed from a package directory
read_description_file()
} # }
```
