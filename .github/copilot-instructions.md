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

- **Line length**: Maximum 80 characters per line
- **Simplicity**: Code should be as simple and concise as possible
- **Dependencies**: Use only packages shipped with a standard R installation
- **No pipe operator**: Do not use the pipe operator (`%>%` or `|>`)

## Guidelines

- Keep code readable and maintainable
- Follow existing code patterns in the repository
- Write clear documentation for functions
- Add tests for new features and bug fixes
