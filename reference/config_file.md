# Get Normalized Configuration File Path of a Program

`config_file` returns the absolute, normalized path to the configuration
file of a program/package/app based on an optional app-specific
commandline argument, an optional app-specific environment variable and
the [XDG Base Directory
Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

## Usage

``` r
config_file(
  app_name,
  file_name,
  cl_arg = commandArgs()[grep("--config-file", commandArgs()) + 1],
  env_var = "",
  sep = "/",
  copy_dir = norm_path(xdg_config_home(), app_name),
  fallback_path = NULL
)
```

## Arguments

- app_name:

  Name of the program/package/app

- file_name:

  Name of the configuration file

- cl_arg:

  Value of app specific commandline parameter

- env_var:

  Value of app specific environment variable

- sep:

  Path separator to be used on Windows

- copy_dir:

  Path to directory where `$fallback_path` should be copied to in case
  it gets used.

- fallback_path:

  Value to return as fallback (see details)

## Value

Normalized path to the configuration file of `$app_name`.

## Details

The following algorithm is used to determine the location of
`$file_name`:

1.  If `$cl_arg` is a non-empty string, return it

2.  Else, if `$env_var` is a non-empty string, return it

3.  Else, if `$PWD/.config/$app_name` exists, return it

4.  Else, if `$XDG_CONFIG_HOME/$app_name/$file_name` exists, return it

5.  Else, if `$HOME/.config/$app_name/$file_name` exists, return it

6.  Else, if `$USERPROFILE/.config/$app_name/$file_name` exists, return
    it

7.  Else, if `$copy_dir` is non-empty string and `$fallback_path` is a
    path to an existing file, then try to copy `$fallback_path` to
    `copy_dir`/`$file_name` and return `copy_dir`/`$file_name` (Note,
    that in case \$copy_dir is a non-valid path, the function will throw
    an error.)

8.  Else, return \$fallback_path

## See also

[`config_dir()`](https://toscm.github.io/toscutil/reference/config_dir.md),
[`xdg_config_home()`](https://toscm.github.io/toscutil/reference/xdg_config_home.md)

## Examples

``` r
config_dir("myApp")
#> [1] "/home/runner/.config/myApp"
```
