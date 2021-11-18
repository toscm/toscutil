#' is.none
#'
#' TRUE for FALSE, 0, NULL, NA, empty lists and empty string
#'
#' @param x object to test
#'
#' @return TRUE or FALSE
#' @examples
#' is.none(FALSE) # TRUE
#' is.none(0) # TRUE
#' is.none(NA) # TRUE
#' is.none(list()) # TRUE
#' is.none("") # TRUE
#' is.none(1) # FALSE
#' @export
is.none <- function(x) {
  # use || instead of any for lazy evaluation
  if (
    (is.logical(x) && length(x) == 1 && x == FALSE) ||
    (is.numeric(x) && length(x) == 1 && x == 0) ||
    is.null(x) ||
    ((typeof(x) == "character") && (length(x) == 1) && (x == "")) ||
    ((typeof(x) == "list") && (length(x) == 0)) ||
    is.na(x)
  ) {
    TRUE
  } else {
    FALSE
  }
}
