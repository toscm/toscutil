# Copilot Instructions for toscutil

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
