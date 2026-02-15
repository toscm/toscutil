# Get Normalized Configuration Directory Path of a Program

`config_dir` returns the absolute, normalized path to the configuration
directory of a program/package/app based on an optional app-specific
commandline argument, an optional app-specific environment variable and
the [XDG Base Directory
Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

## Usage

``` r
config_dir(
  app_name,
  cl_arg = commandArgs()[grep("--config-dir", commandArgs()) + 1],
  env_var = Sys.getenv(toupper(paste0(app_name, "_config_dir()"))),
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

Normalized path to the configuration directory of `$app_name`.

## Details

The following algorithm is used to determine the location of the
configuration directory for application `$app_name`:

1.  If parameter `cl_arg` is a non-empty string, return it

2.  Else, if parameter `env_var` is a non-empty string, return it

3.  Else, if environment variable (EV) `XDG_CONFIG_HOME` exists, return
    `$XDG_CONFIG_HOME/$app_name`

4.  Else, if EV `HOME` exists, return `$HOME/.config/{app_name}`

5.  Else, if EV `USERPROFILE` exists, return
    `$USERPROFILE/.config/{app_name}`

6.  Else, return `$WD/.config/{app-name}`

where `$WD` equals the current working directory and the notation `$VAR`
is used to specify the value of a parameter or environment variable VAR.

## See also

[`data_dir()`](https://toscm.github.io/toscutil/reference/data_dir.md),
[`config_file()`](https://toscm.github.io/toscutil/reference/config_file.md),
[`xdg_config_home()`](https://toscm.github.io/toscutil/reference/xdg_config_home.md)

## Examples

``` r
config_dir("myApp")
#> [1] "/home/runner/.config/myApp"
```
