# Changelog

## toscutil v2.9.3

- `Added`: testthat parallel config (multicore) via DESCRIPTION.

## toscutil v2.9.2

- `Changed`:
  [`stub()`](https://toscm.github.io/toscutil/reference/stub.md) now
  returns invisibly, stubs `...` as `NULL` when present and prints a
  compact summary of the stubbed arguments. Output can be silenced via
  `options(toscutil.stub.silent = TRUE)`.

## toscutil v2.9.1

- `Fixed`:
  [`logf()`](https://toscm.github.io/toscutil/reference/logf.md) now
  correctly uses the `file` and `append` arguments when writing output.

## toscutil v2.9.0

- `Added`:
  [`stub()`](https://toscm.github.io/toscutil/reference/stub.md) now
  automatically looks up missing arguments (those without defaults) in
  `.GlobalEnv` if they exist there. This enables a common interactive
  development workflow: run example code that sets variables, call
  `stub(func)`, then work with the function body interactively. Explicit
  arguments still take precedence over GlobalEnv values.

## toscutil v2.8.1

- `Fixed`: unloading of `devtools` in
  [`get_pkg_docs()`](https://toscm.github.io/toscutil/reference/get_pkg_docs.md)
  (which caused
  [`check_pkg_docs()`](https://toscm.github.io/toscutil/reference/check_pkg_docs.md)
  to fail if
  [`devtools::load_all()`](https://devtools.r-lib.org/reference/load_all.html)
  had been called before in the current session).

## toscutil v2.8.0

CRAN release: 2024-06-28

- `Added`: added functions
  [`check_pkg_docs()`](https://toscm.github.io/toscutil/reference/check_pkg_docs.md),
  [`find_description_file()`](https://toscm.github.io/toscutil/reference/find_description_file.md),
  [`get_pkg_docs()`](https://toscm.github.io/toscutil/reference/get_pkg_docs.md),
  [`logf()`](https://toscm.github.io/toscutil/reference/logf.md),
  [`read_description_file()`](https://toscm.github.io/toscutil/reference/read_description_file.md),
  [`trace_package()`](https://toscm.github.io/toscutil/reference/trace_package.md),
  [`untrace_package()`](https://toscm.github.io/toscutil/reference/untrace_package.md)
- `Added`: added list `fg` (foreground colors)
- `Added`: arguments `color` and `digits.sec` to functions
  [`now()`](https://toscm.github.io/toscutil/reference/now.md) and
  [`now_ms()`](https://toscm.github.io/toscutil/reference/now.md). Also
  merged their documentation and implementation
  ([`now_ms()`](https://toscm.github.io/toscutil/reference/now.md) calls
  [`now()`](https://toscm.github.io/toscutil/reference/now.md)
  internally).
- `Refactor`: `languageserver` is now an optional dependency instead of
  a required one. This makes the package more lightweight and easier to
  install.
- `Refactor`: `catf` and `cat2` are implemented more efficiently now. In
  particular, both use only one call to `cat`, which makes them better
  usable in parallel executed code.
- `Refactor`: `help2` now also works for functions loaded via
  `devtools`.
- `Fixed`: function
  [`named()`](https://toscm.github.io/toscutil/reference/named.md)
- `Fixed`: a bug in function
  [`stub()`](https://toscm.github.io/toscutil/reference/stub.md), which
  caused the function to fail, when later arguments used the value of
  previous argument as inputs.

## toscutil v2.7.4

CRAN release: 2023-09-05

- `Fixed`: Fixed a bug in `cat2` introduced in [v2.7.3](#toscutil-v273)
  that caused additional newlines to be added between each line of
  output.

## toscutil v2.7.3

CRAN release: 2023-08-28

- `Fixed`: when using `cat2` to print to files the `end` part kept
  getting printed to the console. This behavior is fixed now and `end`
  also goes to the file.

## toscutil v2.7.2

- `Fixed`: Added `NEWS.md` to
  [.Rbuildignore](https://toscm.github.io/toscutil/news/.Rbuildignore)

## toscutil v2.7.1

- `Fixed`: Fixed
  [`split_docstring()`](https://toscm.github.io/toscutil/reference/split_docstring.md).
  Docstrings ending with a keyword, e.g. `@export` are now returned
  correctly without additional whitespace.

## toscutil v2.7.0

- `Added`: Added [pkgdown](https://pkgdown.r-lib.org/index.html) website
- `Added`: Added functions
  [`capture.output2()`](https://toscm.github.io/toscutil/reference/capture.output2.md),
  [`dput2()`](https://toscm.github.io/toscutil/reference/dput2.md),
  [`get_docstring()`](https://toscm.github.io/toscutil/reference/get_docstring.md),
  [`get_formals()`](https://toscm.github.io/toscutil/reference/get_formals.md),
  [`update_docstring()`](https://toscm.github.io/toscutil/reference/update_docstring.md)
- `Added`: Added constant `DOCSTRING_TEMPLATE`
- `Changed`: Improved documentation for almost every function
- `Removed`: Removed function reference from
  [README.md](https://toscm.github.io/toscutil/news/README.md)
- `Deprecated`: Functions
  [`cat0()`](https://toscm.github.io/toscutil/reference/cat0.md),
  [`catn()`](https://toscm.github.io/toscutil/reference/catn.md),
  [`cat0n()`](https://toscm.github.io/toscutil/reference/cat0n.md),
  [`catsn()`](https://toscm.github.io/toscutil/reference/catsn.md),
  [`catnn()`](https://toscm.github.io/toscutil/reference/catnn.md),
  [`catfn()`](https://toscm.github.io/toscutil/reference/catfn.md)

## toscutil v2.6.0

- `Added`: Added function `help2`
- `Infrastructure`: Added function reference to
  [README.md](https://toscm.github.io/toscutil/news/README.md)

## toscutil v2.5.1

- `Fixed`: Function `is.none` now also handles atomic vectors of length
  0, e.g. [`character()`](https://rdrr.io/r/base/character.html),
  [`numeric()`](https://rdrr.io/r/base/numeric.html) and
  [`logical()`](https://rdrr.io/r/base/logical.html)

## toscutil v2.5.0

CRAN release: 2022-06-30

- `Added`: Added functions `caller`, `function_locals`, `locals`,
  `now_ms` and `stub`
- `Changed`: Changed default values for function `cat2`
- `Changed`: Changed return value for function `now`. Timezone is not
  returned as well, i.e. instead of `"2022-12-24 11:13:57"` something
  like `"2022-12-24 11:13:57 CEST"` is returned.
- `Changed`: Added dependencies to core packages `"methods"` and
  `"utils"` and to 3rd party package `"rlang"`.
- `Changed`: Changed package Title from “Utility Functions by Tobias
  Schmidt (ToSc)” to “Utility Functions”
- `Fixed`: Made function `predict.numeric` more robust (check for
  classes “matrix” and “array” is now done using function `inherits`).
- `Deprecated`: Deprecated functions `cat0`, `catn`, `cat0n`, `catsn`
  and `catnn`

## toscutil v2.4.0

- `Added`: Added functions `config_dir`, `data_dir`, `norm_path`,
  `config_file`, `xdg_data_home`, `xdg_config_home`,

## toscutil v2.3.0

- `Added`: Added functions `catsn`, `catnn`, `catf` and `catfn`

## toscutil v2.2.0

- `Added`: Added function `home`

## toscutil v2.1.0

CRAN release: 2022-02-22

- `Infrastructure`: Added more details about package functionality and
  implemented methods in field Description of file DESCRIPTION
- `Fixed`: Replaced `F` with `FALSE` in `getfd.{R|Rd}`
- `Fixed`: Updated function documentation. Every function now contains
  at least the following roxygen tags: `name`, `title`, `description`,
  `return`, i.e., the corresponding `*.Rd`-files contain at least the
  following tags `\name`, `\title` , `\value`, `\description`.
- `Added`: Argument `end` to `cat` variants

## toscutil v2.0.3

- `Infrastructure`: Added files generated by CRAN submission

## toscutil v2.0.2

`Fixed`: Improved `.Rbuildignore`

## toscutil v2.0.1

- `Fixed`: Removed `man` folder from .gitignore
- `Fixed`: Changed License entry in `DESCRIPTION` to *MIT + file
  LICENSE* to prevent R CMD check note
- `Fixed`: Made repo public to prevent invalid URL note in R CMD check
- `Fixed`: Converted title in `DESCRIPTION` to *title case* to prevent R
  CMD check note

## toscutil v2.0.0

- `Removed`: `cache` function, because of downstream dependencies which
  caused problems with R CMD check
- `Fixed`: Documentation of `cat0`, `catn`, `cat0n`
- `Fixed`: Documentation of `ifthen`
- `Fixed`: Documentation of `rm_all`
- `Changed`: `predict.numeric` to use `paste` instead of
  [`glue::glue`](https://glue.tidyverse.org/reference/glue.html) to
  remove the dependency on package `glue`

## toscutil v1.4.1

- `Fixed`: filename of ./R/named.R (file extensions was missing)
- `Infrastructure`: migrated from gitlab to github
- `Infrastructure`: added github action for R CMD check.

## toscutil v1.4.0

- `Added`: function `sys.exit(status)`

## toscutil v1.3.0

- `Fixed`: function `getfd`. `getfd` now returns the correct file
  directory also for scripts started through `Rscript`
- `Added`: optional parameter `on.error` to `getfd`
- `Added`: optional parameter `winslash` to `getfd`

## toscutil v1.2.0

- `Added`: `cat0`, `catn` and `cat0n` functions

## toscutil v1.1.0

- `Added`: `%none%` function (previously called `%d%`)

## toscutil v1.0.0

- `Removed`: `+` function (`x` is now part of the `toscmask` package)
- `Removed`: `%d%` function

## toscutil v0.0.0.9006

- `Removed`: `where` function (instead `envnames::find_obj` can be used)

## toscutil v0.0.0.9005

- `Added`: `named` function

## toscutil v0.0.0.9004

- `Added`: `now` function

## toscutil v0.0.0.9003

- `Changed`: `getfd` now throws an error if no sourced file can be found
- `Changed`: `getprd` renamed to `getpd`
- `Changed`: `getpd` now takes an argument of files used to decide which
  folder is the project root (default:
  `c(".git", "DESCRIPTION", "NAMESPACE")`)

## toscutil v0.0.0.9002

- `Added`: `where` command
- `Added`: this changelog
- `Added`: `+` operator
