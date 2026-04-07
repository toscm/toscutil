#' @export
#' @name rm_all
#' @title Remove all objects from global environment
#' @description Same as `rm(list=ls())`
#' @examples \dontrun{
#' rm_all()
#' }
#' @return No return value, called for side effects
#' @keywords live
rm_all <- function() {
    e <- globalenv()
    rm(list = ls(envir = e), envir = e)
}

#' @export
#' @name corn
#' @title Return Corners of Matrix like Objects
#' @description Similar to [head()] and [tail()], but returns `n` rows/cols
#' from each side of `x` (i.e. the corners of `x`).
#' @param x matrix like object
#' @param n number of cols/rows from each corner to return
#' @return `x[c(1:n, N-n:N), c(1:n, N-n:N)]`
#' @examples
#' corn(matrix(1:10000, 100))
#' @keywords live
corn <- function(x, n = 2L) {
    if (is.vector(x)) {
        return(x)
    }
    stopifnot("matrix" %in% class(x) || "data.frame" %in% class(x))
    rs <- nrow(x)
    cs <- ncol(x)
    ridx <- if (n > rs / 2) 1:rs else c(1:n, (rs - n + 1):rs)
    cidx <- if (n > cs / 2) 1:cs else c(1:n, (cs - n + 1):cs)
    x[ridx, cidx]
}


