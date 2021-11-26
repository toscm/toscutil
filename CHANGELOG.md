# Changelog

All notable changes to this project will be documented in this file.

The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), i.e.:

- There should be an entry for every single version.
- The latest version comes first.
- The release date of each version is displayed.
- The same types of changes should be grouped.
- The following keywords are used to denote different types of changes:
  - `Added` for new features
  - `Changed` for changes in existing functionality
  - `Deprecated` for soon-to-be removed features
  - `Removed` for now removed features
  - `Fixed` for bug fixes
  - `Security` in case of vulnerabilities

## [0.0.0.9003] - 2021-11-26

- `Changed`: `getfd` now throws an error if no sourced file can be found
- `Changed`: `getprd` renamed to `getpd`
- `Changed`: `getpd` now takes an argument of files used to decide which folder is the project root (default: `c(".git", "DESCRIPTION", "NAMESPACE")`)

## [0.0.0.9002] - 2021-11-18

- `Added`: `where` command
- `Added`: this changelog
- `Added`: ``+`` operator
