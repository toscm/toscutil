trace_env <- as.environment(list(
  lvl = 0,
  traced = list()
))

#' @export
#' @title Traces function calls from a package
#' @description Traces all function calls from a package and writes them to `file` with timestamps and callstack depth. Should always be used in combination with [untrace_package()] to untrace the package after use. For example `trace_package("graphics"); on.exit(untrace_package("graphics")`. See examples for more details.
#' @param pkg Package name to trace.
#' @param file File to write to.
#' @param max Maximum depth of callstack to print.
#' @param funign Functions to ignore.
#' @param opsign Whether to ignore operators.
#' @param dotign Whether to ignore functions starting with a dot.
#' @param silent Whether to suppress messages.
#' @param exitmsg Message to print on function exits.
#' @return No return value, called for side effects
#' @details Some function define their own [on.exit()] handlers with option `add = FALSE`. For those functions, exit tracing is impossible (as described in [trace()]). For now those functions have to be detected and ignored manually by the user using argument `funign`.
#' @seealso [untrace_package()]
#' @keywords live
#' @examples \dontrun{
#' # Trace all function from the graphics package, except for `plot.default`
#' # as it defines its own on.exit() handler, i.e. exit tracing is impossible.
#' local({
#'     trace_package("graphics", funign = "plot.default")
#'     on.exit(untrace_package("graphics"), add = TRUE)
#'     plot(1:10)
#' })
#' }
trace_package <- function(pkg,
                          file = stdout(),
                          max = Inf,
                          funign = character(),
                          opsign = TRUE,
                          dotign = TRUE,
                          silent = TRUE,
                          exitmsg = "exit") {
  ns <- asNamespace(pkg)
  objnames <- ls(paste0("package:", pkg), all.names = TRUE) # Interesting: `names(ns)` is much longer than `ls("package:...")`. Not sure why, but for now I only use the names from `ls()` as `names(ns)` seems to contain a lot of super internal stuff.
  is_func <- sapply(objnames, function(nam) is.function(ns[[nam]]))
  funcs <- objnames[is_func]
  if (dotign) funcs <- funcs[grepl("^[^\\.]", funcs, perl = TRUE)]
  if (opsign) funcs <- funcs[!grepl("%.+%", funcs, perl = TRUE)]
  funcs <- setdiff(funcs, funign)
  for (func in funcs) {
    try(untrace_func(func, ns, silent = silent))
    trace_func(func, ns, exitmsg = exitmsg, silent = silent)
  }
  trace_env$traced[[pkg]] <- union(trace_env$traced[[pkg]], funcs)
  invisible(NULL)
}

#' @export
#' @title Untraces function calls from a package
#' @description Removes tracing from all function calls in a package that were previously traced by [trace_package()].
#' @param pkg Package name to untrace.
#' @return No return value, called for side effects
#' @details This function reverses the effects of `trace_package` by removing all tracing from the specified package's functions.
#' @seealso [trace_package()]
#' @keywords live
#' @examples \dontrun{
#' local({
#'     trace_package("graphics", funign = "plot.default")
#'     on.exit(untrace_package("graphics"), add = TRUE)
#'     plot(1:10)
#' })
#' }
untrace_package <- function(pkg) {
  ns <- getNamespace(pkg)
  for (func in trace_env$traced[[pkg]]) untrace(func, ns)
  trace_env$traced[[pkg]] <- NULL
  invisible(NULL)
}

untrace_func <- function(func, ns, silent = TRUE) {
  if (silent) {
    capture.output(type = "output",
      capture.output(type = "message",
        untrace(func, where = ns)
      )
    )
  } else {
    untrace(func, where = ns)
  }
}

#' @title Trace Function Execution
#' @description Adds tracing to a specified function within a given namespace, allowing for logging of function entry and exit points. This can be useful for debugging or monitoring function behavior.
#' @param func The name of the function to trace.
#' @param ns The namespace where the function is located.
#' @param exitmsg A message to log on function exit. Default is "exit".
#' @param silent If TRUE, suppresses the output of the tracing logs. Default is TRUE.
#' @examples
#' local({
#'     trace_func("sessionInfo", "util")
#'     on.exit(untrace_func("sessionInfo", "util"))
#'     sessionInfo()
#' })
#' @noRd
trace_func <- function(func, ns, exitmsg = "exit", silent = TRUE) {
  subobjs <- named(func, exitmsg)
  entryexpr <- substitute(asNamespace("toscutil")$log_func_entry(deparse(sys.call(-4))), subobjs)
  exitexpr <- substitute(asNamespace("toscutil")$log_func_exit(func, exitmsg = exitmsg), subobjs)
  if (is.character(ns)) ns <- asNamespace(ns)
  if (silent) {
    capture.output(type = "output",
      capture.output(type = "message",
        trace(func, entryexpr, exit = exitexpr, print = FALSE, where = ns)
      )
    )
  } else {
    trace(func, entryexpr, exit = exitexpr, print = FALSE, where = ns)
  }
  invisible(NULL)
}

log_func_entry <- function(func) {
  indent <- paste(rep("| ", trace_env$lvl), collapse = "")
  message(sprintf("%s [%s] %s%s", now_ms(usetz = FALSE), trace_env$lvl, indent, func))
  trace_env$lvl <- trace_env$lvl + 1
}

log_func_exit <- function(func, exitmsg = "exit") {
  trace_env$lvl <- trace_env$lvl - 1
  indent <- paste(rep("| ", trace_env$lvl), collapse = "")
  if (!is.null(exitmsg)) {
    message(sprintf("%s [%s] %s%s", now_ms(usetz = FALSE), trace_env$lvl, indent, exitmsg))
  }
}
