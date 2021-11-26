#' @title getpd
#' @description get project directory
#' @param root.files if any those files is found in a parent folder, that folder
#' is returned
#' @return project root directory as string
#' @export
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

