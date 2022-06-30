#' @export
#' @title Return function environment as list
#' @description Return current env without function arguments as list. Raises
#' an error when called outside a function.
#' @param without character vector of symbols to exclude
#' @param strip_function_args Whether to exclude symbols with the same name as
#' the function arguments
#' @return The function environment as list
#' @details The order of the symbols in the returned list is arbitrary.
#' @examples
#' f <- function(a = 1, b = 2) {
#'   x <- 3
#'   y <- 4
#'   return(function_locals())
#' }
#' all.equal(setdiff(f(), list(x = 3, y = 4)), list())
function_locals <- function(without = c(), strip_function_args = TRUE) {
  if (strip_function_args) {
    f <- caller(2)
    e <- parent.frame()
    locals(without = c(without, names(formals(f, envir = e))), env = e)
  } else {
    locals(env = parent.frame())
  }
}
