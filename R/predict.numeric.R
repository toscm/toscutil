predict.numeric <- function(b, X, fm=NULL) {
    # browser()
    if (class(b) == "matrix" || class(b) == "array") {
        if (ncol(b) == 1) {
            b2 <- b[,1] # preserved colnames as names
        } else if (nrow(b) == 1) {
            b2 <- b[1, ] # preserved rownames as names
        } else {
            stop(glue("`m` should be 1D but has dim {dim(m)}"))
        }
    } else {
        b2 <- b
    }
    if ("Intercept" %in% names(b2)) {
        b3 <- b2[names(b2) != "Intercept"]
        intercept <- b2["Intercept"]
    } else {
        b3 <- b2
        intercept <- 0
    }
    if (!is.numeric(b3)) stop(glue("b3 must be numeric but is {typeof(b3)}"))
    tryCatch(
        expr = { scores <- as.numeric(as.matrix(X[, names(b3)]) %*% b3) + intercept },
        error = function(cond) {
            stop(glue("names(b3) must be in colnames(X), but the following are not: ",
                      "{names(b3)[names(b3) %notin% colnames(X)]}"))
        }
    )
    names(scores) <- rownames(X)
    return(scores)
}
