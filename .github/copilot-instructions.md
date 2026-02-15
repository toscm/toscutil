# Copilot Instructions for toscutil

## Version Management

Every new bugfix or feature should be accompanied by:
1. A version increment according to semantic versioning
2. A corresponding description in NEWS.md

### Semantic Versioning

- **Major version** (x.0.0): Breaking changes
- **Minor version** (0.x.0): New features (backwards compatible)
- **Patch version** (0.0.x): Bug fixes (backwards compatible)

## Code Style

- **Indentation**: Use 4 spaces for indentation (no tabs)
- **Line length**: Maximum 80 characters per line
- **Simplicity**: Code should be as simple and concise as possible
- **Dependencies**: Use only packages shipped with a standard R installation
- **No pipe operator**: Do not use the pipe operator (`%>%` or `|>`)

## Guidelines

- Keep code readable and maintainable
- Follow existing code patterns in the repository
- Write clear documentation for functions
- Add tests for new features and bug fixes

## Updating Function Reference in README

Whenever a new function is added to the package, or when function documentation (titles) are updated, the function reference in README.md should be updated.

To update the function reference:

1. Make sure you have the latest version of the package loaded
2. Run the following R command from the package root directory:
   ```r
   toscutil::update_reference_in_readme()
   ```

This will:
- Read all documented functions from the package using `get_pkg_docs()`
- Categorize them according to the definitions in `_pkgdown.yml`
- Update the section between `<!-- BEGIN_FUNCTION_REFERENCE -->` and `<!-- END_FUNCTION_REFERENCE -->` markers in README.md
- Skip deprecated functions (those with keyword "depr")

The function reference will be automatically formatted with:
- Categories from _pkgdown.yml as section headers
- Functions listed alphabetically within each category
- Each function shown as: `function_name()`: Function title

## Important Notes

- Never manually edit the content between the HTML comment markers in README.md
- Always use `update_reference_in_readme()` to update the function reference
- Make sure _pkgdown.yml is up to date with correct categories and keywords
- Ensure all new functions have appropriate `@keywords` tags in their roxygen documentation
