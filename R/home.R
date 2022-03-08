#' @export
#' @name home
#' @title Get USERPROFILE or HOME
#' @description Returns normalized value of environment variable USERPROFILE,
#' if defined, else value of HOME.
#' @param winslash path separator to be used on Windows (passed on to
#' `normalizePath`)
#' @return normalized value of environment variable USERPROFILE,
#' if defined, else value of HOME.
#' @examples home()
home <- function(winslash="/") {
	home <- Sys.getenv("USERPROFILE")
	if (home == "")
		home <- Sys.getenv("HOME")
	if (home == "")
		stop("Neither USERPROFILE nor HOME is defined")
	return(normalizePath(home, winslash=winslash, mustWork=FALSE))
}
