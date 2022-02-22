#' @export
#' @name rm_all
#' @title Remove all objects from global environment
#' @description Same as rm(list=ls())
#' @examples \dontrun{rm_all()}
#' @return No return value, called for side effects
rm_all <- function() {
    e <- globalenv()
    rm(list=ls(envir=e), envir=e)
}
