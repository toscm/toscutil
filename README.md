<!-- badges: start -->
[![R CMD check](https://github.com/toscm/toscutil/workflows/R-CMD-check/badge.svg)](https://github.com/toscm/toscutil/actions)
[![Codecov test coverage](https://codecov.io/gh/toscm/toscutil/branch/master/graph/badge.svg)](https://app.codecov.io/gh/toscm/toscutil?branch=master)
[![CRAN Status Badge](https://www.r-pkg.org/badges/version/toscutil)](https://cran.r-project.org/package=toscutil)
[![CRAN Downloads Badge](https://cranlogs.r-pkg.org/badges/grand-total/toscutil)](https://cranlogs.r-pkg.org/badges/grand-total/toscutil)
<!-- badges: end -->

# toscutil

Useful functions for everyday programming.

# Installation

```R
# From CRAN (stable version)
install.packages("toscutil")
# From Github (development version)
devtools::install_github("toscm/toscutil")
```

## Usage

To use any function or data object, first [install](#installation) the package and then just enter any object's fully qualified name into a running R session, e.g. `toscutil::now_ms()`. You can find a curated list of existing functions at [toscm.github.io/toscutil/reference](https://toscm.github.io/toscutil/reference/index.html). Alternatively, you can load the package first, using command `library("toscutil")` and then access any symbol directly by its name, e.g. `now_ms()`.

<!-- BEGIN_FUNCTION_REFERENCE -->
<!-- END_FUNCTION_REFERENCE -->

## Contribute

For details on how to contribute to this package, please see [CONTRIBUTING.md](CONTRIBUTING.md).

