# CLAUDE.md

Guidance for Claude Code and other contributors working in this repository.

## Project

`toscutil` is an R package providing utility functions (see [DESCRIPTION](DESCRIPTION)
and [README.md](README.md)). Source lives in [R/](R), tests in
[tests/testthat](tests/testthat), generated docs in [man/](man).

## Contributing & workflow

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full contribution workflow,
including:

- **Making edits** — the `devtools::document()` / `test()` / `check()` checks to
  run after any change.
- **Tagging and GitHub releases** — every `Version` bump in
  [DESCRIPTION](DESCRIPTION) must be marked with an annotated `vX.Y.Z` git tag
  and a GitHub release whose notes come from the matching [NEWS.md](NEWS.md)
  section. This is manual; no GitHub Action creates tags or releases.
- **Releasing to CRAN** — the final checks and submission steps.

## Conventions

- Bump the `Version` field in [DESCRIPTION](DESCRIPTION) and add a matching
  `# toscutil vX.Y.Z` section to [NEWS.md](NEWS.md) for every user-facing change.
- Keep generated `man/*.Rd` in sync by running `devtools::document()` after
  changing roxygen comments in [R/](R).
