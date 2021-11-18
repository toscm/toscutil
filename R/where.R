#' where - locate a symbol
#'
#' Returns the first environment from the search path that defines `x`.
#'
#' @param x symbol of interest
#' @param e environment from where to start the search
#' @export
#' @examples
#' where("rm")
where <- function (x, e=parent.frame()) {
  if (is.name(x) || is.function(x)) x <- as.character(substitute(x))
  if (identical(e, emptyenv())) stop("Can't find ", x, call.=FALSE)
  if (exists(x, e, inherits=FALSE)) e
  else where(x, parent.env(e))
}
