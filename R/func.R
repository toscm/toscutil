#' @export
#' @title Get Name of Calling Function
#' @description  Returns the name of a calling function as string, i.e. if
#' function `g` calls function `f` and function `f` calls
#' `caller(2)`, then string `"g"` is returned.
#' @param n How many frames to go up in the call stack
#' @return Name of the calling function
#' @details Be careful when using `caller(n)` as input to other functions. Due
#' to R's non-standard-evaluation (NES) mechanism it is possible that the
#' function is not executed directly by that function but instead passed on to
#' other functions, i.e. the correct number of frames to go up cannot be
#' predicted a priori. Solutions are to evaluate the function first, store the
#' result in a variable and then pass the variable to the function or to just
#' try out the required number of frames to go up in an interactive session.
#' For further examples see section Examples.
#' @examples
#' # Here we want to return a list of all variables created inside a function
#' f <- function(a = 1, b = 2) {
#'   x <- 3
#'   y <- 4
#'   return(locals(without = formalArgs(caller(4))))
#'   # We need to go 4 frames up, to catch the formalArgs of `f`, because the
#'   # `caller(4)` argument is not evaluated directly be `formalArgs`.
#' }
#' f() # returns either list(x = 3, y = 4) or list(y = 4, x = 3)
#'
#' # The same result could have been achieved as follows
#' g <- function(a = 1, b = 2) {
#'   x <- 3
#'   y <- 4
#'   func <- caller(1)
#'   return(locals(without = c("func", formalArgs(func))))
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
#' @description Returns the function environment as list. Raises an error when
#' called outside a function. By default, objects specified as arguments are
#' removed from the environment.
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
#' @title Get docstring for a Function
#' @description The [roxygen2](https://roxygen2.r-lib.org/) package makes it
#' possible to write documentation for R functions directly above the
#' corresponding function. This function can be used to retrieve the full
#' documentation string (docstring).
#' @param content R code as string.
#' @param func Name of function to get docstring for.
#' @param collapse Whether to collapse all docstring into a single string.
#' @param template String to return in case no docstring could be found.
#' @return A character vector of length 1 containing either the docstring or the
#' empty string (in case no documentation could be detected).
#' @examples
#' uri <- system.file("testfiles/funcs.R", package = "toscutil")
#' content <- readLines(uri)
#' func <- "f2"
#' get_docstring(content, func)
#' get_docstring(content, func, collapse = TRUE)
#' @keywords func
get_docstring <- function(content,
                          func,
                          collapse = TRUE,
                          template = DOCSTRING_TEMPLATE) {
  pattern <- paste0(func, "\\s*(<-|=)\\s*function")
  func_lines <- grep(pattern, content)
  func_line <- func_lines[length(func_lines)]
  start_line <- func_line
  while (start_line >= 2 && grepl("^\\s*#'", content[[start_line - 1]])) {
    start_line <- start_line - 1
  }
  docstring <- template
  if (start_line < func_line) {
    docstring <- content[start_line:(func_line - 1)]
    if (collapse) {
      docstring <- paste(docstring, collapse = "\n")
      docstring <- paste0(docstring, "\n")
    }
  }
  return(docstring)
}


#' @export
#' @title Get formals of a Function
#' @description Returns the arguments of a function from a valid R file.
#' @param uri Path to R file.
#' @param content R code as string.
#' @param func Function name. If a function is defined multiple times inside the
#' provided file, only the last occurence will be considered.
#' @return A named character vector as returned by [formals()].
#' @examples
#' uri <- system.file("testfiles/funcs.R", package = "toscutil")
#' content <- readLines(uri)
#' func <- "f2"
#' get_formals(uri, content, func)
#' @keywords func
get_formals <- function(uri, content, func) {
  unused <- languageserver::run # define to avoid R CMD check warning
  env <- loadNamespace("languageserver")
  pobj <- env$parse_document(uri, content)
  # We use this loadNamespace construct instead of calling the function
  # directly, because R CMD check throws warnings when using unexported
  # functions from other packages. However, in this case, we don't really have
  # a choice, unless we want to redefine approx. 20 functions from
  # languageserver inside this package.
  formals <- if ("formals" %in% names(pobj)) {
    pobj$formals[[func]]
  } else if ("functions" %in% names(pobj)) {
    formals(pobj$functions[[func]])
  } else {
    stop(paste(
      "Could not find function definition.",
      "This might be caused by an update of the languageserver package.",
      "Please create an issue at https://github.com/toscm/toscutil/issues.",
      sep = "\n"
    ))
  }
  return(formals)
}


#' @export
#' @title Get specified Environment as List
#' @description Return all symbols in the specified environment as list.
#' @param without Character vector. Symbols from current env to exclude.
#' @param env Environment to use. Defaults to the environment from which
#' `locals` is called.
#' @return Specified environment as list (without the mentioned symbols).
#' @keywords func
locals <- function(without = c(), env = parent.frame()) {
  x <- as.list(env)
  x[without] <- NULL
  return(x)
}


