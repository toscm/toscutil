#' @export
#' @name ifthen
#' @title Shortcut for multiple if else statements
#' @description `ifthen(a, b, c, d, e, f, ...)` == `if (a) b else if (c) d else
#' if (e) f`
#' @param ... pairs of checks and corresponding return values
#' @return `ifelse` returns the first value for which the corresponding
#' statement evaluates to TRUE
#' @examples
#' x <- 2
#' y <- 2
#' z <- 1
#' ifthen(x == 0, "foo", y == 0, "bar", z == 1, "this string gets returned")
#' @keywords check
ifthen <- function(...) {
    kwargs <- list(...)
    n <- length(kwargs)
    for (i in seq(1, n, by = 2)) {
        if (kwargs[[i]]) {
            return(kwargs[[i + 1]])
        }
    }
}


#' @export
#' @name is.none
#' @title Truth checking as in Python
#' @description Returns `TRUE` if `x` is either `FALSE`, `0`, `NULL`, `NA`and
#' empty lists or an empty string. Inspired by python's
#' [bool](https://docs.python.org/3/library/functions.html#bool).
#' @param x object to test
#' @return `TRUE` if `x` is `FALSE`, 0, `NULL`, `NA`, an empty list or an empty
#' string. Else `FALSE.`
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
#' @keywords check
is.none <- function(x) {
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

#' @export
#' @name op-null-default
#' @title Return Default if None
#' @description Like [rlang::%||%()] but also checks for empty lists and empty strings.
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
#' @keywords check
#' @seealso [is.none()]
`%none%` <- function(x, y) {
    if (is.none(x)) y else x
}
