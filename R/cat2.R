#' @export
#' @name cat2
#' @title Concatenate and Print
#' @description Same as `cat` but with an additional argument `end`,
#' which gets printed after all other elements.
#' @param ... objects passed on to `cat`
#' @param sep a character vector of strings to append after each element
#' @param end a string to print after all other elements
#' @return No return value, called for side effects
#' @rdname cat2
#' @aliases catn cat0 cat0n
cat2 <- function(..., sep, end)  { cat(..., sep=sep); cat(end) }

#' @export
#' @examples cat0("hello", "world") # prints "helloworld" (without newline)
#' @rdname cat2
cat0 <- function(..., sep="", end="") { cat2(..., sep=sep, end=end) }

#' @export
#' @examples catn("hello", "world") # prints "hello world\n"
#' @rdname cat2
catn <- function(..., sep=" ", end="\n") { cat2(..., sep=sep, end=end) }

#' @export
#' @examples cat0n("hello", "world") # prints "helloworld\n"
#' @rdname cat2
cat0n <- function(..., sep="", end="\n") { cat2(..., sep=sep, end=end) }