#' @export
#' @title Split a docstring into a Head, Param and Tail Part
#' @description Split a docstring into a head, param and tail part.
#' @param docstring Docstring of a R function as string, i.e. as character
#' vector of length 1.
#' @return List with 3 elements: head, param and tail.
#' @examples
#' uri <- system.file("testfiles/funcs.R", package = "toscutil")
#' func <- "f4"
#' content <- readLines(uri)
#' docstring <- get_docstring(content, func)
#' split_docstring(docstring)
#' @keywords func
split_docstring <- function(docstring) {
  # Split docstring into substrings after each tag.
  # Implementation detail: We add an additional word at the end of the
  # docstring to ensure we get n+1 substrings for n tags. E.g. this docstring:
  # "#' @title Sum of Elements\n#' @param ... Summands\n#' @export"
  # should return these substrings
  # c("", "Sum of Elements", "... Summands", "")
  # Adding a leading word is not necessary, as this strsplit handles this
  # correctly by default.
  pattern <- "#'\\s+@\\w+"
  word <- "REMOVEME"
  docstring <- paste(docstring, word)
  substrings <- strsplit(docstring, pattern, perl = TRUE)[[1]]
  n <- length(substrings)
  w <- nchar(substrings[n]) - nchar(word) - 1
  substrings[n] <- substr(substrings[n], 1, w)
  tags <- regmatches(docstring, gregexpr(pattern, docstring, perl = TRUE))[[1]]
  tags <- c("", tags)
  matches <- regmatches(tags, gregexpr("@\\S+", tags))
  tag_names <- sapply(matches, function(match) {
    if (length(match) == 0) "header" else gsub("@", "", match)
  })
  # Extract params names for all substrings corresponding to a param tag. Then
  # group substrings together into symbols `head`, `param` and `tail` as
  # follows: Every param substring goes into `param.` Everything before the
  # first param substring into `head.` Everythin else into `tail`. Example:
  # #' @title The Title --> head
  # #' @description Abc --> head
  # #' @param a DescA   --> param
  # #' @param b DescB   --> param
  # #' @export          --> tail
  # #' @param c DescC   --> param
  # #' @details blablaa --> tail
  param_names <- sapply(strsplit(substrings, "\\s+"), function(words) words[2])
  param_names[tag_names != "param"] <- NA
  ids <- seq_along(tags)
  ids_params <- which(tag_names == "param")
  ids_head <- ids[ids < min(ids_params, length(tags) + 1)]
  ids_tail <- ids[!ids %in% c(ids_head, ids_params)]
  head <- paste0(tags[ids_head], substrings[ids_head])
  param <- paste0(tags[ids_params], substrings[ids_params])
  tail <- paste0(tags[ids_tail], substrings[ids_tail])
  names(head) <- tag_names[ids_head]
  names(param) <- param_names[ids_params]
  names(tail) <- tag_names[ids_tail]
  list(head = head, param = param, tail = tail)
}


#' @export
#' @name sys.exit
#' @title Terminate a non-interactive R Session
#' @description Similar to python's
#' [sys.exit](https://docs.python.org/3/library/sys.html?highlight=exit#sys.exit).
#' If used interactively, code execution is stopped with an error message,
#' giving the provided status code. If used non-interactively (e.g. through
#' Rscript), code execution is stopped silently and the process exits with the
#' provided status code.
#' @param status exitcode for R process
#' @return No return value, called for side effects
#' @examples \dontrun{
#' if (!file.exists("some.file")) {
#'   cat("Error: some.file does not exist.\n", file = stderr())
#'   sys.exit(1)
#' } else if (Sys.getenv("IMPORTANT_ENV") == "") {
#'   cat("Error: IMPORTANT_ENV not set.\n", file = stderr())
#'   sys.exit(2)
#' } else {
#'   cat("Everything good. Starting calculations...")
#'   # ...
#'   cat("Finished with success!")
#'   sys.exit(0)
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


#' @export
#' @title Update docstring for a Function
#' @description The [roxygen2](https://roxygen2.r-lib.org/) package makes it
#' possible to write documentation for R functions directly above the
#' corresponding function. This function can be used to update the parameter
#' list of a documentation string (docstring) of a valid function of a valid R
#' file. The update is done by comparing the currently listed parameters with
#' the actual function parameters. Outdated parameters are removed and missing
#' parameters are added to the docstring.
#' @param uri Path to R file.
#' @param func Function name. If a function is defined multiple times inside the
#' provided file, only the last occurence will be considered.
#' @param content R code as string. If provided, uri is ignored.
#' @return A character vector of length 1 containing the updated docstring.
#' @examples
#' uri <- system.file("testfiles/funcs.R", package = "toscutil")
#' func <- "f4"
#' update_docstring(uri, func)
#' @keywords func
update_docstring <- function(uri, func, content = NULL) {
  content <- readLines(uri)
  param_names <- names(get_formals(uri, content, func))
  docstring <- get_docstring(content, func, collapse = TRUE)
  dfs <- split_docstring(docstring)
  # list(head = c(header = "",
  #               title = "#' @title The Title\n",
  #               description = "#' @description The description.\n"),
  #      param = c(a = "#' @param a Already documented\n",
  #                b = "#' @param b TODO\n",
  #                z = "#' @param z Bla\n"),
  #      tail = c(details = "#' @details Bla Bla\n",
  #               export = "#' @export"))
  for (param_name in param_names) {
    if (!(param_name %in% names(dfs$param))) {
      dfs$param[[param_name]] <- paste("#' @param", param_name, "TODO\n")
    }
  }
  dfs$param <- dfs$param[param_names]
  paste(c(dfs$head, dfs$param, dfs$tail), collapse = "")
}


#' @export
#' @title Docstring Template
#' @description A minimal docstring template
#' @format A single string, i.e. a character vector of length 1.
#' @keywords func
#' @examples DOCSTRING_TEMPLATE
DOCSTRING_TEMPLATE <- paste0(
  "#' @title TODO (e.g. 'Sum of Vector Elements')\n",
  "#' @description TODO (e.g. 'sum returns the sum of all the values present in its arguments.'\n")
