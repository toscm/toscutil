#' @export
#' @name op-null-default
#' @title Default operator
#' @description Like rlang's `%||%` but also checks for empty lists and empty
#' strings (for details see
#' *https://rdrr.io/cran/rlang/man/op-null-default.html*).
#' @param x object to test
#' @param y object to return if `is.none(x)`
#' @return Returns `y` if `is.none(x)` else `x`
#' @examples
#' FALSE %none% 2 # returns 2
#' 0 %none% 2 # returns 2
#' NA %none% 2 # returns 2
#' list() %none% 2 # returns 2
#' "" %none% 2 # returns 2
#' 1 %none% 2 # returns 1
#' @seealso [is.none()]
`%none%` <- function (x, y) { if (is.none(x)) y else x }
