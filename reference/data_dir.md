# Get Normalized Data Directory Path of a Program

`data_dir` returns the absolute, normalized path to the data directory
of a program/package/app based on an optional app-specific commandline
argument, an optional app-specific environment variable and the [XDG
Base Directory
Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

## Usage

``` r
data_dir(
  app_name,
  cl_arg = commandArgs()[grep("--data-dir", commandArgs()) + 1],
  env_var = Sys.getenv(toupper(paste0(app_name, "_DATA_DIR"))),
  create = FALSE,
  sep = "/"
)
```

## Arguments

- app_name:

  Name of the program/package/app

- cl_arg:

  Value of app specific commandline parameter

- env_var:

  Value of app specific environment variable

- create:

  whether to create returned path, if it doesn't exists yet

- sep:

  Path separator to be used on Windows

## Value

Normalized path to the data directory of `$app_name`.

## Details

The following algorithm is used to determine the location of the data
directory for application `$app_name`:

1.  If parameter `$cl_arg` is a non-empty string, return `cl_arg`

2.  Else, if parameter `$env_var` is a non-empty string, return
    `$env_var`

3.  Else, if environment variable (EV) `$XDG_DATA_HOME` exists, return
    `$XDG_DATA_HOME/$app_name`

4.  Else, if EV `$HOME` exists, return `$HOME/.local/share/$app_name`

5.  Else, if EV `$USERPROFILE` exists, return
    `$USERPROFILE/.local/share/$app_name`

6.  Else, return `$WD/.local/share`

## See also

[`config_dir()`](https://toscm.github.io/toscutil/reference/config_dir.md),
[`xdg_data_home()`](https://toscm.github.io/toscutil/reference/xdg_data_home.md)

## Examples

``` r
data_dir("myApp")
#> [1] "/home/runner/.local/share/myApp"
```
