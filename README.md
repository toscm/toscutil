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
## Function Reference

- Extended versions of base R functions
    - `capture.output2()`: Capture output from a command
    - `cat2()`: Concatenate and Print
    - `catf()`: Format and Print
    - `dput2()`: Return ASCII representation of an R object
    - `fg()`: Foreground Color Codes
    - `help2()`: Return help for topic
    - `named()`: Create automatically named List
    - `norm_path()`: Return Normalized Path

- Function for condition checking
    - `ifthen()`: Shortcut for multiple if else statements
    - `is.none()`: Truth checking as in Python

- Functions for writing functions
    - `caller()`: Get Name of Calling Function
    - `function_locals()`: Get Function Environment as List
    - `locals()`: Get specified Environment as List
    - `sys.exit()`: Terminate a non-interactive R Session

- Functions for reading, checking and writing documentation
    - `check_pkg_docs()`: Check Documented Functions in a Package
    - `DOCSTRING_TEMPLATE()`: Docstring Template
    - `find_description_file()`: Find DESCRIPTION File
    - `get_docstring()`: Get docstring for a Function
    - `get_formals()`: Get formals of a Function
    - `get_pkg_docs()`: Get Documented Functions in a Package
    - `read_description_file()`: Read DESCRIPTION File into a List
    - `split_docstring()`: Split a docstring into a Head, Param and Tail Part
    - `update_docstring()`: Update docstring for a Function
    - `update_reference_in_readme()`: Update Function Reference in README

- Functions for experimenting in interactive (live) R sessions
    - `corn()`: Return Corners of Matrix like Objects
    - `rm_all()`: Remove all objects from global environment
    - `stub()`: Stub Function Arguments
    - `trace_package()`: Traces function calls from a package
    - `untrace_package()`: Untraces function calls from a package

- Functions returning important paths
    - `config_dir()`: Get Normalized Configuration Directory Path of a Program
    - `config_file()`: Get Normalized Configuration File Path of a Program
    - `data_dir()`: Get Normalized Data Directory Path of a Program
    - `getfd()`: Get File Directory
    - `getpd()`: Get Project Directory
    - `home()`: Get USERPROFILE or HOME
    - `xdg_config_home()`: Get XDG_CONFIG_HOME
    - `xdg_data_home()`: Get XDG_DATA_HOME

- S3 methods
    - `predict.numeric()`: Predict Method for Numeric Vectors

- Function returning datetime
    - `now()`: Get Current Date and Time as String

<!-- END_FUNCTION_REFERENCE -->

## Contribute

For details on how to contribute to this package, please see [CONTRIBUTING.md](CONTRIBUTING.md).

