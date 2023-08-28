#' @export
#' @name capture.output2
#' @title Capture output from a command
#' @description Like classic [capture.output()], but with additional arguments
#' `collapse` and `trim`.
#' @param collapse If `TRUE`, lines are collapsed into a single string. If
#' `FALSE`, lines are returned as is. If any character, lines are collapsed
#' using that character.
#' @param trim If `TRUE`, leading and trailing whitespace from each line is
#' removed before the lines are collapsed and/or returned.
#' @param ... Arguments passed on to [capture.output()].
#' @return If `collapse` is `TRUE` or `"\n"`, a character vector of length 1.
#' Else, a character vector of length `n`, where `n` corresponds to the number
#' of lines outputted by the expression passed to [capture.output()].
#' @examples
#' x <- capture.output2(str(list(a=1, b=2, c=1:3)))
#' cat2(x)
#' @keywords base
#' @seealso [capture.output()]
capture.output2 <- function(..., collapse = "\n", trim = FALSE) {
  x <- utils::capture.output(...)
  if (trim) {
    x <- sapply(x, trimws)
  }
  if (!(identical(collapse, FALSE))) {
    x <- paste(x, collapse = collapse)
  }
  return(x)
}


#' @export
#' @title Concatenate and Print
#' @keywords base
#' @description Same as `cat` but with an additional argument `end`,
#' which gets printed after all other elements. Inspired by pythons `print`
#' command.
#' @param ... objects passed on to \link[base]{cat}
#' @param sep a character vector of strings to append after each element
#' @param end a string to print after all other elements
#' @param file passed on to [base::cat()]
#' @param append passed on to [base::cat()]
#' @param fill passed on to [base::cat()]
#' @param labels passed on to [base::cat()]
#' @return No return value, called for side effects
#' @examples
#' x <- 1
#' cat("x:", x, "\n") # prints 'Number: 1 \n' (with a space between 1 and \n)
#' cat2("x:", x) # prints 'Number: 1\n'  (without space)
cat2 <- function(..., sep = " ", end = "\n", file = "", append = FALSE, fill = FALSE, labels = NULL) {
  cat(..., file = file, sep = sep, end = end, append = append, fill = fill, labels = labels)
  cat(end, file = file, sep = sep, end = end, append = append, fill = fill, labels = labels)
}


#' @export
#' @name catf
#' @title Format and Print
#' @description Same as `cat2(sprintf(fmt, ...))`
#' @param fmt passed on to [base::sprintf()]
#' @param ... passed on to [base::sprintf()]
#' @param end passed on to [cat2()]
#' @param file passed on to [cat2()] (which passes it on to [base::cat()])
#' @param sep passed on to [cat2()] (which passes it on to [base::cat()])
#' @param fill passed on to [cat2()] (which passes it on to [base::cat()])
#' @param labels passed on to [cat2()] (which passes it on to [base::cat()])
#' @param append passed on to [cat2()] (which passes it on to [base::cat()])
#' @return No return value, called for side effects
#' @examples catf("A%dB%sC", 2, "asdf") # prints "A2BasdfC"
#' @keywords base
catf <- function(fmt, ..., end = "", file = "", sep = " ", fill = FALSE, labels = NULL, append = FALSE) {
  cat2(sprintf(fmt, ...), end = end, file = file, sep = sep, fill = fill, labels = labels, append = append)
}


#' @export
#' @name dput2
#' @title Return ASCII representation of an R object
#' @description Like classic [dput()], but instead of writing to stdout, the
#' text representation is returned as string.
#' @param collapse Character to use for collapsing the lines.
#' @param trim If `TRUE`, leading and trailing whitespace from each line is
#' cleared before the lines are collapsed and/or returned.
#' @param ... Arguments passed on to [dput()].
#' @return If `collapse == '\n'`, a character vector of length 1. Else, a
#' character vector of length `n`, where `n` corresponds to the number of lines
#' outputted by classic [dput()].
#' @examples
#' # Classic dput prints directly to stdout
#' x <- iris[1,]
#' dput(x)
#'
#' # Traditional formatting using dput2
#' y <- dput2(x, collapse = "\n", trim = FALSE)
#' cat2(y)
#'
#' # Single line formatting
#' z <- dput2(x)
#' cat2(z)
#' @keywords base
#' @seealso [dput()]
dput2 <- function(..., collapse = " ", trim = TRUE) {
  x <- capture.output2(dput(...), collapse = collapse, trim = trim)
  return(x)
}


