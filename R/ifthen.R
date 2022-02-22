#' @export
#' @name ifthen
#' @title Shortcut for multiple else if statements
#' @description `ifthen(a, b, c, d, e, f, ...)` == `if (a) b else if (c) d else
#' if (e) f`
#' @param ... pairs of checks and corresponding return values
#' @return `ifelse` returns the first value for which the corresponding
#' statement evaluates to TRUE
#' @examples
#' x <- 2; y <- 2; z <- 1
#' ifthen(x==0, "foo", y==0, "bar", z==1, "this string gets returned")
ifthen <- function(...) {
    kwargs <- list(...)
    n <- length(kwargs)
    for (i in seq(1, n, by = 2))
        if (kwargs[[i]])
            return(kwargs[[i + 1]])
}
