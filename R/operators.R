#' Default operator
#'
#' Like rlang's %||% but also checks for empty lists and empty strings
#'
#' @param x object to test
#' @param y object to return if `is.none(x)`
#' @export
#' @name op-null-default
#' @examples
#' is.none(FALSE) # TRUE
#' is.none(0) # TRUE
#' is.none(NA) # TRUE
#' is.none(list()) # TRUE
#' is.none("") # TRUEs
#' is.none(1) # FALSE
`%d%` <- function (x, y) { if (is.none(x)) y else x }

#' Plus operator
#'
#' Behaves like normal `+` except for character vectors: here `paste0` is
#' called instead of raising an exception.
#'
#' @export
#' @name op-plus-paste
#' @examples
#' "a" + "b"
`+` <- function(e1, e2) { # TODO: move to toscops
  if (typeof(e1) == "character" && typeof(e2) == "character")
    paste0(e1,e2)
  else
    .Primitive("+")(e1, e2)
}
