#' @export
#' @title Get Name of Calling Function
#' @description  Returns the name of a calling function as string, i.e. if function `g` calls function `f` and function `f` calls `caller(2)`, then string `"g"` is returned.
#' @param n How many frames to go up in the call stack
#' @return Name of the calling function
#' @details Be careful when using `caller(n)` as input to other functions. Due to R's non-standard-evaluation (NES) mechanism it is possible that the function is not executed directly by that function but instead passed on to other functions, i.e. the correct number of frames to go up cannot be predicted a priori. Solutions are to evaluate the function first, store the result in a variable and then pass the variable to the function or to just try out the required number of frames to go up in an interactive session. For further examples see section Examples.
#' @examples
#' # Here we want to return a list of all variables created inside a function
#' f <- function(a = 1, b = 2) {
#'     x <- 3
#'     y <- 4
#'     return(locals(without = formalArgs(caller(4))))
#'     # We need to go 4 frames up, to catch the formalArgs of `f`, because the
#'     # `caller(4)` argument is not evaluated directly be `formalArgs`.
#' }
#' f() # returns either list(x = 3, y = 4) or list(y = 4, x = 3)
#'
#' # The same result could have been achieved as follows
#' g <- function(a = 1, b = 2) {
#'     x <- 3
#'     y <- 4
#'     func <- caller(1)
#'     return(locals(without = c("func", formalArgs(func))))
#' }
#' g() # returns either list(x = 3, y = 4) or list(y = 4, x = 3)
#' @keywords func
caller <- function(n = 1) {
    calls <- sys.calls()
    frame <- sys.nframe() - n
    if (frame <= 0) {
        return(NULL)
    } else {
        return(rlang::call_name(calls[[frame]]))
    }
}

#' @export
#' @title Get Function Environment as List
#' @description Returns the function environment as list. Raises an error when called outside a function. By default, objects specified as arguments are removed from the environment.
#' @param without character vector of symbols to exclude
#' @param strip_function_args Whether to exclude symbols with the same name as
#' the function arguments
#' @return The function environment as list
#' @details The order of the symbols in the returned list is arbitrary.
#' @examples
#' f <- function(a = 1, b = 2) {
#'     x <- 3
#'     y <- 4
#'     return(function_locals())
#' }
#' all.equal(setdiff(f(), list(x = 3, y = 4)), list())
#' @keywords func
function_locals <- function(without = c(), strip_function_args = TRUE) {
    if (strip_function_args) {
        f <- caller(2)
        e <- parent.frame()
        locals(without = c(without, names(formals(f, envir = e))), env = e)
    } else {
        locals(env = parent.frame())
    }
}

#' @export
#' @title Get specified Environment as List
#' @description Return all symbols in the specified environment as list.
#' @param without Character vector. Symbols from current env to exclude.
#' @param env Environment to use. Defaults to the environment from which `locals` is called.
#' @return Specified environment as list (without the mentioned symbols).
#' @examples
#' f <- function() {
#'      x <- 1
#'      y <- 2
#'      z <- 3
#'      locals()
#' }
#' ret <- f()
#' stopifnot(identical(ret, list(z = 3, y = 2, x = 1)))
#' @keywords func
locals <- function(without = c(), env = parent.frame()) {
    x <- as.list(env)
    x[without] <- NULL
    return(x)
}

#' @export
#' @name sys.exit
#' @title Terminate a non-interactive R Session
#' @description Similar to python's [sys.exit](https://docs.python.org/3/library/sys.html?highlight=exit#sys.exit). If used interactively, code execution is stopped with an error message, giving the provided status code. If used non-interactively (e.g. through Rscript), code execution is stopped silently and the process exits with the provided status code.
#' @param status exitcode for R process
#' @return No return value, called for side effects
#' @examples \dontrun{
#' if (!file.exists("some.file")) {
#'     cat("Error: some.file does not exist.\n", file = stderr())
#'     sys.exit(1)
#' } else if (Sys.getenv("IMPORTANT_ENV") == "") {
#'     cat("Error: IMPORTANT_ENV not set.\n", file = stderr())
#'     sys.exit(2)
#' } else {
#'     cat("Everything good. Starting calculations...")
#'     # ...
#'     cat("Finished with success!")
#'     sys.exit(0)
#' }
#' }
#' @keywords func
sys.exit <- function(status = 0) {
    if (interactive()) {
        msg <- paste0("sys.exit(", status, ")")
        stop(msg, call. = FALSE)
    } else {
        quit(status = status, save = "no")
    }
}
