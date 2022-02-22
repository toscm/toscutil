#' @export
#' @name sys.exit
#' @title Terminate a non-interactive R Session
#' @description Similar to [Python's
#' sys.exit](https://docs.python.org/3/library/sys.html?highlight=exit#sys.exit).
#' If used interactively, code execution is stopped with an error message,
#' giving the provided status code. If used non-interactively (e.g. through
#' Rscript), code execution is stopped silently and the process exits with the
#' provided status code.
#' @param status exitcode for R process
#' @return No return value, called for side effects
#' @examples \dontrun{
#' if (!file.exists("some.file")) {
#'   cat("Error: some.file does not exist.\n", file=stderr())
#'   sys.exit(1)
#' } else if (Sys.getenv("IMPORTANT_ENV")=="") {
#'   cat("Error: IMPORTANT_ENV not set.\n", file=stderr())
#'   sys.exit(2)
#' } else {
#'   cat("Everything good. Starting calculations...")
#'   # ...
#'   cat("Finished with success!")
#'   sys.exit(0)
#' }
#' }
sys.exit <- function(status=0) {
  if (interactive())
    stop(paste0("sys.exit(", status, ")"), call. = FALSE)
  else
    quit(status=status, save="no")
}
