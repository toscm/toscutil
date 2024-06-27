#' @export
#' @title Foreground Color Codes
#' @description Provides ANSI escape codes as a named list for changing terminal text colors and style resetting. These codes can modify the foreground color and reset styles to defaults (incl. background color and text formatting).
#' @format A named list of ANSI escape codes for text coloring and style resetting in the terminal. Includes colors: GREY, RED, GREEN, YELLOW, BLUE, PURPLE, CYAN, WHITE, and RESET for default style restoration.
#' @keywords base
#' @examples
#' cat(fg$RED, "This text will be red.", fg$RESET, "\n")
#' cat(fg$GREEN, "This text will be green.", fg$RESET, "\n")
#' cat(fg$RESET, "Text back to default.", "\n")
fg <- list(
    GREY = "\033[1;30m",
    RED = "\033[1;31m",
    GREEN = "\033[1;32m",
    YELLOW = "\033[1;33m",
    BLUE = "\033[1;34m",
    PURPLE = "\033[1;35m",
    CYAN = "\033[1;36m",
    WHITE = "\033[1;37m",
    RESET = "\033[0m"
)

#' @export
#' @title Capture output from a command
#' @description Like classic [capture.output()], but with additional arguments `collapse` and `trim`.
#' @param collapse If `TRUE`, lines are collapsed into a single string. If `FALSE`, lines are returned as is. If any character, lines are collapsed using that character.
#' @param trim If `TRUE`, leading and trailing whitespace from each line is removed before the lines are collapsed and/or returned.
#' @param ... Arguments passed on to [capture.output()].
#' @return If `collapse` is `TRUE` or `"\n"`, a character vector of length 1. Else, a character vector of length `n`, where `n` corresponds to the number of lines outputted by the expression passed to [capture.output()].
#' @seealso [capture.output()]
#' @keywords base
#' @examples
#' x <- capture.output2(str(list(a = 1, b = 2, c = 1:3)))
#' cat2(x)
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
#' @description Same as [base::cat()] but with an additional argument `end`, which gets printed after all other elements. Inspired by pythons `print` command.
#' @param ... R objects (see 'Details' for the types of objects allowed).
#' @param sep a character vector of strings to append after each element.
#' @param end a string to print after all other elements.
#' @param file A [connection], or a character string naming the file to print to. If `""` (the default), `cat2` prints to the standard output connection, the console unless redirected by [sink].
#' @param append logical. Only used if the argument `file` is the name of file (and not a connection or `"|cmd"`). If `TRUE` output will be appended to `file`; otherwise, it will overwrite the contents of `file`.
#' @param fill a logical or (positive) numeric controlling how the output is broken into successive lines. If `FALSE` (default), only newlines created explicitly by `"\n"` are printed. Otherwise, the output is broken into lines with print width equal to the option `width` if `fill` is `TRUE`, or the value of `fill` if this is numeric. Linefeeds are only inserted *between* elements, strings wider than `fill` are not wrapped. Non-positive `fill` values are ignored, with a warning.
#' @param labels character vector of labels for the lines printed. Ignored if `fill` is `FALSE`.
#' @return No return value, called for side effects
#' @keywords base
#' @seealso [base::cat()]
#' @examples
#' x <- 1
#' cat("x:", x, "\n") # prints 'Number: 1 \n' (with a space between 1 and \n)
#' cat2("x:", x) # prints 'Number: 1\n'  (without space)
cat2 <- function(..., sep = " ", end = "\n", file = "", append = FALSE, fill = FALSE, labels = NULL) {
    x <- paste(..., sep = sep)
    y <- paste(x, end, sep = "")
    cat(y, file = file, append = append, fill = fill, labels = labels)
}

#' @export
#' @title Format and Print
#' @description Same as `cat(sprintf(fmt, ...))`
#' @param fmt A character vector of format strings, each of up to 8192 bytes.
#' @param ... Up to 100 values to be passed into `fmt`. Only logical, integer, real and character vectors are supported, but some coercion will be done: see the Details section of [base::sprintf()].
#' @param file A [connection], or a character string naming the file to print to. If `""` (the default), `cat2` prints to the standard output connection, the console unless redirected by [sink].
#' @param append logical. Only used if the argument `file` is the name of file (and not a connection or `"|cmd"`). If `TRUE` output will be appended to `file`; otherwise, it will overwrite the contents of `file`.
#' @param fill a logical or (positive) numeric controlling how the output is broken into successive lines. If `FALSE` (default), only newlines created explicitly by `"\n"` are printed. Otherwise, the output is broken into lines with print width equal to the option `width` if `fill` is `TRUE`, or the value of `fill` if this is numeric. Linefeeds are only inserted *between* elements, strings wider than `fill` are not wrapped. Non-positive `fill` values are ignored, with a warning.
#' @param labels character vector of labels for the lines printed. Ignored if `fill` is `FALSE`.
#' @return No return value, called for side effects
#' @keywords base
#' @examples catf("A%dB%sC", 2, "asdf") # prints "A2BasdfC"
catf <- function(fmt, ..., file = "", append = FALSE, fill = FALSE, labels = NULL) {
    x <- sprintf(fmt, ...)
    cat(x, file = file, append = append, fill = fill, labels = labels)
}

