#' @title getfd
#' @description Return normed path to current file directory
#' @return Current file directory as string
#' @examples getfd()
#' @export
getfd <- function() {
    if (interactive() && sys.nframe() > 0 && "ofile" %in% ls(sys.frame(0))) {
        # probably started through `source` from interactive R session
        f <- sys.frame(1)$ofile
    } else {
        # probably started through `Rscript` from external shell
        args <- commandArgs()
        filearg_idx <- grepl("^--file=", args)
        if (any(filearg_idx)) {
            filearg <- args[][[1]]
            f <- strsplit(filearg, "--file=")[[1]][2]
        } else {
            stop("No file sourced. Maybe you're in an interactive shell?",
                 call.=F)
        }
    }
    return(normalizePath(dirname(f), winslash = "/"))
}
