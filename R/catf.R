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
#' @rdname catf
#' @aliases catfn
catf <- function(fmt, ..., end="", file="", sep=" ", fill=FALSE, labels=NULL, append=FALSE) {
	cat2(sprintf(fmt, ...), end=end, file=file, sep=sep, fill=fill, labels=labels, append=append)
}

#' @export
#' @examples catfn("A%dB%sC", 2, "asdf") # prints "A2BasdfC\n"
#' @rdname catf
catfn <- function(fmt, ..., end="\n", file="", sep=" ", fill=FALSE, labels=NULL, append=FALSE) {
	cat2(sprintf(fmt, ...), end=end, file=file, sep=sep, fill=fill, labels=labels, append=append)
}