#' @export
#' @title logf function
#' @description Prints a formatted string with optional prefix and end string. The default prefix is a grey timestamp and the default end is a newline character, which is useful for logging messages. All defaults can be set globally using [options()]. For details see 'Examples'.
#' @param ... Arguments to be passed to sprintf for string formatting.
#' @param file A [file()] connection object or a string naming the file to print to. If `""` (the default), output is printed to STDOUT unless redirected by [sink()].
#' @param append Logical. If `TRUE`, the output is appended to the file. If `FALSE`, the file is overwritten.
#' @param prefix A function returning a string to be used as the prefix.
#' @param sep1 A string to be used as the separator between the prefix and the formatted string.
#' @param sep2 A string to be used as the separator between the formatted string and the end.
#' @param end A string to be used as the end of the message.
#' @return No return value. This function is called for its side effect of printing a message.
#' @keywords internal
#' @examples
#' logf("Hello, %s!", "world")
#' logf("Goodbye", prefix = function() "", sep1 = "", end = "!\n")
#' local({
#'      opts <- options(toscutil.logf.prefix = function() "LOG:", toscutil.logf.end = "\n")
#'      on.exit(options(opts))
#'      logf("Hello, %s!", "world")
#' })
logf <- function(fmt,
                 ...,
                 file = .Options$toscutil.logf.file %||% "",
                 append = .Options$toscutil.logf.append %||% FALSE,
                 prefix = .Options$toscutil.logf.prefix %||% function() now_ms(usetz = FALSE, color = fg$GREY),
                 sep1 = .Options$toscutil.logf.sep1 %||% " ",
                 sep2 = .Options$toscutil.logf.sep2 %||% "",
                 end = .Options$toscutil.logf.end %||% "\n") {
    cat(prefix(), sep1, sprintf(fmt, ...), sep2, end, sep = "")
}

#' @export
#' @title Return ASCII representation of an R object
#' @description Like classic [dput()], but instead of writing to stdout, the text representation is returned as string.
#' @param collapse Character to use for collapsing the lines.
#' @param trim If `TRUE`, leading and trailing whitespace from each line is cleared before the lines are collapsed and/or returned.
#' @param ... Arguments passed on to [dput()].
#' @return If `collapse == '\n'`, a character vector of length 1. Else, a character vector of length `n`, where `n` corresponds to the number of lines outputted by classic [dput()].
#' @seealso [dput()]
#' @keywords base
#' @examples
#' # Classic dput prints directly to stdout
#' x <- iris[1, ]
#' dput(x)
#'
#' # Traditional formatting using dput2
#' y <- dput2(x, collapse = "\n", trim = FALSE)
#' cat2(y)
#'
#' # Single line formatting
#' z <- dput2(x)
#' cat2(z)
dput2 <- function(..., collapse = " ", trim = TRUE) {
    x <- capture.output2(dput(...), collapse = collapse, trim = trim)
    return(x)
}


#' @export
#' @title Return help for topic
#' @description Returns the help text for the specified topic formatted either as plain text, html or latex.
#' @param topic character, the topic for which to return the help text. See argument `topic` of function [help()] for details.
#' @param format character, either `"text"`, `"html"` or `"latex"`
#' @param package character, the package for which to return the help text. This argument will be ignored if topic is specified. Package must be attached to the search list first, e.g. by calling `library(package)`.
#' @return The help text for the specified topic in the specified format as string.
#' @keywords base
#' @examples
#' htm <- help2("sum", "html")
#' txt <- help2(topic = "sum", format = "text")
#' cat2(txt)
help2 <- function(topic, format = "text", package = NULL) {
    rd <- sprintf("%s.Rd", topic)
    man_rd <- sprintf("man/%s", rd)
    if (is.null(package)) package <- strsplit(find(topic), ":")[[1]][2]
    rd_path <- system.file(man_rd, package = package, mustWork = FALSE) # exists when `package` is currently loaded via `devtools::load_all()`
    if (!file.exists(rd_path)) {
        rd_path <- tools::Rd_db(package)[[rd]] # generate the help file from the installed package
    }
    helptext <- capture.output(switch(format,
        text = tools::Rd2txt(rd_path),
        html = tools::Rd2HTML(rd_path),
        latex = tools::Rd2latex(rd_path)
    ))
    return(paste(helptext, collapse = "\n"))
}

#' @export
#' @title Create automatically named List
#' @description Like normal `list()`, except that unnamed elements are automatically named according to their symbol
#' @param ... List elements
#' @return Object of type `list` with names attribute set
#' @seealso [list()]
#' @keywords base
#' @examples
#' a <- 1:10
#' b <- "helloworld"
#' l1 <- list(a, b)
#' names(l1) <- c("a", "b")
#' l2 <- named(a, b)
#' stopifnot(identical(l1, l2))
#' l3 <- list(z = a, b = b)
#' l4 <- named(z = a, b)
#' stopifnot(identical(l3, l4))
named <- function(...) {
    .symbols <- as.character(substitute(list(...)))[-1]
    .elems <- list(...)
    .idx <- if (is.null(names(.elems))) {
        rep(TRUE, length(.elems))
    } else {
        names(.elems) == ""
    }
    names(.elems)[.idx] <- .symbols[.idx]
    .elems
}


#' @export
#' @title Return Normalized Path
#' @description Shortcut for `normalizePath(file.path(...), winslash = sep, mustWork = FALSE)`
#' @param ... Parts used to construct the path
#' @param sep Path separator to be used on Windows
#' @return Normalized path constructed from ...
#' @keywords base
#' @examples
#' norm_path("C:/Users/max", "a\\b", "c") # returns C:/Users/max/a/b/c
#' norm_path("a\\b", "c") # return <current-working-dir>/a/b/c
norm_path <- function(..., sep = "/") {
    normalizePath(file.path(...), winslash = sep, mustWork = FALSE)
}
