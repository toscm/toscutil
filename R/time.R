#' @export
#' @name now_ms
#' @title Get Current Date and Time as string
#' @description `now_ms` returns current system time as string of the form
#' "YYYY-MM-DD hh:mm:ss.XX TZ", where XX means "milliseconds" and TZ means
#' "timezone".
#' @examples now_ms() # something like "2022-06-30, 07:14:26.82 CEST"
#' @return Current system time as string of the form "YYYY-MM-DD hh:mm:ss.XX
#' TZ", where XX means "milliseconds" and TZ means "timezone".
#' @keywords time
#' @seealso [now()], [Sys.time()], [format.POSIXct()]
now_ms <- function() {
  opts <- options(digits.secs = 2)
  on.exit(options(opts))
  format(Sys.time(), '%Y-%m-%d %H:%M:%OS', usetz = TRUE)
}


#' @export
#' @name now
#' @title Get Current Date and Time as string
#' @description `now` returns current system time as string of the form
#' `YYYY-MM-DD hh:mm:ss TZ`, where TZ means "timezone".
#' @examples now() # "2021-11-27 19:19:31 CEST"
#' @return `now` returns current system time as string of the form `YYYY-MM-DD
#' hh:mm:ss TZ`, where TZ means "timezone" (strictly speaking, the format as
#' given to `format()` is `%Y-%m-%d %H:%M:%S`, for details see
#' `[format.POSIXct()]`).
#' @keywords time
#' @seealso [now_ms()], [Sys.time()], [format.POSIXct()]
now <- function() {
  format(Sys.time(), '%Y-%m-%d %H:%M:%S', usetz = TRUE)
}

