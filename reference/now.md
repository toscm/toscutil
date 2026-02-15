# Get Current Date and Time as String

Returns the current system time as a string in the format
`YYYY-MM-DD hh:mm:ss[.XX][ TZ]`. Square brackets indicate optional parts
of the string, 'XX' stands for milliseconds and 'TZ' for 'Timezone'.

## Usage

``` r
now(usetz = TRUE, color = NULL, digits.sec = 0)

now_ms(usetz = TRUE, color = NULL, digits.sec = 2)
```

## Arguments

- usetz:

  Logical, indicating whether to include the timezone in the output.

- color:

  Optional color to use for the timestamp. This parameter is only
  effective if the output is directed to a terminal that supports color,
  which is checked via `isatty(stdout())`.

- digits.sec:

  Integer, the number of digits to include for seconds. Default is 0.

## Value

For `now`, the current system time as a string in the format
`YYYY-MM-DD hh:mm:ss TZ`. For `now_ms`, the format is
`YYYY-MM-DD hh:mm:ss.XX TZ`, where XX represents milliseconds.

## See also

[`Sys.time()`](https://rdrr.io/r/base/Sys.time.html),
[`format.POSIXct()`](https://rdrr.io/r/base/strptime.html)

## Examples

``` r
now()                   # "2021-11-27 19:19:31 CEST"
#> [1] "2026-02-15 10:10:56 UTC"
now_ms()                # "2022-06-30 07:14:26.82 CEST"
#> [1] "2026-02-15 10:10:56.52 UTC"
now(usetz = FALSE)      # "2022-06-30 07:14:26.82"
#> [1] "2026-02-15 10:10:56 UTC"
now(color = fg$GREY)    # "\033[1;30m2024-06-27 14:41:20 CEST\033[0m"
#> [1] "2026-02-15 10:10:56 UTC"
```
