#' @export
#' @name rm_all
#' @title Remove all objects from global environment
#' @description Same as rm(list=ls())
#' @examples \dontrun{rm_all()}
rm_all <- function() {
    e <- globalenv()
    rm(list=ls(envir=e), envir=e)
}