#' @export
#' @name help2
#' @title Return help for topic
#' @description This function returns the help text for the specified topic
#' formatted either as plain text, html or latex.
#' @param topic character, the topic for which to return the help text. See
#' argument `topic` of function [help()] for details.
#' @param format character, either `"text"`, `"html"` or `"latex"`
#' @param package character, the package for which to return the help text.
#' This argument will be ignored if topic is specified. Package must be
#' attached to the search list first, e.g. by calling `library(package)`.
#' @examples
#' htm <- help2("sum", "html")
#' txt <- help2(topic = "sum", format = "text")
#' cat2(txt)
#' @details This function was copied in part from:
#' <https://www.r-bloggers.com/2013/06/printing-r-help-files-in-the-console-or-in-knitr-documents/>
#' @keywords base
help2 <- function(topic,
                  format = c("text", "html", "latex"),
                  package = NULL) {
  format <- match.arg(format)
  if (missing(topic)) {
    symbols <- ls(paste0("package:", package))
    helptxts <- sapply(symbols, help2, format = format)
    names(helptxts) <- symbols
    return(helptxts)
  }
  helpfile <- tryCatch(.getHelpFile(utils::help(topic)), error = \(e) NULL)
  if (is.null(helpfile)) {
    return("No help file found")
  } else {
    return(
      paste(
        utils::capture.output(
          switch(format,
            text = tools::Rd2txt(helpfile),
            html = tools::Rd2HTML(helpfile),
            latex = tools::Rd2latex(helpfile)
          )
        ),
        collapse = "\n"
      )
    )
  }
}


#' @export
#' @name named
#' @title Create automatically named List
#' @description Like normal `list()`, except that unnamed elements are
#' automatically named according to their symbol
#' @param ... List elements
#' @return Object of type `list` with names attribute set
#' @examples
#' a <- 1:10;
#' b <- "helloworld"
#' l1 <- list(a, b)
#' names(l1) <- c("a", "b")
#' l2 <- named(a, b)
#' identical(l1, l2)
#' l3 <- list(z=a, b=b)
#' l4 <- named(z=a, b)
#' identical(l3, l4)
#' @keywords base
#' @seealso [list()]
named <- function(...){
    .elems <- list(...)
    .symbols <- as.character(substitute(list(...)))[-1]
    .idx <- names(.elems) == ""
    names(.elems)[.idx] <- .symbols[.idx]
    .elems
}


#' @export
#' @keywords base
#' @name norm_path
#' @title Return Normalized Path
#' @description Shortcut for
#' `normalizePath(file.path(...), winslash = sep, mustWork = FALSE)`
#' @param ... Parts used to construct the path
#' @param sep Path separator to be used on Windows
#' @return Normalized path constructed from ...
#' @examples
#' norm_path("C:/Users/max", "a\\b", "c") # returns C:/Users/max/a/b/c
#' norm_path("a\\b", "c") # return <current-working-dir>/a/b/c
norm_path <- function(..., sep="/") {
	normalizePath(file.path(...), winslash=sep, mustWork=FALSE)
}


##### Helpers ##################################################################

# Original version copied from `utils:::.getHelpFile`, which can't be used
# because it would cause the following R CMD check warning:
# Unexported object imported by a ':::' call: 'utils:::.getHelpFile'. Used by
# `help2`.
.getHelpFile <- function(file) {
  path <- dirname(file)
  dirpath <- dirname(path)
  if (!file.exists(dirpath)) {
    stop(gettextf("invalid %s argument", sQuote("file")),
      domain = NA
    )
  }
  pkgname <- basename(dirpath)
  RdDB <- file.path(path, pkgname)
  if (!file.exists(paste0(RdDB, ".rdx"))) {
    stop(gettextf(
      "package %s exists but was not installed under R >= 2.10.0 so help cannot be accessed",
      sQuote(pkgname)
    ), domain = NA)
  }
  fetchRdDB(RdDB, basename(file))
}

# Original version copied from `tools:::fetchRdDB`. Used by `help2`.
fetchRdDB <- function(filebase, key = NULL) {
  fun <- function(db) {
    vals <- db$vals
    vars <- db$vars
    datafile <- db$datafile
    compressed <- db$compressed
    envhook <- db$envhook
    fetch <- function(key) {
      lazyLoadDBfetch(
        vals[key][[1L]],
        datafile, compressed, envhook
      )
    }
    if (length(key)) {
      if (!key %in% vars) {
        stop(gettextf(
          "No help on %s found in RdDB %s",
          sQuote(key), sQuote(filebase)
        ), domain = NA)
      }
      fetch(key)
    } else {
      res <- lapply(vars, fetch)
      names(res) <- vars
      res
    }
  }
  res <- lazyLoadDBexec(filebase, fun)
  if (length(key)) {
    res
  } else {
    invisible(res)
  }
}
