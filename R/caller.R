#' @export
#' @title Return Name of Calling Function
#' @description  Returns the name of a calling function as string, i.e. if
#' function `g` calls function `f` and function `f` calls
#' caller(2)`, then string "g" is returned.
#' @param n How many frames to go up in the call stack
#' @return Name of calling function
#' @details Be careful when using `caller(n)` as input to other functions. Due
#' to R's non-standard-evaluation (NES) mechanism it is possible that the
#' function is not executed directly by that function but instead passed on to
#' other functions, i.e. the correct number of frames to go up cannot be
#' predicted a priori. Solutions are to to evaluate the function first and
#' store the result in a variable and then pass the variable to the function or
#' to just try out the required number of frames to go up in an interactive
#' session. For further examples see section Examples.
#' @examples
#' # Here we want to return a list of all variables created inside a function
#' f <- function(a = 1, b = 2) {
#'   x <- 3
#'   y <- 4
#'   return(locals(without = formalArgs(caller(4))))
#'   # We need to go 4 frames up, to catch the formalArgs of `f`, because the
#'   # `caller(4)` argument is not evaluated directly be `formalArgs`.
#' }
#' all.equal(setdiff(f(), list(x = 3, y = 4)), list())
#'
#' # The same result could have been achieved as follows
#' f <- function(a = 1, b = 2) {
#'   x <- 3
#'   y <- 4
#'   func <- caller(1)
#'   return(locals(without = c("func", formalArgs(func))))
#' }
#' all.equal(setdiff(f(), list(x = 3, y = 4)), list())
caller <- function(n = 1) {
  calls <- sys.calls()
  frame <- sys.nframe() - n
  if (frame <= 0) {
    return(NULL)
  } else {
    return(rlang::call_name(calls[[frame]]))
  }
}
