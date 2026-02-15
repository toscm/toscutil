# Predict Method for Numeric Vectors

Interprets the provided numeric vector as linear model and uses it to
generate predictions. If an element of the numeric vector has the name
`"Intercept"` this element is treated as the intercept of the linear
model.

## Usage

``` r
# S3 method for class 'numeric'
predict(object, newdata, ...)
```

## Arguments

- object:

  Named numeric vector of beta values. If an element is named
  "Intercept", that element is interpreted as model intercept.

- newdata:

  Matrix with samples as rows and features as columns.

- ...:

  further arguments passed to or from other methods

## Value

Named numeric vector of predicted scores

## Examples

``` r
X <- matrix(1:4, 2, 2, dimnames = list(c("s1", "s2"), c("a", "b")))
b <- c(Intercept = 3, a = 2, b = 1)
predict(b, X)
#> s1 s2 
#>  8 11 
```
