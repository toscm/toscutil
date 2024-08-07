% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/base.R
\name{named}
\alias{named}
\title{Create automatically named List}
\usage{
named(...)
}
\arguments{
\item{...}{List elements}
}
\value{
Object of type \code{list} with names attribute set
}
\description{
Like normal \code{list()}, except that unnamed elements are automatically named according to their symbol
}
\examples{
a <- 1:10
b <- "helloworld"
l1 <- list(a, b)
names(l1) <- c("a", "b")
l2 <- named(a, b)
stopifnot(identical(l1, l2))
l3 <- list(z = a, b = b)
l4 <- named(z = a, b)
stopifnot(identical(l3, l4))
}
\seealso{
\code{\link[=list]{list()}}
}
\keyword{base}
