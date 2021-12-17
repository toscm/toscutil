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
`%none%` <- function (x, y) { if (is.none(x)) y else x }
