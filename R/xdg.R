#' @export
#' @name config_dir
#' @title Return Normalized Configuration Directory Path of a Program
#' @description `config_dir` returns the absolute, normalized path to the
#' configuration directory of a program/package/app based on an optional
#' app-specific commandline argument, an optional app-specific environment
#' variable and the [XDG Base Directory
#' Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param app_name Name of the program/package/app
#' @param cl_arg Value of app specific commandline parameter
#' @param env_var Value of app specific environment variable
#' @param create whether to create returned path, if it doesn't exists yet
#' @param sep Path separator to be used on Windows
#' @return Normalized path to the configuration directory of `<app_name>`.
#' @examples
#' config_dir("myApp")
#' @details The following algorithm is used to determine the location of the
#' configuration directory for application `<app_name>`:
#'
#' 1. If parameter `<cl_arg>` is a non-empty string, return `cl_arg`
#' 2. Else, if parameter `<env_var>` is a non-empty string, return `<env_var>`
#' 3. Else, if environment variable (EV) `$XDG_CONFIG_HOME` exists, return
#'    `$XDG_CONFIG_HOME/<app_name>`
#' 4. Else, if EV `$HOME` exists, return `$HOME/.config/<app_name>`
#' 5. Else, if EV `$USERPROFILE` exists, return
#'    `$USERPROFILE/.config/<app_name>`
#' 6. Else, return `<current-working-directory>/.config/<app-name>`
#' @seealso [data_dir()], [config_file()], [xdg_config_home()]
config_dir <- function(
	app_name,
	cl_arg = {commandArgs()[grep("--config-dir", commandArgs()) + 1]},
	env_var = Sys.getenv(toupper(paste0(app_name, "_config_dir()"))),
	create = FALSE,
	sep="/"
) {
	config_dir <- {
		if (is_non_empty_string(cl_arg)) {
			cl_arg
		} else if (is_non_empty_string(env_var)) {
			env_var
		} else {
			file.path(xdg_config_home(sep=sep), app_name)
		}
	}
	if (!dir.exists(config_dir) && isTRUE(create)) {
		dir.create(config_dir, recursive = TRUE)
	}
	return(config_dir)
}

#' @export
#' @name data_dir
#' @title Return Normalized Data Directory Path of a Program
#' @description `data_dir` returns the absolute, normalized path to the
#' data directory of a program/package/app based on an optional app-specific
#' commandline argument, an optional app-specific environment variable and the
#' [XDG Base Directory
#' Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param app_name Name of the program/package/app
#' @param cl_arg Value of app specific commandline parameter
#' @param env_var Value of app specific environment variable
#' @param create whether to create returned path, if it doesn't exists yet
#' @param sep Path separator to be used on Windows
#' @return Normalized path to the data directory of `<app_name>`.
#' @examples
#' data_dir("myApp")
#' @details The following algorithm is used to determine the location of the
#' data directory for application `<app_name>`:
#'
#' 1. If parameter `<cl_arg>` is a non-empty string, return `cl_arg`
#' 2. Else, if parameter `<env_var>` is a non-empty string, return `<env_var>`
#' 3. Else, if environment variable (EV) `$XDG_DATA_HOME` exists, return
#'    `$XDG_DATA_HOME/<app_name>`
#' 4. Else, if EV `$HOME` exists, return `$HOME/.local/share/<app_name>`
#' 5. Else, if EV `$USERPROFILE` exists, return
#'    `$USERPROFILE/.local/share/<app_name>`
#' 6. Else, return `<current-working-directory>/.local/share`
#' @seealso [config_dir()], [xdg_data_home()]
data_dir <- function(
	app_name,
	cl_arg = commandArgs()[grep("--data-dir", commandArgs()) + 1],
	env_var = Sys.getenv(toupper(paste0(app_name, "_DATA_DIR"))),
	create = FALSE,
	sep="/"
) {
	data_dir <- {
		if (is_non_empty_string(cl_arg)) {
			cl_arg
		} else if (is_non_empty_string(env_var)) {
			env_var
		} else {
			file.path(xdg_data_home(sep=sep), app_name)
		}
	}
	if (!dir.exists(data_dir) && isTRUE(create)) {
		dir.create(data_dir, recursive = TRUE)
	}
	return(data_dir)
}

#' @export
#' @name norm_path
#' @title Return Normalized Path
#' @description Shortcut for
#' `normalizePath(file.path(...), winslash=sep, mustWork=FALSE)`
#' @param ... Parts used to construct the path
#' @param sep Path separator to be used on Windows
#' @return Normalized path constructed from ...
#' @examples
#' norm_path("C:/Users/max", "a\\b", "c") # returns C:/Users/max/a/b/c
#' norm_path("a\\b", "c") # return <current-working-dir>/a/b/c
norm_path <- function(..., sep="/") {
	normalizePath(file.path(...), winslash=sep, mustWork=FALSE)
}

