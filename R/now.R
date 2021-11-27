#' @title now
#' @description return current system time as string of the form YYYY-MM-DD  hh:mm:ss
#' @examples
#' now() # "2021-11-27, 19:19:31"
now <- function() format(Sys.time(), '%Y-%m-%d, %H:%M:%S')
