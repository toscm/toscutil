#' @export
#' @name getpd
#' @title Get Project Directory
#' @description Find the project root directory by traversing the current
#' working directory filepath upwards until a given set of files is found.
#' @param root.files if any of these files is found in a parent folder, the
#' path to that folder is returned
#' @return `getpd` returns the project root directory as string
getpd <- function(root.files=c(".git", "DESCRIPTION", "NAMESPACE")) {
  owd <- ""
  wd <- normalizePath(getwd(), winslash = "/")
  while (!any(dir(wd) %in% root.files) && wd != owd) {
    owd <- wd
    wd <- dirname(wd)
  }
  if (wd == owd) {
    stop("could not find project root folder")
  }
  wd
}

