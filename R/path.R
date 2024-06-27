#' @export
#' @name config_dir
#' @title Get Normalized Configuration Directory Path of a Program
#' @description `config_dir` returns the absolute, normalized path to the configuration directory of a program/package/app based on an optional app-specific commandline argument, an optional app-specific environment variable and the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param app_name Name of the program/package/app
#' @param cl_arg Value of app specific commandline parameter
#' @param env_var Value of app specific environment variable
#' @param create whether to create returned path, if it doesn't exists yet
#' @param sep Path separator to be used on Windows
#' @return Normalized path to the configuration directory of `$app_name`.
#' @details The following algorithm is used to determine the location of the configuration directory for application `$app_name`:
#'
#' 1. If parameter `cl_arg` is a non-empty string, return it
#' 2. Else, if parameter `env_var` is a non-empty string, return it
#' 3. Else, if environment variable (EV) `XDG_CONFIG_HOME` exists, return
#'    `$XDG_CONFIG_HOME/$app_name`
#' 4. Else, if EV `HOME` exists, return `$HOME/.config/{app_name}`
#' 5. Else, if EV `USERPROFILE` exists, return
#'    `$USERPROFILE/.config/{app_name}`
#' 6. Else, return `$WD/.config/{app-name}`
#'
#' where `$WD` equals the current working directory and the notation `$VAR` is used to specify the value of a parameter or environment variable VAR.
#' @seealso [data_dir()], [config_file()], [xdg_config_home()]
#' @examples
#' config_dir("myApp")
#' @keywords path
config_dir <- function(app_name,
                       cl_arg = commandArgs()[grep("--config-dir", commandArgs()) + 1],
                       env_var = Sys.getenv(toupper(paste0(app_name, "_config_dir()"))),
                       create = FALSE,
                       sep = "/") {
    config_dir <- if (is_non_empty_string(cl_arg)) {
        cl_arg
    } else if (is_non_empty_string(env_var)) {
        env_var
    } else {
        file.path(xdg_config_home(sep = sep), app_name)
    }
    if (!dir.exists(config_dir) && isTRUE(create)) {
        dir.create(config_dir, recursive = TRUE)
    }
    return(config_dir)
}


#' @export
#' @name config_file
#' @title Get Normalized Configuration File Path of a Program
#' @description `config_file` returns the absolute, normalized path to the configuration file of a program/package/app based on an optional app-specific commandline argument, an optional app-specific environment variable and the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param app_name Name of the program/package/app
#' @param file_name Name of the configuration file
#' @param cl_arg Value of app specific commandline parameter
#' @param env_var Value of app specific environment variable
#' @param sep Path separator to be used on Windows
#' @param copy_dir Path to directory where `$fallback_path` should be copied to in case it gets used.
#' @param fallback_path Value to return as fallback (see details)
#' @return Normalized path to the configuration file of `$app_name`.
#' @details The following algorithm is used to determine the location of `$file_name`:
#'
#' 1. If `$cl_arg` is a non-empty string, return it
#' 2. Else, if `$env_var` is a non-empty string, return it
#' 3. Else, if `$PWD/.config/$app_name` exists, return it
#' 4. Else, if `$XDG_CONFIG_HOME/$app_name/$file_name` exists, return it
#' 5. Else, if `$HOME/.config/$app_name/$file_name` exists, return it
#' 6. Else, if `$USERPROFILE/.config/$app_name/$file_name` exists, return it
#' 7. Else, if `$copy_dir` is non-empty string and `$fallback_path` is a path
#' 	  to an existing file, then try to copy `$fallback_path` to
#'    `copy_dir`/`$file_name` and return `copy_dir`/`$file_name` (Note, that
#'    in case $copy_dir is a non-valid path, the function will throw an error.)
#' 8. Else, return $fallback_path
#' @examples
#' config_dir("myApp")
#' @keywords path
#' @seealso [config_dir()], [xdg_config_home()]
config_file <- function(app_name,
                        file_name,
                        cl_arg = commandArgs()[grep("--config-file", commandArgs()) + 1],
                        env_var = "",
                        sep = "/",
                        copy_dir = norm_path(xdg_config_home(), app_name),
                        fallback_path = NULL) {
    norm <- function(...) {
        norm_path(..., sep = sep)
    }
    if (is_non_empty_string(cl_arg)) {
        return(norm(cl_arg))
    }
    if (is_non_empty_string(env_var)) {
        return(norm(env_var))
    }
    if (file.exists(norm(getwd(), file_name))) {
        return(norm(getwd(), file_name))
    }
    x <- norm(Sys.getenv("XDG_CONFIG_HOME"), app_name, file_name)
    if (Sys.getenv("XDG_CONFIG_HOME") != "" && file.exists(x)) {
        return(x)
    }
    x <- norm(Sys.getenv("HOME"), ".config", app_name, file_name)
    if (Sys.getenv("HOME") != "" && file.exists(x)) {
        return(x)
    }
    x <- norm(Sys.getenv("USERPROFILE"), ".config", app_name, file_name)
    if (Sys.getenv("USERPROFILE") != "" && file.exists(x)) {
        return(x)
    }
    # If we reach this point:
    # 1. no config file $filename was specified via commandline
    # 2. no config file $filename was specified via environment variable
    # 3. no config file $filename exists at $WD
    # 4. no config file $filename exists at $XDG_CONFIG_HOME
    # 5. no config file $filename exists at $HOME/.config
    # 6. no config file $filename exists at $USERPROFILE/.config
    if (is_non_empty_string(copy_dir) &&
        is_non_empty_string(fallback_path) &&
        file.exists(fallback_path)
    ) {
        if (!dir.exists(copy_dir)) {
            dir.create(copy_dir, recursive = TRUE)
        }
        file.copy(fallback_path, norm(copy_dir, file_name))
        return(norm(copy_dir, file_name))
    }
    return(fallback_path)
}


