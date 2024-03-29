% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/depr.R
\name{cat0}
\alias{cat0}
\title{Concatenate and Print}
\usage{
cat0(..., sep = "", end = "")
}
\arguments{
\item{...}{objects passed on to \link[base]{cat}}

\item{sep}{a character vector of strings to append after each element}

\item{end}{a string to print after all other elements}
}
\value{
No return value, called for side effects
}
\description{
Same as \code{cat} but with an additional argument \code{end},
which gets printed after all other elements. Inspired by pythons \code{print}
command.

Warning: this function is deprecated and should no longer be used. The
function is guaranteed to be available as part of the package until the end
of 2023 but might removed at any time after 31.12.2023.
}
\examples{
cat0("hello", "world") # prints "helloworld" (without newline)
}
\keyword{depr}