#' @export
#' @name config_file
#' @title Return Normalized Configuration File Path of a Program
#' @description `config_file` returns the absolute, normalized path to the
#' configuration file of a program/package/app based on an optional
#' app-specific commandline argument, an optional app-specific environment
#' variable and the [XDG Base Directory
#' Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param app_name Name of the program/package/app
#' @param file_name Name of the configuration file
#' @param cl_arg Value of app specific commandline parameter
#' @param env_var Value of app specific environment variable
#' @param sep Path separator to be used on Windows
#' @param copy_dir Path to directory where `<fallback_path>` should be copied to
#' in case it gets used.
#' @param fallback_path Value to return as fallback (see details)
#' @return Normalized path to the configuration file of `<app_name>`.
#' @examples
#' config_dir("myApp")
#' @details The following algorithm is used to determine the location of
#' `<file_name>`:
#'
#' 1. If `<cl_arg>` is a non-empty string, return it
#' 2. Else, if `<env_var>` is a non-empty string, return it
#' 3. Else, if `${PWD}/.config/<app-name>` exists, return it
#' 4. Else, if `$XDG_CONFIG_HOME/<app_name>/<file_name>` exists, return it
#' 5. Else, if `$HOME/.config/<app_name>/<file_name>` exists, return it
#' 6. Else, if `$USERPROFILE/.config/<app_name>/<file_name>` exists, return it
#' 7. Else, if `<copy_dir>` is non-empty string and `<fallback_path>` is a path
#' 	  to an existing file, then try to copy `<fallback_path>` to
#'    `copy_dir`/`<file_name>` and return `copy_dir`/`<file_name>` (Note, that
#'    in case <copy_dir> is a non-valid path, the function will throw an error.)
#' 8. Else, return <fallback_path>
#' @seealso [config_dir()], [xdg_config_home()]
config_file <- function(
	app_name,
	file_name,
	cl_arg = {commandArgs()[grep("--config-file", commandArgs()) + 1]},
	env_var = "",
	sep="/",
	copy_dir=norm_path(xdg_config_home(), app_name),
	fallback_path=NULL
) {
	norm <- function(...) { norm_path(..., sep=sep) }
	if (is_non_empty_string(cl_arg))
		return(norm(cl_arg))
	if (is_non_empty_string(env_var))
		return(norm(env_var))
	if (file.exists(norm(getwd(), file_name)))
		return(norm(getwd(), file_name))
	x <- norm(Sys.getenv("XDG_CONFIG_HOME"), app_name, file_name)
	if (Sys.getenv("XDG_CONFIG_HOME") != "" && file.exists(x))
		return(x)
	x <- norm(Sys.getenv("HOME"), ".config", app_name, file_name)
	if (Sys.getenv("HOME") != "" && file.exists(x))
		return(x)
	x <- norm(Sys.getenv("USERPROFILE"), ".config", app_name, file_name)
	if (Sys.getenv("USERPROFILE") != "" && file.exists(x))
		return(x)
	# If we reach this point:
	# 1. no config file <filename> was specified via commandline
	# 2. no config file <filename> was specified via environment variable
	# 3. no config file <filename> exists at ${PWD}
	# 4. no config file <filename> exists at $XDG_CONFIG_HOME
	# 5. no config file <filename> exists at $HOME/.config
	# 6. no config file <filename> exists at $USERPROFILE/.config
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

is_non_empty_string <- function(x) {
	if (!is.null(x) && length(x) == 1 && is.character(x) && nchar(x) != 0) {
		return(TRUE)
	} else {
		return(FALSE)
	}
}

#' @export
#' @name xdg_data_home
#' @title Return $XDG_DATA_HOME
#' @description Return value for $XDG_DATA_HOME as defined by the [XDG Base
#' Directory
#' Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param sep Path separator to be used on Windows
#' @param fallback Value to return as fallback (see details)
#' @return The following algorithm is used to determine the returned path:
#'
#' 1. If environment variable (EV) `$XDG_DATA_HOME` exists, return its value
#' 2. Else, if EV `$HOME` exists, return `$HOME/.local/share`
#' 3. Else, if EV `$USERPROFILE` exists, return `$USERPROFILE/.local/share`
#' 4. Else, return `<fallback>`
#' @examples
#' xdg_data_home()
#' @seealso [xdg_config_home()]
xdg_data_home <- function(
	sep="/",
	fallback=normalizePath(getwd(), winslash=sep)
) {
	if (Sys.getenv("XDG_DATA_HOME") != "") {
		normalizePath(Sys.getenv("XDG_DATA_HOME"), winslash=sep)
	} else if (Sys.getenv("HOME") != "") {
		file.path(
			normalizePath(Sys.getenv("HOME"), winslash=sep),
			".local", "share", fsep=sep
		)
	} else if (Sys.getenv("USERPOFILE") != "") {
		file.path(
			normalizePath(Sys.getenv("USERPROFILE"), winslash=sep),
			".local", "share", fsep=sep
		)
	} else {
		fallback
	}
}

#' @export
#' @name xdg_config_home
#' @title Return $XDG_CONFIG_HOME
#' @description Return value for $XDG_CONFIG_HOME as defined by the [XDG Base
#' Directory
#' Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
#' @param sep Path separator to be used on Windows
#' @param fallback Value to return as fallback (see details)
#' @return The following algorithm is used to determine the returned path:
#'
#' 1. If environment variable (EV) `$XDG_CONFIG_HOME` exists, return its value
#' 2. Else, if EV `$HOME` exists, return `$HOME/.config`
#' 3. Else, if EV `$USERPROFILE` exists, return `$USERPROFILE/.config`
#' 4. Else, return `<fallback>`
#' @examples
#' xdg_config_home()
#' @seealso [xdg_data_home()]
xdg_config_home <- function(
	sep="/",
	fallback=normalizePath(getwd(), winslash=sep)
) {
	if (Sys.getenv("XDG_CONFIG_HOME") != "") {
		normalizePath(Sys.getenv("XDG_CONFIG_HOME"), winslash=sep)
	} else if (Sys.getenv("HOME") != "") {
		file.path(
			normalizePath(Sys.getenv("HOME"), winslash=sep),
			".config", fsep=sep
		)
	} else if (Sys.getenv("USERPOFILE") != "") {
		file.path(
			normalizePath(Sys.getenv("USERPROFILE"), winslash=sep),
			".config", fsep=sep
		)
	} else {
		fallback
	}
}
