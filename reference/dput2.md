# Return ASCII representation of an R object

Like classic [`dput()`](https://rdrr.io/r/base/dput.html), but instead
of writing to stdout, the text representation is returned as string.

## Usage

``` r
dput2(..., collapse = " ", trim = TRUE)
```

## Arguments

- ...:

  Arguments passed on to [`dput()`](https://rdrr.io/r/base/dput.html).

- collapse:

  Character to use for collapsing the lines.

- trim:

  If `TRUE`, leading and trailing whitespace from each line is cleared
  before the lines are collapsed and/or returned.

## Value

If `collapse == '\n'`, a character vector of length 1. Else, a character
vector of length `n`, where `n` corresponds to the number of lines
outputted by classic [`dput()`](https://rdrr.io/r/base/dput.html).

## See also

[`dput()`](https://rdrr.io/r/base/dput.html)

## Examples

``` r
# Classic dput prints directly to stdout
x <- iris[1, ]
dput(x)
#> structure(list(Sepal.Length = 5.1, Sepal.Width = 3.5, Petal.Length = 1.4, 
#>     Petal.Width = 0.2, Species = structure(1L, levels = c("setosa", 
#>     "versicolor", "virginica"), class = "factor")), row.names = 1L, class = "data.frame")

# Traditional formatting using dput2
y <- dput2(x, collapse = "\n", trim = FALSE)
cat2(y)
#> structure(list(Sepal.Length = 5.1, Sepal.Width = 3.5, Petal.Length = 1.4, 
#>     Petal.Width = 0.2, Species = structure(1L, levels = c("setosa", 
#>     "versicolor", "virginica"), class = "factor")), row.names = 1L, class = "data.frame")

# Single line formatting
z <- dput2(x)
cat2(z)
#> structure(list(Sepal.Length = 5.1, Sepal.Width = 3.5, Petal.Length = 1.4, Petal.Width = 0.2, Species = structure(1L, levels = c("setosa", "versicolor", "virginica"), class = "factor")), row.names = 1L, class = "data.frame")
```
