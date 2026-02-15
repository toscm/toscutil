# Get XDG_CONFIG_HOME

Return value for XDG_CONFIG_HOME as defined by the [XDG Base Directory
Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

## Usage

``` r
xdg_config_home(sep = "/", fallback = normalizePath(getwd(), winslash = sep))
```

## Arguments

- sep:

  Path separator to be used on Windows

- fallback:

  Value to return as fallback (see details)

## Value

The following algorithm is used to determine the returned path:

1.  If environment variable (EV) `XDG_CONFIG_HOME` exists, return its
    value

2.  Else, if EV `HOME` exists, return `$HOME/.config`

3.  Else, if EV `USERPROFILE` exists, return `$USERPROFILE/.config`

4.  Else, return `$fallback`

## See also

[`xdg_data_home()`](https://toscm.github.io/toscutil/reference/xdg_data_home.md)

## Examples

``` r
xdg_config_home()
#> [1] "/home/runner/.config"
```
