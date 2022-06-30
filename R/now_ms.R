#' @export
#' @name now_ms
#' @title Get Current Date and Time as string
#' @description `now_ms` returns current system time as string of the form
#' "YYYY-MM-DD hh:mm:ss.XX TZ", where XX means "milliseconds" and TZ means
#' "timezone".
#' @examples now() # something like "2022-06-30, 07:14:26.82 CEST"
#' @return Current system time as string of the form "YYYY-MM-DD hh:mm:ss.XX
#' TZ", where XX means "milliseconds" and TZ means "timezone".
#' @seealso [now()], [Sys.time()], [format.POSIXct()]
now_ms <- function() {
  opts <- options(digits.secs = 2)
  on.exit(options(opts))
  format(Sys.time(), '%Y-%m-%d %H:%M:%OS', usetz = TRUE)
}
