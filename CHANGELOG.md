# Changelog

All notable changes to the CloudMonitoring mod will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive README with installation and usage instructions
- GitHub Copilot instructions for development guidance
- CHANGELOG for tracking version history
- CONTRIBUTING guidelines for community participation
- Enhanced .gitignore with Factorio-specific patterns

### Changed
- Improved code structure and documentation
- Enhanced error handling in metric collection

## [0.1.0] - Initial Release

### Added
- Basic production and consumption tracking for items
- Basic production and consumption tracking for fluids
- File-based metric export every 15 seconds (900 ticks)
- Multi-force support
- Tick-stamped output files

### Technical Details
- Export interval: 900 ticks (15 seconds at 60 UPS)
- Output directory: Factorio script-output folder
- File format: Plain text with space-separated values
- Compatible with Factorio 0.17+

[Unreleased]: https://github.com/ZaxLofful/CloudMonitoring/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/ZaxLofful/CloudMonitoring/releases/tag/v0.1.0
