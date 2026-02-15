# Split a docstring into a Head, Param and Tail Part

Split a docstring into a head, param and tail part.

## Usage

``` r
split_docstring(docstring)
```

## Arguments

- docstring:

  Docstring of a R function as string, i.e. as character vector of
  length 1.

## Value

List with 3 elements: head, param and tail.

## Examples

``` r
uri <- system.file("testfiles/funcs.R", package = "toscutil")
func <- "f4"
content <- readLines(uri)
docstring <- get_docstring(content, func)
split_docstring(docstring)
#> $head
#>                                                                                           header 
#>                                                                                               "" 
#>                                                                                            title 
#>                                               "#' @title TODO (e.g. 'Sum of Vector Elements')\n" 
#>                                                                                      description 
#> "#' @description TODO (e.g. 'sum returns the sum of all the values present in its arguments.'\n" 
#> 
#> $param
#> named character(0)
#> 
#> $tail
#> named character(0)
#> 
```
