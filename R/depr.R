deprecation_warning <- function(end_of_life = "31.12.2023") {
  warning(
    "This function is deprecated and should no longer be used. The function ",
    "is guaranteed to be available as part of the package until ",
    end_of_life, " but might be removed at any later timepoint."
  )
}

#' @export
#' @keywords depr
#' @name cat0
#' @title Concatenate and Print
#' @description Same as `cat` but with an additional argument `end`,
#' which gets printed after all other elements. Inspired by pythons `print`
#' command.
#'
#' Warning: this function is deprecated and should no longer be used. The
#' function is guaranteed to be available as part of the package until the end
#' of 2023 but might removed at any time after 31.12.2023.
#' @param ... objects passed on to \link[base]{cat}
#' @param sep a character vector of strings to append after each element
#' @param end a string to print after all other elements
#' @return No return value, called for side effects
#' @examples cat0("hello", "world") # prints "helloworld" (without newline)
cat0 <- function(..., sep = "", end = "") {
  deprecation_warning()
  cat2(..., sep = sep, end = end)
}

#' @export
#' @keywords depr
#' @title Concatenate and Print
#' @description Same as `cat` but with an additional argument `end`,
#' which gets printed after all other elements. Inspired by pythons `print`
#' command.
#'
#' Warning: this function is deprecated and should no longer be used. The
#' function is guaranteed to be available as part of the package until the end
#' of 2023 but might removed at any time after 31.12.2023.
#' @param ... objects passed on to \link[base]{cat}
#' @param sep a character vector of strings to append after each element
#' @param end a string to print after all other elements
#' @return No return value, called for side effects
#' @examples catn("hello", "world") # prints "hello world\n"
catn <- function(..., sep = " ", end = "\n") {
  deprecation_warning()
  cat2(..., sep = sep, end = end)
}

#' @export
#' @keywords depr
#' @title Concatenate and Print
#' @description Same as `cat` but with an additional argument `end`,
#' which gets printed after all other elements. Inspired by pythons `print`
#' command.
#'
#' Warning: this function is deprecated and should no longer be used. The
#' function is guaranteed to be available as part of the package until the end
#' of 2023 but might removed at any time after 31.12.2023.
#' @param ... objects passed on to \link[base]{cat}
#' @param sep a character vector of strings to append after each element
#' @param end a string to print after all other elements
#' @return No return value, called for side effects
#' @examples cat0n("hello", "world") # prints "helloworld\n"
cat0n <- function(..., sep = "", end = "\n") {
  deprecation_warning()
  cat2(..., sep = sep, end = end)
}

#' @export
#' @keywords depr
#' @title Concatenate and Print
#' @description Same as `cat` but with an additional argument `end`,
#' which gets printed after all other elements. Inspired by pythons `print`
#' command.
#'
#' Warning: this function is deprecated and should no longer be used. The
#' function is guaranteed to be available as part of the package until the end
#' of 2023 but might removed at any time after 31.12.2023.
#' @param ... objects passed on to \link[base]{cat}
#' @param sep a character vector of strings to append after each element
#' @param end a string to print after all other elements
#' @return No return value, called for side effects
#' @examples catsn("hello", "world") # prints "hello world\n"
catsn <- function(..., sep = " ", end = "\n") {
  deprecation_warning()
  cat2(..., sep = sep, end = end)
}

#' @export
#' @keywords depr
#' @title Concatenate and Print
#' @description Same as `cat` but with an additional argument `end`,
#' which gets printed after all other elements. Inspired by pythons `print`
#' command.
#'
#' Warning: this function is deprecated and should no longer be used. The
#' function is guaranteed to be available as part of the package until the end
#' of 2023 but might removed at any time after 31.12.2023.
#' @param ... objects passed on to \link[base]{cat}
#' @param sep a character vector of strings to append after each element
#' @param end a string to print after all other elements
#' @return No return value, called for side effects
#' @examples catnn("hello", "world") # prints "hello\nworld\n"
catnn <- function(..., sep = "\n", end = "\n") {
  deprecation_warning()
  cat2(..., sep = sep, end = end)
}


#' @export
#' @keywords depr
#' @title Format and Print
#' @description Same as `cat2(sprintf(fmt, ...))`
#'
#' Warning: this function is deprecated and should no longer be used. The
#' function is guaranteed to be available as part of the package until the end
#' of 2023 but might removed at any time after 31.12.2023.
#' @param fmt passed on to [base::sprintf()]
#' @param ... passed on to [base::sprintf()]
#' @param end passed on to [cat2()]
#' @param file passed on to [cat2()] (which passes it on to [base::cat()])
#' @param sep passed on to [cat2()] (which passes it on to [base::cat()])
#' @param fill passed on to [cat2()] (which passes it on to [base::cat()])
#' @param labels passed on to [cat2()] (which passes it on to [base::cat()])
#' @param append passed on to [cat2()] (which passes it on to [base::cat()])
#' @return No return value, called for side effects
#' @examples catfn("A%dB%sC", 2, "asdf") # prints "A2BasdfC\n"
catfn <- function(fmt, ..., end = "\n", file = "", sep = " ", fill = FALSE, labels = NULL, append = FALSE) {
  deprecation_warning()
  cat2(sprintf(fmt, ...), end = end, file = file, sep = sep, fill = fill, labels = labels, append = append)
}
