# Traces function calls from a package

Traces all function calls from a package and writes them to `file` with
timestamps and callstack depth. Should always be used in combination
with
[`untrace_package()`](https://toscm.github.io/toscutil/reference/untrace_package.md)
to untrace the package after use. For example
`trace_package("graphics"); on.exit(untrace_package("graphics")`. See
examples for more details.

## Usage

``` r
trace_package(
  pkg,
  file = stdout(),
  max = Inf,
  funign = character(),
  opsign = TRUE,
  dotign = TRUE,
  silent = TRUE,
  exitmsg = "exit"
)
```

## Arguments

- pkg:

  Package name to trace.

- file:

  File to write to.

- max:

  Maximum depth of callstack to print.

- funign:

  Functions to ignore.

- opsign:

  Whether to ignore operators.

- dotign:

  Whether to ignore functions starting with a dot.

- silent:

  Whether to suppress messages.

- exitmsg:

  Message to print on function exits.

## Value

No return value, called for side effects

## Details

Some function define their own
[`on.exit()`](https://rdrr.io/r/base/on.exit.html) handlers with option
`add = FALSE`. For those functions, exit tracing is impossible (as
described in [`trace()`](https://rdrr.io/r/base/trace.html)). For now
those functions have to be detected and ignored manually by the user
using argument `funign`.

## See also

[`untrace_package()`](https://toscm.github.io/toscutil/reference/untrace_package.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Trace all function from the graphics package, except for `plot.default`
# as it defines its own on.exit() handler, i.e. exit tracing is impossible.
local({
    trace_package("graphics", funign = "plot.default")
    on.exit(untrace_package("graphics"), add = TRUE)
    plot(1:10)
})
} # }
```
