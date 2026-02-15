# logf function

Prints a formatted string with optional prefix and end string. The
default prefix is a grey timestamp and the default end is a newline
character, which is useful for logging messages. All defaults can be set
globally using [`options()`](https://rdrr.io/r/base/options.html). For
details see 'Examples'.

## Usage

``` r
logf(
  fmt,
  ...,
  file = .Options$toscutil.logf.file %||% "",
  append = .Options$toscutil.logf.append %||% FALSE,
  prefix = .Options$toscutil.logf.prefix %||% function() now_ms(usetz = FALSE, color =
    fg$GREY),
  sep1 = .Options$toscutil.logf.sep1 %||% " ",
  sep2 = .Options$toscutil.logf.sep2 %||% "",
  end = .Options$toscutil.logf.end %||% "\n"
)
```

## Arguments

- ...:

  Arguments to be passed to sprintf for string formatting.

- file:

  A [`file()`](https://rdrr.io/r/base/connections.html) connection
  object or a string naming the file to print to. If `""` (the default),
  output is printed to STDOUT unless redirected by
  [`sink()`](https://rdrr.io/r/base/sink.html).

- append:

  Logical. If `TRUE`, the output is appended to the file. If `FALSE`,
  the file is overwritten.

- prefix:

  A function returning a string to be used as the prefix.

- sep1:

  A string to be used as the separator between the prefix and the
  formatted string.

- sep2:

  A string to be used as the separator between the formatted string and
  the end.

- end:

  A string to be used as the end of the message.

## Value

No return value. This function is called for its side effect of printing
a message.

## Examples

``` r
logf("Hello, %s!", "world")
#> 2026-02-15 11:57:49.03 Hello, world!
logf("Goodbye", prefix = function() "", sep1 = "", end = "!\n")
#> Goodbye!
local({
     opts <- options(toscutil.logf.prefix = function() "LOG:", toscutil.logf.end = "\n")
     on.exit(options(opts))
     logf("Hello, %s!", "world")
})
#> LOG: Hello, world!
```
