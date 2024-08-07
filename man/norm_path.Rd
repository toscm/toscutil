% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/base.R
\name{norm_path}
\alias{norm_path}
\title{Return Normalized Path}
\usage{
norm_path(..., sep = "/")
}
\arguments{
\item{...}{Parts used to construct the path}

\item{sep}{Path separator to be used on Windows}
}
\value{
Normalized path constructed from ...
}
\description{
Shortcut for \code{normalizePath(file.path(...), winslash = sep, mustWork = FALSE)}
}
\examples{
norm_path("C:/Users/max", "a\\\\b", "c") # returns C:/Users/max/a/b/c
norm_path("a\\\\b", "c") # return <current-working-dir>/a/b/c
}
\keyword{base}
