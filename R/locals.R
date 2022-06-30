#' @export
#' @title Return specified Environment as List
#' @description Return symbols in given environment as list.
#' @param without Character vector. Symbols from current env to exclude.
#' @param env Environment to use. Defaults to the environment from which
#' `locals` is called.
#' @return Specified environment as list (without the mentioned symbols).
locals <- function(without = c(), env = parent.frame()) {
  x <- as.list(env)
  x[without] <- NULL
  return(x)
}
