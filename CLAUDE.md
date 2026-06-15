# CLAUDE.md

Guidance for Claude Code and other contributors working in this
repository.

## Project

`toscutil` is an R package providing utility functions (see
[DESCRIPTION](https://toscm.github.io/toscutil/DESCRIPTION) and
[README.md](https://toscm.github.io/toscutil/README.md)). Source lives
in [R/](https://toscm.github.io/toscutil/R), tests in
[tests/testthat](https://toscm.github.io/toscutil/tests/testthat),
generated docs in [man/](https://toscm.github.io/toscutil/man).

## Contributing & workflow

See [CONTRIBUTING.md](https://toscm.github.io/toscutil/CONTRIBUTING.md)
for the full contribution workflow, including:

- **Making edits** — the
  [`devtools::document()`](https://devtools.r-lib.org/reference/document.html)
  / `test()` / `check()` checks to run after any change.
- **Tagging and GitHub releases** — every `Version` bump in
  [DESCRIPTION](https://toscm.github.io/toscutil/DESCRIPTION) must be
  marked with an annotated `vX.Y.Z` git tag and a GitHub release whose
  notes come from the matching
  [NEWS.md](https://toscm.github.io/toscutil/NEWS.md) section. This is
  manual; no GitHub Action creates tags or releases.
- **Releasing to CRAN** — the final checks and submission steps.

## Conventions

- Bump the `Version` field in
  [DESCRIPTION](https://toscm.github.io/toscutil/DESCRIPTION) and add a
  matching `# toscutil vX.Y.Z` section to
  [NEWS.md](https://toscm.github.io/toscutil/NEWS.md) for every
  user-facing change.
- Keep generated `man/*.Rd` in sync by running
  [`devtools::document()`](https://devtools.r-lib.org/reference/document.html)
  after changing roxygen comments in
  [R/](https://toscm.github.io/toscutil/R).
