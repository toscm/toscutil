#' @export
#' @name stub
#' @title Stub Function Arguments
#' @description `stub()` assigns all arguments of a given function as symbols
#' to the specified environment (usually the current environemnt)
#' @param func function for which the arguments should be stubbed
#' @param ... non-default arguments of `func`
#' @param envir environment to which symbols should be assigned
#' @return list of symbols that are assigned to `envir`
#' @details Stub is thought to be used for interactive testing and unit testing.
#' It does not work for primitiv functions.
#' @examples
#' f <- function(x, y = 2, z = 3) x + y + z
#' args <- stub(f, x = 1) # assigns x = 1, y = 2 and z = 3 to current env
stub <- function(func, ..., envir = parent.frame()) {
  default_args <- as.list(formals(func))
  args <- list(...)
  stubbed_args <- modifyList(default_args, args)
  do.call(rlang::env_bind, args=c(envir, stubbed_args))
  return(stubbed_args)
}
