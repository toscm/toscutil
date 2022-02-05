predict.numeric <- function(b, X, fm=NULL) {
    # Convert b to named vector b2
    if (class(b) == "matrix" || class(b) == "array") {
        if (ncol(b) == 1) {
            b2 <- b[,1] # preserves colnames as names
        } else if (nrow(b) == 1) {
            b2 <- b[1, ] # preserves rownames as names
        } else {
            Xdim <- paste0(dim(b), collapse="x")
            errmsg <- paste("`b` should be 1D but has dim ", Xdim)
            stop(errmsg)
        }
    } else {
        b2 <- b
    }

    # Extract intercept
    if ("Intercept" %in% names(b2)) {
        b3 <- b2[names(b2) != "Intercept"]
        intercept <- b2["Intercept"]
    } else {
        b3 <- b2
        intercept <- 0
    }
    if (!is.numeric(b3)) {
        stop(paste("b3 must be numeric but is ", typeof(b3)))
    }

    # Caclulate scores
    tryCatch(
        expr = {
            scores <- as.numeric(as.matrix(X[, names(b3)]) %*% b3) + intercept
        },
        error = function(cond) {
            errmsg <- paste(
                "names(b3) must be in colnames(X), but the following are not: ",
                names(b3)[!(names(b3) %in% colnames(X))]
            )
            stop(errmsg)
        }
    )
    names(scores) <- rownames(X)

    return(scores)
}
