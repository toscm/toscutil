#' @export
#' @name help2
#' @title Return help for topic
#' @description This function returns the help text for the specified topic
#' formatted as plain text, html or latex.
#' @param topic character, topic for which to return the help text
#' @param format character, either "text", "html" or "latex"
#' @param package character, package for which to return the help text. This
#' argument will be ignored if topic is specified. Package must be attached
#' to the search list first, e.g. by calling `library(package)`.
#' @examples
#' help2("sum", "html")
#' help2(topic = "sum", format = "text")
#' \dontrun{help2(package = "utils", format = "html")}
#' @details This function was copied in part from:
#' <https://www.r-bloggers.com/2013/06/printing-r-help-files-in-the-console-or-in-knitr-documents/>
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

# Original version copied from `utils:::.getHelpFile`, which can't be used
# because it would cause the following R CMD check warning:
# Unexported object imported by a ':::' call: 'utils:::.getHelpFile'
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

# Original version copied from `tools:::fetchRdDB`
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
