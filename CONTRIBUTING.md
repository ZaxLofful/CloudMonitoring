# Contributing to CloudMonitoring

Thank you for your interest in contributing to CloudMonitoring! This document provides guidelines and information for contributors.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- A clear, descriptive title
- Steps to reproduce the issue
- Expected behavior vs actual behavior
- Your Factorio version and mod version
- List of other mods installed (if relevant)
- Log files or screenshots if applicable

### Suggesting Features

Feature requests are welcome! Please open an issue with:
- A clear description of the feature
- Use cases and benefits
- Any implementation ideas you have
- Consideration for performance impact

### Pull Requests

1. **Fork the repository** and create a new branch for your feature or fix
2. **Write clean code** following the project's style guidelines
3. **Test your changes** in Factorio with various scenarios
4. **Update documentation** (README, CHANGELOG, code comments)
5. **Submit a pull request** with a clear description of changes

## Development Guidelines

### Code Style

- Use 2 spaces for indentation
- Use descriptive variable and function names (snake_case)
- Add comments for complex logic
- Follow Factorio modding API conventions
- Keep functions focused and single-purpose

### Testing

Before submitting changes, test:
- Fresh game start
- Existing save compatibility
- Performance with large factories (1000+ SPM)
- Multiplayer functionality
- Interaction with popular mods (optional but recommended)

### Commit Messages

Write clear, concise commit messages:
- Use present tense ("Add feature" not "Added feature")
- First line: brief summary (50 chars or less)
- Add detailed description if needed
- Reference issues: "Fixes #123" or "Relates to #456"

### Performance Considerations

- Avoid operations on every tick unless absolutely necessary
- Use `script.on_nth_tick()` for periodic operations
- Cache frequently accessed data
- Profile performance impact for large factories
- Document any performance trade-offs

## Project Structure

```
CloudMonitoring/
├── .github/
│   └── copilot-instructions.md  # AI-assisted development guide
├── control.lua                   # Runtime event handlers
├── data.lua                      # Data stage (prototypes, recipes)
├── settings.lua                  # Mod configuration options
├── info.json                     # Mod metadata
├── locale/                       # Translation files
│   └── en/
│       └── locale.cfg
├── graphics/                     # Image assets
└── README.md                     # User documentation
```

## Adding New Features

### New Metrics

When adding a new metric type:

1. Add a setting in `settings.lua` to enable/disable it
2. Implement collection in `control.lua`
3. Use consistent output format
4. Update README with metric documentation
5. Add locale entries for any new settings

### New Settings

When adding configuration options:

1. Define in `settings.lua` with appropriate type
2. Provide sensible defaults
3. Add locale entries for name and description
4. Document in README
5. Test with various setting combinations

## Code Review Process

All pull requests will be reviewed for:
- Code quality and style
- Performance impact
- Documentation completeness
- Test coverage
- Compatibility considerations

Reviews may take a few days. Please be patient and responsive to feedback.

## Questions?

If you have questions about contributing, feel free to:
- Open an issue for discussion
- Check existing issues and pull requests
- Review the Factorio modding documentation

## License

By contributing to CloudMonitoring, you agree that your contributions will be licensed under the GNU General Public License v3.0.

Thank you for helping make CloudMonitoring better!
