# Terminate a non-interactive R Session

Similar to python's
[sys.exit](https://docs.python.org/3/library/sys.html?highlight=exit#sys.exit).
If used interactively, code execution is stopped with an error message,
giving the provided status code. If used non-interactively (e.g. through
Rscript), code execution is stopped silently and the process exits with
the provided status code.

## Usage

``` r
sys.exit(status = 0)
```

## Arguments

- status:

  exitcode for R process

## Value

No return value, called for side effects

## Examples

``` r
if (FALSE) { # \dontrun{
if (!file.exists("some.file")) {
    cat("Error: some.file does not exist.\n", file = stderr())
    sys.exit(1)
} else if (Sys.getenv("IMPORTANT_ENV") == "") {
    cat("Error: IMPORTANT_ENV not set.\n", file = stderr())
    sys.exit(2)
} else {
    cat("Everything good. Starting calculations...")
    # ...
    cat("Finished with success!")
    sys.exit(0)
}
} # }
```
