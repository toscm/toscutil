# Concatenate and Print

Same as `cat` but with an additional argument `end`, which gets printed
after all other elements. Inspired by pythons `print` command.

Warning: this function is deprecated and should no longer be used. The
function is guaranteed to be available as part of the package until the
end of 2023 but might removed at any time after 31.12.2023.

## Usage

``` r
cat0(..., sep = "", end = "")
```

## Arguments

- ...:

  objects passed on to [cat](https://rdrr.io/r/base/cat.html)

- sep:

  a character vector of strings to append after each element

- end:

  a string to print after all other elements

## Value

No return value, called for side effects

## Examples

``` r
cat0("hello", "world") # prints "helloworld" (without newline)
#> Warning: This function is deprecated and should no longer be used. The function is guaranteed to be available as part of the package until 31.12.2023 but might be removed at any later timepoint.
#> helloworld
```
