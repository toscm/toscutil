# Get XDG_DATA_HOME

Return value for XDG_DATA_HOME as defined by the [XDG Base Directory
Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

## Usage

``` r
xdg_data_home(sep = "/", fallback = normalizePath(getwd(), winslash = sep))
```

## Arguments

- sep:

  Path separator to be used on Windows

- fallback:

  Value to return as fallback (see details)

## Value

The following algorithm is used to determine the returned path:

1.  If environment variable (EV) `$XDG_DATA_HOME` exists, return its
    value

2.  Else, if EV `$HOME` exists, return `$HOME/.local/share`

3.  Else, if EV `$USERPROFILE` exists, return
    `$USERPROFILE/.local/share`

4.  Else, return `$fallback`

## See also

[`xdg_config_home()`](https://toscm.github.io/toscutil/reference/xdg_config_home.md)

## Examples

``` r
xdg_data_home()
#> [1] "/home/runner/.local/share"
```
