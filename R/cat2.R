#' @export
#' @name cat2
#' @title Concatenate and Print
#' @description Same as `cat` but with an additional argument `end`,
#' which gets printed after all other elements. Inspired by pythons `print`
#' command.
#' 
#' **Deprecation note**: all cat aliases, i.e., everything except cat2 are
#' deprecated and should not be used any more!
#' @param ... objects passed on to \link[base]{cat}
#' @param sep a character vector of strings to append after each element
#' @param end a string to print after all other elements
#' @return No return value, called for side effects
#' @rdname cat2
#' @aliases cat0 catn cat0n catsn catnn
cat2 <- function(..., sep = " ", end = "\n") {
  cat(..., sep = sep)
  cat(end)
}

#' @export
#' @examples cat0("hello", "world") # prints "helloworld" (without newline)
#' @rdname cat2
cat0 <- function(..., sep = "", end = "") {
  cat2(..., sep = sep, end = end)
}

#' @export
#' @examples catn("hello", "world") # prints "hello world\n"
#' @rdname cat2
catn <- function(..., sep = " ", end = "\n") {
  cat2(..., sep = sep, end = end)
}

#' @export
#' @examples cat0n("hello", "world") # prints "helloworld\n"
#' @rdname cat2
cat0n <- function(..., sep = "", end = "\n") {
  cat2(..., sep = sep, end = end)
}

#' @export
#' @examples catsn("hello", "world") # prints "hello world\n"
#' @rdname cat2
catsn <- function(..., sep = " ", end = "\n") {
  cat2(..., sep = sep, end = end)
}

#' @export
#' @examples catnn("hello", "world") # prints "hello\nworld\n"
#' @rdname cat2
catnn <- function(..., sep = "\n", end = "\n") {
  cat2(..., sep = sep, end = end)
}
