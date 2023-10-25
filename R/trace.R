trace_env <- as.environment(list(
  lvl = 0,
  traced = list()
))

#' @export
#' @title Traces function calls from a package
#' @description This function traces all function calls from a package and writes them to `file` with timestamps and callstack depth.
#' @param pkg Package name to trace.
#' @param file File to write to.
#' @param max Maximum depth of callstack to print.
#' @param ign Character vector of function names to ignore.
#' @param ops Whether to trace operators defined by the package.
#' @return No return value, called for side effects
#' @details Some function define their own [on.exit()] handlers with option `add = FALSE`. For those functions, exit tracing is impossible (as described in [trace()]). For now those functions have to be detected and ignored manually by the user using argument `funign`.
#' @examples \dontrun{
#' trace_package("graphics", funign = "plot.default") # 1)
#' plot(1:10)
#' # 1) we ignore plot.default as it defines its own on.exit() handler without
#' add = TRUE, i.e. it's exit is untraceable
#' }
trace_package <- function(pkg,
                          file = stdout(),
                          max = Inf,
                          funign = character(),
                          opsign = TRUE,
                          dotign = TRUE,
                          silent = TRUE,
                          exitmsg = "exit") {
  # if (!any(grepl("inovatikr", search()))) {
  #   stop(sprintf("package '%s' is not attached.", pkg), call. = FALSE)
  # }
  # env <- rlang::pkg_env(pkg)
  ns <- asNamespace(pkg)
  nams <- ls(paste0("package:", pkg), all.names = TRUE) # 1)
  # Interesting: `names(ns)` is much longer than `ls("package:...")`. Not sure why, but for now I only use the names from `ls()` as `names(ns)` seems to contain a lot of super internal stuff.
  is_func <- sapply(nams, function(nam) is.function(ns[[nam]]))
  fullnams <-  sprintf("%s:::`%s`", pkg, nams)
  funcs <- nams[is_func]
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

untrace_package <- function(pkg) {
  # if (!any(grepl("inovatikr", search()))) {
  #   stop(sprintf("package '%s' is not attached.", pkg), call. = FALSE)
  # }
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

trace_func <- function(func, ns, exitmsg = TRUE, silent = TRUE) {
  args <- list(func = func, exitmsg = exitmsg)
  entryexpr <- substitute(toscutil:::log_func_entry(deparse(sys.call(-4))))
  exitexpr <- substitute(toscutil:::log_func_exit(func, exitmsg = exitmsg), args)
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

log_func_exit <- function(func, exitmsg = exitmsg) {
  trace_env$lvl <- trace_env$lvl - 1
  indent <- paste(rep("| ", trace_env$lvl), collapse = "")
  if (!is.null(exitmsg)) {
    message(sprintf("%s [%s] %s%s", now_ms(usetz = FALSE), trace_env$lvl, indent, exitmsg))
  }
}
