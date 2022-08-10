#' @export
#' @name is.none
#' @title Like [pythons
#' `bool`](https://docs.python.org/3/library/functions.html#bool)
#' @description TRUE for FALSE, 0, NULL, NA, empty lists and empty string
#' @param x object to test
#' @return TRUE if `x` is FALSE, 0, NULL, NA, an empty list or an empty
#' string. Else FALSE.
#' @examples
#' is.none(FALSE) # TRUE
#' is.none(0) # TRUE
#' is.none(1) # FALSE
#' is.none(NA) # TRUE
#' is.none(list()) # TRUE
#' is.none("") # TRUE
#' is.none(character()) # TRUE
#' is.none(numeric()) # TRUE
#' is.none(logical()) # TRUE
is.none <- function (x)  {
  if (
    is.null(x) || # use `||` instead of `any()` for lazy evaluation
    identical(x, NA) || # better than is.na because not vectorised
    identical(x, FALSE) ||
    identical(x, "") ||
    identical(x, 0) ||
    isTRUE(length(x) == 0)
  ) {
    TRUE
  } else {
    FALSE
  }
}
