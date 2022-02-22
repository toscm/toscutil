#' @export
#' @name getfd
#' @title Get File Directory
#' @description Return full path to current file directory
#' @param on.error Expression to use if the current file directory cannot be
#' determined. In that case, `normalizePath(<on.error>, winslash)` is returned.
#' Can also be an expression like `stop("message")` to stop execution
#' (default).
#' @param winslash Path separator to use for windows
#' @return Current file directory as string
#' @examples \dontrun{getfd()}
#' getfd(on.error=getwd())
getfd <- function(
    on.error=stop(
        "No file sourced. Maybe you're in an interactive shell?",
        call.=FALSE
    ),
    winslash="/"
) {
    if (interactive() && sys.nframe() > 0 && "ofile" %in% ls(sys.frame(0))) {
        # probably started through `source` from interactive R session
        f <- sys.frame(1)$ofile
    } else {
        # probably started through `Rscript` from external shell
        args <- commandArgs()
        filearg_idx <- grepl("^--file=", args)
        if (any(filearg_idx)) {
            filearg <- args[filearg_idx][[1]]
            f <- strsplit(filearg, "--file=")[[1]][2]
        } else {
            return(normalizePath(on.error, winslash=winslash))
        }
    }
    return(normalizePath(dirname(f), winslash=winslash))
}
