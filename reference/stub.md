# Stub Function Arguments

`stub()` assigns all arguments of a given function as symbols to the
specified environment (usually the current environment). For arguments
without default values, `stub()` will attempt to retrieve their values
from `.GlobalEnv` if they exist there.

## Usage

``` r
stub(func, ..., envir = parent.frame())
```

## Arguments

- func:

  function, function name, or function call expression (e.g.
  `f(a=1, b=2)`) for which the arguments should be stubbed. When a
  function call expression is provided, the function and its arguments
  are extracted from the call.

- ...:

  non-default arguments of `func`. Positional (unnamed) arguments are
  matched to the first unmatched formal arguments of `func`, similar to
  how R itself matches positional arguments.

- envir:

  environment to which symbols should be assigned

## Value

list of symbols that are assigned to `envir`

## Details

Stub is thought to be used for interactive testing and unit testing. It
does not work for primitive functions.

When a function has required arguments without defaults, `stub()` will
first check if those arguments exist in `.GlobalEnv` and use their
values if found. This enables a common dev workflow: (1) Run example
code that sets variables, (2) Call `stub(func)`, (3) Modify and execute
parts of the function body.

`stub()` can also accept a function call expression as its first
argument, e.g. `stub(f(a=1, b=2))`. In this case, the function and its
arguments are extracted from the call, equivalent to
`stub(f, a=1, b=2)`.

Positional (unnamed) arguments are matched to the first unmatched formal
arguments of the function (those not already covered by named
arguments), equivalent to how R itself matches arguments.

## Examples

``` r
f <- function(x, y = 2, z = 3) x + y + z
args <- stub(f, x = 1) # assigns x = 1, y = 2 and z = 3 to current env
#> Created 3 variables in anonymous environment:
#>  $ x: num 1
#>  $ y: num 2
#>  $ z: num 3

# Using positional arguments:
args <- stub(f, 1) # same as stub(f, x = 1)
#> Created 3 variables in anonymous environment:
#>  $ x: num 1
#>  $ y: num 2
#>  $ z: num 3

# Using a function call expression:
args <- stub(f(1, y = 2)) # same as stub(f, x = 1, y = 2)
#> Created 3 variables in anonymous environment:
#>  $ x: num 1
#>  $ y: num 2
#>  $ z: num 3

# stub() can also use values from GlobalEnv for missing args:
g <- function(a, b = 10) a + b
a <- 5 # Set in GlobalEnv
stub(g) # Uses a = 5 from GlobalEnv, assigns a = 5 and b = 10
#> Error in stub(g): argument 'a' is missing, with no default and not found in .GlobalEnv
```
