#' @export
#' @name predict.numeric
#' @title Predict Method for Numeric Vectors
#' @description Interprets the provided numeric vector as linear model and uses
#' it to generate predictions. If an element of the numeric vector has the name
#' `"Intercept"` this element is treated as the intercept of the linear model.
#' @param object Named numeric vector of beta values. If an element is named
#' "Intercept", that element is interpreted as model intercept.
#' @param newdata Matrix with samples as rows and features as columns.
#' @param ... further arguments passed to or from other methods
#' @return Named numeric vector of predicted scores
#' @examples X <- matrix(1:4, 2, 2, dimnames = list(c("s1", "s2"), c("a", "b")))
#' b <- c(Intercept = 3, a = 2, b = 1)
#' predict(b, X)
#' @keywords S3
predict.numeric <- function(object, newdata, ...) {
    b <- object
    X <- newdata
    # Convert b to named vector b2
    if (inherits(b, "matrix") || inherits(b, "array")) {
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

    # Calculate scores
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
