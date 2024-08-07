% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trace.R
\name{trace_package}
\alias{trace_package}
\title{Traces function calls from a package}
\usage{
trace_package(
  pkg,
  file = stdout(),
  max = Inf,
  funign = character(),
  opsign = TRUE,
  dotign = TRUE,
  silent = TRUE,
  exitmsg = "exit"
)
}
\arguments{
\item{pkg}{Package name to trace.}

\item{file}{File to write to.}

\item{max}{Maximum depth of callstack to print.}

\item{funign}{Functions to ignore.}

\item{opsign}{Whether to ignore operators.}

\item{dotign}{Whether to ignore functions starting with a dot.}

\item{silent}{Whether to suppress messages.}

\item{exitmsg}{Message to print on function exits.}
}
\value{
No return value, called for side effects
}
\description{
Traces all function calls from a package and writes them to \code{file} with timestamps and callstack depth. Should always be used in combination with \code{\link[=untrace_package]{untrace_package()}} to untrace the package after use. For example \verb{trace_package("graphics"); on.exit(untrace_package("graphics")}. See examples for more details.
}
\details{
Some function define their own \code{\link[=on.exit]{on.exit()}} handlers with option \code{add = FALSE}. For those functions, exit tracing is impossible (as described in \code{\link[=trace]{trace()}}). For now those functions have to be detected and ignored manually by the user using argument \code{funign}.
}
\examples{
\dontrun{
# Trace all function from the graphics package, except for `plot.default`
# as it defines its own on.exit() handler, i.e. exit tracing is impossible.
local({
    trace_package("graphics", funign = "plot.default")
    on.exit(untrace_package("graphics"), add = TRUE)
    plot(1:10)
})
}
}
\seealso{
\code{\link[=untrace_package]{untrace_package()}}
}
\keyword{live}
