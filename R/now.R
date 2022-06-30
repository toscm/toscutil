#' @export
#' @name now
#' @title Get Current Date and Time as string
#' @description `now` returns current system time as string of the form
#' "YYYY-MM-DD hh:mm:ss TZ", where TZ means "timezone".
#' @examples now() # "2021-11-27 19:19:31 CEST"
#' @return `now` returns current system time as string of the form "YYYY-MM-DD
#' hh:mm:ss TZ", where TZ means "timezone" (strictly speaking, the format as
#' given to `format()` is `%Y-%m-%d %H:%M:%S`, for details see
#' `[format.POSIXct()]`).
#' @seealso [now_ms()], [Sys.time()], [format.POSIXct()]
now <- function() format(Sys.time(), '%Y-%m-%d %H:%M:%S', usetz = TRUE)
