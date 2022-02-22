#' @export
#' @name named
#' @title Automatically named List
#' @description Like normal `list()`, except that unnamed elements are
#' automatically named according to their symbol
#' @param ... List elements
#' @return Object of type `list` with names attribute set
#' @examples
#' a <- 1:10
#' b <- "helloworld"
#' l1 <- list(a, b)
#' names(l1) <- c("a", "b")
#' l2 <- named(a, b)
#' identical(l1, l2)
#' l3 <- list(z=a, b=b)
#' l4 <- named(z=a, b)
#' identical(l3, l4)
#' @seealso [list()]
named <- function(...){
    .elems <- list(...)
    .symbols <- as.character(substitute(list(...)))[-1]
    .idx <- names(.elems) == ""
    names(.elems)[.idx] <- .symbols[.idx]
    .elems
}