#' @export
#' @name data_dir
#' @title Get Normalized Data Directory Path of a Program
#' @description `data_dir` returns the absolute, normalized path to the data directory of a program/package/app based on an optional app-specific commandline argument, an optional app-specific environment variable and the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param app_name Name of the program/package/app
#' @param cl_arg Value of app specific commandline parameter
#' @param env_var Value of app specific environment variable
#' @param create whether to create returned path, if it doesn't exists yet
#' @param sep Path separator to be used on Windows
#' @return Normalized path to the data directory of `$app_name`.
#' @examples
#' data_dir("myApp")
#' @details The following algorithm is used to determine the location of the data directory for application `$app_name`:
#' 1. If parameter `$cl_arg` is a non-empty string, return `cl_arg`
#' 2. Else, if parameter `$env_var` is a non-empty string, return `$env_var`
#' 3. Else, if environment variable (EV) `$XDG_DATA_HOME` exists, return
#'    `$XDG_DATA_HOME/$app_name`
#' 4. Else, if EV `$HOME` exists, return `$HOME/.local/share/$app_name`
#' 5. Else, if EV `$USERPROFILE` exists, return
#'    `$USERPROFILE/.local/share/$app_name`
#' 6. Else, return `$WD/.local/share`
#' @keywords path
#' @seealso [config_dir()], [xdg_data_home()]
data_dir <- function(app_name,
                     cl_arg = commandArgs()[grep("--data-dir", commandArgs()) + 1],
                     env_var = Sys.getenv(toupper(paste0(app_name, "_DATA_DIR"))),
                     create = FALSE,
                     sep = "/") {
    data_dir <- if (is_non_empty_string(cl_arg)) {
        cl_arg
    } else if (is_non_empty_string(env_var)) {
        env_var
    } else {
        file.path(xdg_data_home(sep = sep), app_name)
    }
    if (!dir.exists(data_dir) && isTRUE(create)) {
        dir.create(data_dir, recursive = TRUE)
    }
    return(data_dir)
}


#' @export
#' @name getfd
#' @title Get File Directory
#' @description Return full path to current file directory
#' @param on.error Expression to use if the current file directory cannot be determined. In that case, `normalizePath(on.error, winslash)` is returned. Can also be an expression like `stop("message")` to stop execution (default).
#' @param winslash Path separator to use for windows
#' @return Current file directory as string
#' @examples
#' getfd(on.error = getwd())
#' \dontrun{
#' getfd()
#' }
#' @keywords path
getfd <- function(on.error = stop("No file sourced. Maybe you're in an interactive shell?", call. = FALSE),
                  winslash = "/") {
    if (interactive() && sys.nframe() > 0 && "ofile" %in% ls(sys.frame(0))) {
        # probably started through `source` from interactive R session
        f <- sys.frame(1)$ofile
    } else {
        # probably started through `Rscript` from external shell
        args <- commandArgs()
        filearg_idx <- grepl("^--file=", args)
        if (any(filearg_idx)) {
            filearg <- args[filearg_idx][[1]]
            f <- strsplit(filearg, "--file=")[[1]][2]
        } else {
            return(normalizePath(on.error, winslash = winslash))
        }
    }
    return(normalizePath(dirname(f), winslash = winslash))
}


