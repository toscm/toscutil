<!-- badges: start -->
[![R CMD check](https://github.com/toscm/toscutil/workflows/R-CMD-check/badge.svg)](https://github.com/toscm/toscutil/actions)
[![Codecov test coverage](https://codecov.io/gh/toscm/toscutil/branch/main/graph/badge.svg)](https://app.codecov.io/gh/toscm/toscutil?branch=main)
[![CRAN Status Badge](https://www.r-pkg.org/badges/version/toscutil)](https://cran.r-project.org/package=toscutil)
<!-- badges: end -->

# toscutil

Useful functions for everyday programming.

## Installation

```R
# From CRAN (stable version)
install.packages("toscutil")
# From Github (development version)
devtools::install_github("toscm/toscutil")
```

## Developer Notes

### How to submit to CRAN?

According to <https://r-pkgs.org/release.html> the following steps are necessary

```R
devtools::document() # Update documentation
rcmdcheck::rcmdcheck( # Run `R CMD check` for this package
    args=c("--no-manual", "--as-cran"),
    build_args=c("--no-manual"),
    check_dir="check"
)
devtools::revdep() # Run `R CMD check` for all dependencies
devtools::spell_check() # Check spelling of package
devtools::release() # Builds, tests and submits the package to CRAN.
# Manual submission can be done at: https://cran.r-project.org/submit.html
```
