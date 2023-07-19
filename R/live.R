#' @export
#' @name rm_all
#' @title Remove all objects from global environment
#' @description Same as `rm(list=ls())`
#' @examples \dontrun{rm_all()}
#' @return No return value, called for side effects
#' @keywords live
rm_all <- function() {
    e <- globalenv()
    rm(list=ls(envir=e), envir=e)
}


#' @export
#' @name corn
#' @title Return Corners of Matrix like Objects
#' @description Similar to [head()] and [tail()], but returns `n` rows/cols
#' from each side of `x` (i.e. the corners of `x`).
#' @param x matrix like object
#' @param n number of cols/rows from each corner to return
#' @return `x[c(1:n, N-n:N), c(1:n, N-n:N)]`
#' @examples
#' corn(matrix(1:10000, 100))
#' @keywords live
corn <- function(x, n=2L) {
  if(is.vector(x)) return(x)
  stopifnot("matrix" %in% class(x) || "data.frame" %in% class(x))
  rs <- nrow(x)
  cs <- ncol(x)
  ridx <- if (n > rs/2) 1:rs else c(1:n, (rs-n+1):rs)
  cidx <- if (n > cs/2) 1:cs else c(1:n, (cs-n+1):cs)
  x[ridx, cidx]
}


#' @export
#' @name stub
#' @title Stub Function Arguments
#' @description `stub()` assigns all arguments of a given function as symbols
#' to the specified environment (usually the current environment)
#' @param func function for which the arguments should be stubbed
#' @param ... non-default arguments of `func`
#' @param envir environment to which symbols should be assigned
#' @return list of symbols that are assigned to `envir`
#' @details Stub is thought to be used for interactive testing and unit testing.
#' It does not work for primitive functions.
#' @examples
#' f <- function(x, y = 2, z = 3) x + y + z
#' args <- stub(f, x = 1) # assigns x = 1, y = 2 and z = 3 to current env
#' @keywords live
stub <- function(func, ..., envir = parent.frame()) {
  default_args <- as.list(formals(func))
  args <- list(...)
  stubbed_args <- utils::modifyList(default_args, args)
  do.call(rlang::env_bind, args = c(envir, stubbed_args))
  return(stubbed_args)
}
