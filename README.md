<!-- badges: start -->
[![R build status](https://github.com/toscm/toscutil/workflows/R-CMD-check/badge.svg)](https://github.com/toscm/toscutil/actions)
<!-- badges: end -->

# toscutil

Useful functions for everyday programming by Tobias Schmidt (ToSc).

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
devtools::check() # Run `R CMD check` for this package
devtools::revdep() # Run `R CMD check` for all dependencies
devtools::release() # Builds, tests and submits the package to CRAN.
# Manual submission can be done at: https://cran.r-project.org/submit.html
```
