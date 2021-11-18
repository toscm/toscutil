#' getprd
#'
#' @description get project root directory
#'
#' @return project root directory as string
#' @export
getprd <- function() {
  owd <- ""
  wd <- normalizePath(getwd(), winslash = "/")
  while (basename(wd) != "geclavis" && wd != owd) {
    owd <- wd
    wd <- dirname(wd)
  }
  if (wd == owd) {
    stop("could not find project root folder")
  }
  wd
}