#' @export
#' @name getpd
#' @title Get Project Directory
#' @description Find the project root directory by traversing the current working directory filepath upwards until a given set of files is found.
#' @param root.files if any of these files is found in a parent folder, the path to that folder is returned
#' @return `getpd` returns the absolute, normalized project root directory as string. The forward slash is used as path separator (independent of the OS).
#' @examples
#' local({
#'      base_pkg_root_dir <- system.file(package = "base")
#'      base_pkg_R_dir <- file.path(base_pkg_root_dir, "R")
#'      owd <- setwd(base_pkg_R_dir); on.exit(setwd(owd))
#'      getpd()
#' })
#' @keywords path
getpd <- function(root.files = c(".git", "DESCRIPTION", "NAMESPACE")) {
    owd <- ""
    wd <- normalizePath(getwd(), winslash = "/")
    while (!any(dir(wd) %in% root.files) && wd != owd) {
        owd <- wd
        wd <- dirname(wd)
    }
    if (wd == owd) {
        stop("could not find project root folder")
    }
    wd
}


#' @export
#' @name home
#' @title Get USERPROFILE or HOME
#' @description Returns normalized value of environment variable USERPROFILE, if defined, else value of HOME.
#' @param winslash path separator to be used on Windows (passed on to `normalizePath`)
#' @return normalized value of environment variable USERPROFILE, if defined, else value of HOME.
#' @examples home()
#' @keywords path
home <- function(winslash = "/") {
    home <- Sys.getenv("USERPROFILE")
    if (home == "") home <- Sys.getenv("HOME")
    if (home == "") stop("Neither USERPROFILE nor HOME is defined")
    return(normalizePath(home, winslash = winslash, mustWork = FALSE))
}


#' @export
#' @name xdg_data_home
#' @title Get XDG_DATA_HOME
#' @description Return value for XDG_DATA_HOME as defined by the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param sep Path separator to be used on Windows
#' @param fallback Value to return as fallback (see details)
#' @return The following algorithm is used to determine the returned path:
#' 1. If environment variable (EV) `$XDG_DATA_HOME` exists, return its value
#' 2. Else, if EV `$HOME` exists, return `$HOME/.local/share`
#' 3. Else, if EV `$USERPROFILE` exists, return `$USERPROFILE/.local/share`
#' 4. Else, return `$fallback`
#' @examples
#' xdg_data_home()
#' @keywords path
#' @seealso [xdg_config_home()]
xdg_data_home <- function(sep = "/",
                          fallback = normalizePath(getwd(), winslash = sep)) {
    if (Sys.getenv("XDG_DATA_HOME") != "") {
        normalizePath(Sys.getenv("XDG_DATA_HOME"), winslash = sep)
    } else if (Sys.getenv("HOME") != "") {
        home <- normalizePath(Sys.getenv("HOME"), winslash = sep)
        file.path(home, ".local", "share", fsep = sep)
    } else if (Sys.getenv("USERPOFILE") != "") {
        userprofile <- normalizePath(Sys.getenv("USERPROFILE"), winslash = sep)
        file.path(userprofile, ".local", "share", fsep = sep)
    } else {
        fallback
    }
}


#' @export
#' @name xdg_config_home
#' @title Get XDG_CONFIG_HOME
#' @description Return value for XDG_CONFIG_HOME as defined by the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param sep Path separator to be used on Windows
#' @param fallback Value to return as fallback (see details)
#' @return The following algorithm is used to determine the returned path:
#' 1. If environment variable (EV) `XDG_CONFIG_HOME` exists, return its value
#' 2. Else, if EV `HOME` exists, return `$HOME/.config`
#' 3. Else, if EV `USERPROFILE` exists, return `$USERPROFILE/.config`
#' 4. Else, return `$fallback`
#' @examples
#' xdg_config_home()
#' @keywords path
#' @seealso [xdg_data_home()]
xdg_config_home <- function(sep = "/",
                            fallback = normalizePath(getwd(), winslash = sep)) {
    if (Sys.getenv("XDG_CONFIG_HOME") != "") {
        normalizePath(Sys.getenv("XDG_CONFIG_HOME"), winslash = sep)
    } else if (Sys.getenv("HOME") != "") {
        home <- normalizePath(Sys.getenv("HOME"), winslash = sep)
        file.path(home, ".config", fsep = sep)
    } else if (Sys.getenv("USERPOFILE") != "") {
        userprofile <- normalizePath(Sys.getenv("USERPROFILE"), winslash = sep)
        file.path(userprofile, ".config", fsep = sep)
    } else {
        fallback
    }
}


##### Helpers ##################################################################

is_non_empty_string <- function(x) {
    if (!is.null(x) && length(x) == 1 && is.character(x) && nchar(x) != 0) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}
