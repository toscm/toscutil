<!-- badges: start -->
[![R CMD check](https://github.com/toscm/toscutil/workflows/R-CMD-check/badge.svg)](https://github.com/toscm/toscutil/actions)
[![Codecov test coverage](https://codecov.io/gh/toscm/toscutil/branch/master/graph/badge.svg)](https://app.codecov.io/gh/toscm/toscutil?branch=master)
[![CRAN Status Badge](https://www.r-pkg.org/badges/version/toscutil)](https://cran.r-project.org/package=toscutil)
[![CRAN Downloads Badge](https://cranlogs.r-pkg.org/badges/grand-total/toscutil)](https://cranlogs.r-pkg.org/badges/grand-total/toscutil)
<!-- badges: end -->

# toscutil

Useful functions for everyday programming.

## Table of Contents <!-- omit in toc -->

- [Installation](#installation)
- [Usage](#usage)
- [Contribute](#contribute)

## Installation

```R
# From CRAN (stable version)
install.packages("toscutil")
# From Github (development version)
devtools::install_github("toscm/toscutil")
```

## Usage

To use any function or data object, first [install](#installation) the package and then just enter any object's fully qualified name into a running R session, e.g. `toscutil::now_ms()`. You can find a curated list of existing functions at <toscm.github.io/toscutil/>. Alternatively, you can load the package first, using command `library("toscutil")` and then access any symbol directly by its name, e.g. `now_ms()`.

## Contribute

Things you can update, are:

1. Function code in folder [R](R)
2. Function documentation in folder [R](R)
3. Package documentation in folder [vignettes]
4. Test cases in folder [tests](tests)
5. Dependencies in file [DESCRIPTION](DESCRIPTION)
6. Authors in file [DESCRIPTION](DESCRIPTION)

Whenever you update any of those things, you should run the below commands to check that everything is still working  as expected

```R
devtools::test() # Execute tests from tests folder
devtools::check() # Check package formalities
devtools::document() # Build files in man folder
devtools::install() # Install as required by next command
pkgdown::build_site() # Build website in docs folder
```

After doing these steps, you can push your changes to Github and then use the following commands to release the package to CRAN:

```R
rcmdcheck::rcmdcheck() # Slower, but more realistic test than devtools::check()
devtools::spell_check() # Check spelling. Add false positives to inst/WORDLIST
devtools::release() # Submits the package to CRAN
revdepcheck::revdep_check(num_workers = 8) # Reverse dependency check
# See https://r-pkgs.org/release.html#sec-release-revdep-checks for details
devtools::submit_cran()
```

Above steps are based on: <https://r-pkgs.org/release.html>
