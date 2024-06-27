#' @export
#' @title Get Current Date and Time as String
#' @description Returns the current system time as a string in the format `YYYY-MM-DD hh:mm:ss[.XX][ TZ]`. Square brackets indicate optional parts of the string, 'XX' stands for milliseconds and 'TZ' for 'Timezone'.
#' @param usetz Logical, indicating whether to include the timezone in the output.
#' @param color Optional color to use for the timestamp. This parameter is only effective if the output is directed to a terminal that supports color, which is checked via `isatty(stdout())`.
#' @param digits.sec Integer, the number of digits to include for seconds. Default is 0.
#' @return For `now`, the current system time as a string in the format `YYYY-MM-DD hh:mm:ss TZ`.
#' For `now_ms`, the format is `YYYY-MM-DD hh:mm:ss.XX TZ`, where XX represents milliseconds.
#' @seealso [Sys.time()], [format.POSIXct()]
#' @keywords time
#' @examples
#' now()                   # "2021-11-27 19:19:31 CEST"
#' now_ms()                # "2022-06-30 07:14:26.82 CEST"
#' now(usetz = FALSE)      # "2022-06-30 07:14:26.82"
#' now(color = fg$GREY)    # "\033[1;30m2024-06-27 14:41:20 CEST\033[0m"
now <- function(usetz = TRUE, color = NULL, digits.sec = 0) {
  if (digits.sec > 0) {
    opts <- options(digits.secs = digits.sec)
    on.exit(options(opts))
    timestamp <- format(Sys.time(), '%Y-%m-%d %H:%M:%OS', usetz = usetz)
  } else {
    timestamp <- format(Sys.time(), '%Y-%m-%d %H:%M:%S', usetz = TRUE)
  }
  if (!is.null(color) && isatty(stdout())) {
    timestamp <- sprintf("%s%s%s", color, timestamp, fg$RESET)
  }
  timestamp
}

#' @rdname now
#' @export
now_ms <- function(usetz = TRUE, color = NULL, digits.sec = 2) {
  now(usetz = usetz, color = color, digits.sec = digits.sec)
}
