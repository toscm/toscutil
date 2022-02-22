#' @export
#' @name corn
#' @title Return Corners of Matrix like Objects
#' @description Like head and tail, but returns `n` rows/cols from each side of
#' `x` (i.e. the corners of `x`)
#' @param x matrix like object
#' @param n number of cols/rows from each corner to return
#' @return `x[c(1:n, N-n:N), c(1:n, N-n:N)]`
#' @examples
#' corn(matrix(1:10000, 100))
corn <- function(x, n=2L) {
  if(is.vector(x)) return(x)
  stopifnot("matrix" %in% class(x) || "data.frame" %in% class(x))
  rs <- nrow(x)
  cs <- ncol(x)
  ridx <- if (n > rs/2) 1:rs else c(1:n, (rs-n+1):rs)
  cidx <- if (n > cs/2) 1:cs else c(1:n, (cs-n+1):cs)
  x[ridx, cidx]
}
