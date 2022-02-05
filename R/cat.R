#' @export
#' @name cat0
#' @param ... objects passed on to `cat`
#' @param sep a character vector of strings to append after each element
#' @title Equal to `cat(..., sep="")`
#' @family cat
cat0 <- function(..., sep="") { cat(..., sep=sep) }

#' @export
#' @name catn
#' @param ... objects passed on to `cat`
#' @title Equal to `cat(..., "\n")`
#' @family cat
catn <- function(...) { cat(..., "\n") }

#' @export
#' @name cat0n
#' @param ... objects passed on to `cat`
#' @param sep a character vector of strings to append after each element
#' @title Equal to `cat(..., "\n", sep="")`
#' @family cat
cat0n <- function(..., sep="") { cat(..., "\n", sep=sep) }
