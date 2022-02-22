#' @export
#' @name now
#' @title Get Current Date and Time as string
#' @description `now` returns current system time as string of the form
#' "YYYY-MM-DD hh:mm:ss".
#' @examples now() # "2021-11-27, 19:19:31"
#' @return `now` returns current system time as string of the form "YYYY-MM-DD
#' hh:mm:ss" (strictly speaking, the format as given to `format()` is
#' `%Y-%m-%d, %H:%M:%S`, for details see `[format.POSIXct()]`).
#' @seealso [Sys.time()], [format.POSIXct()]
now <- function() format(Sys.time(), '%Y-%m-%d, %H:%M:%S')