#' @export
#' @name stub
#' @title Stub Function Arguments
#' @description `stub()` assigns all arguments of a given function as symbols
#' to the specified environment (usually the current environment). For arguments
#' without default values, `stub()` will attempt to retrieve their values from
#' `.GlobalEnv` if they exist there.
#' @param func function, function name, or function call expression (e.g.
#'   `f(a=1, b=2)`) for which the arguments should be stubbed. When a function
#'   call expression is provided, the function and its arguments are extracted
#'   from the call.
#' @param ... non-default arguments of `func`. Positional (unnamed) arguments
#'   are matched to the first unmatched formal arguments of `func`, similar to
#'   how R itself matches positional arguments.
#' @param envir environment to which symbols should be assigned
#' @return list of symbols that are assigned to `envir`
#' @details Stub is thought to be used for interactive testing and unit testing.
#' It does not work for primitive functions.
#'
#' When a function has required arguments without defaults, `stub()` will first
#' check if those arguments exist in `.GlobalEnv` and use their values if found.
#' This enables a common dev workflow: (1) Run example code that sets variables,
#' (2) Call `stub(func)`, (3) Modify and execute parts of the function body.
#'
#' `stub()` can also accept a function call expression as its first argument,
#' e.g. `stub(f(a=1, b=2))`. In this case, the function and its arguments are
#' extracted from the call, equivalent to `stub(f, a=1, b=2)`.
#'
#' Positional (unnamed) arguments are matched to the first unmatched formal
#' arguments of the function (those not already covered by named arguments),
#' equivalent to how R itself matches arguments.
#' @examples
#' f <- function(x, y = 2, z = 3) x + y + z
#' args <- stub(f, x = 1) # assigns x = 1, y = 2 and z = 3 to current env
#'
#' # Using positional arguments:
#' args <- stub(f, 1) # same as stub(f, x = 1)
#'
#' # Using a function call expression:
#' args <- stub(f(1, y = 2)) # same as stub(f, x = 1, y = 2)
#'
#' # stub() can also use values from GlobalEnv for missing args:
#' g <- function(a, b = 10) a + b
#' a <- 5 # Set in GlobalEnv
#' stub(g) # Uses a = 5 from GlobalEnv, assigns a = 5 and b = 10
#' @keywords live
stub <- function(func, ..., envir = parent.frame()) {
    # Capture func as unevaluated expression to support call syntax like
    # stub(f(a=1, b=2)) in addition to the standard stub(f, a=1, b=2).
    func_expr <- substitute(func)

    # Determine whether func_expr is a function call (e.g. f(a=1, b=2)) vs a
    # function name/value (e.g. f or function(x) x+1 or pkg::f).
    # A "function call" here means: a call whose head is not the `function`
    # keyword AND not a namespace accessor operator (:: or :::).
    is_fn_call_expr <- (
        is.call(func_expr) &&
        !identical(func_expr[[1]], quote(function)) &&
        !(is.symbol(func_expr[[1]]) &&
          as.character(func_expr[[1]]) %in% c("::", ":::"))
    )

    if (is_fn_call_expr) {
        # func_expr is a function call like f(a=1, b=2) or pkg::f(a=1, b=2).
        # Extract the function from the call head and evaluate the arguments.
        actual_func <- eval(func_expr[[1]], envir = parent.frame())
        call_args_expr <- as.list(func_expr[-1])
        call_args <- lapply(call_args_expr, eval, envir = parent.frame())
        names(call_args) <- names(call_args_expr)
        user_args <- c(call_args, list(...))
    } else {
        actual_func <- eval(func_expr, envir = parent.frame())
        user_args <- list(...)
    }

    # Split user_args into named and positional (unnamed) arguments.
    arg_names <- names(user_args)
    if (is.null(arg_names)) arg_names <- rep("", length(user_args))
    is_named <- nzchar(arg_names)
    named_args <- user_args[is_named]
    pos_args <- user_args[!is_named]

    # Match positional args to first n unmatched formal args (excluding ...).
    default_args <- as.list(formals(actual_func))
    formal_names <- names(default_args)
    remaining_formals <- formal_names[
        !formal_names %in% names(named_args) & formal_names != "..."
    ]
    if (length(pos_args) > length(remaining_formals)) {
        stop(sprintf(
            paste0(
                "Too many positional arguments: %d provided",
                " but only %d unmatched formal argument(s) available"
            ),
            length(pos_args),
            length(remaining_formals)
        ))
    }
    matched_pos <- setNames(pos_args, remaining_formals[seq_along(pos_args)])

    # Combine named and positionally-matched args, then merge with defaults.
    user_args_named <- c(named_args, matched_pos)
    stubbed_args <- modifyList(default_args, user_args_named)

    # Construct stubs
    for (name in names(stubbed_args)) {
        if (identical(name, "...")) {
            # Stub variadic args as NULL, so `list(...)` produces an empty list.
            stubbed_args[name] <- list(NULL)
        } else if (identical(stubbed_args[[name]], quote(expr = ))) {
            # Try to get unspecified args from .GlobalEnv.
            # If that fails, raise an error.
            # Note: R uses `quote(expr=)` to represent missing values.
            if (exists(name, envir = .GlobalEnv)) {
                stubbed_args[[name]] <- get(name, envir = .GlobalEnv)
            } else {
                stop(sprintf(
                    "argument '%s' is missing, with no default and not found in .GlobalEnv",
                    name
                ))
            }
        } else {
            # Make sure other arguments (user-defined or function-defaults) are
            # evaluated, so they can be used directly in the environment.
            stubbed_args[[name]] <- eval(stubbed_args[[name]])
            envir[[name]] <- stubbed_args[[name]]
        }
    }

    # Assign stubs to environment
    for (name in names(stubbed_args)) {
        if (is.null(stubbed_args[[name]])) {
            assign(name, NULL, envir = envir)
        } else {
            envir[[name]] <- stubbed_args[[name]]
        }
    }

    # Print summary of stubbed arguments, unless silenced via options.
    if (!isTRUE(getOption("toscutil.stub.silent", FALSE))) {
        env_name <- environmentName(envir)
        if (!nzchar(env_name)) env_name <- "anonymous environment"
        cat(sprintf(
            "Created %d variables in %s:\n",
            length(stubbed_args),
            env_name
        ))
        str(stubbed_args, 1, no.list = TRUE)
    }

    invisible(stubbed_args)
}
