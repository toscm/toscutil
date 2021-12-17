#' @export
#' @name cat0
#' @title Equal to `cat(..., sep="")`
#' @family cat
cat0 <- function(..., sep="") { cat(..., sep=sep) }

#' @export
#' @name catn
#' @title Equal to `cat(..., "\n")`
#' @family cat
catn <- function(...) { cat(..., "\n") }

#' @export
#' @name cat0n
#' @title Equal to `cat(..., "\n", sep="")`
#' @family cat
cat0n <- function(..., sep="") { cat(..., "\n", sep=sep) }
