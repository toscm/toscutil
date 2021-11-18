#' rmall
#'
#' @description Same as rm(list=ls())
#'
#' @return
#' @export
#'
#' @examples \donttest{rm_all()}
rm_all <- function() {
    e <- globalenv()
    rm(list = ls(envir = e), envir = e)
}
