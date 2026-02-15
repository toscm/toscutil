# Stub Function Arguments

`stub()` assigns all arguments of a given function as symbols to the
specified environment (usually the current environment)

## Usage

``` r
stub(func, ..., envir = parent.frame())
```

## Arguments

- func:

  function for which the arguments should be stubbed

- ...:

  non-default arguments of `func`

- envir:

  environment to which symbols should be assigned

## Value

list of symbols that are assigned to `envir`

## Details

Stub is thought to be used for interactive testing and unit testing. It
does not work for primitive functions.

## Examples

``` r
f <- function(x, y = 2, z = 3) x + y + z
args <- stub(f, x = 1) # assigns x = 1, y = 2 and z = 3 to current env
```
