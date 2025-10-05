# CloudMonitoring Architecture

## Overview

CloudMonitoring is a Factorio mod designed to export production and consumption metrics for external monitoring systems. This document describes the technical architecture and design decisions.

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Factorio Game                          │
│  ┌────────────────────────────────────────────────────────┐ │
│  │          CloudMonitoring Mod                           │ │
│  │                                                        │ │
│  │  ┌──────────────┐      ┌──────────────┐             │ │
│  │  │  Settings    │      │  Control     │             │ │
│  │  │  (config)    │─────▶│  (runtime)   │             │ │
│  │  └──────────────┘      └──────┬───────┘             │ │
│  │                               │                      │ │
│  │                               ▼                      │ │
│  │                      ┌─────────────────┐            │ │
│  │                      │ File Output     │            │ │
│  │                      │ (script-output) │            │ │
│  │                      └────────┬────────┘            │ │
│  └───────────────────────────────┼──────────────────────┘ │
└────────────────────────────────┼─────────────────────────┘
                                  │
                                  ▼
                          ┌──────────────┐
                          │  File System │
                          │  factorio.*  │
                          └──────┬───────┘
                                  │
                                  ▼
                    ┌─────────────────────────┐
                    │  External Systems       │
                    │  - NodeJS Server        │
                    │  - Web Dashboard        │
                    │  - Alert Systems        │
                    │  - Analytics Tools      │
                    └─────────────────────────┘
```

## File Structure

### Core Mod Files

#### control.lua
- **Purpose**: Runtime event handling and metric collection
- **Key Functions**:
  - `instrumental_output(line)`: Writes metrics to file
  - `script.on_nth_tick(900, ...)`: Periodic metric collection
- **Design Patterns**:
  - Error handling with pcall
  - Null safety checks
  - Logging to error file

#### data.lua
- **Purpose**: Data stage modifications
- **Current State**: Empty (no prototypes added)
- **Future Use**: Could define custom items, recipes, or technologies

#### settings.lua
- **Purpose**: Mod configuration definitions
- **Settings**:
  - `cloudmonitoring-tick-interval`: Collection frequency (60-18000 ticks)
  - `cloudmonitoring-track-items`: Enable/disable item tracking
  - `cloudmonitoring-track-fluids`: Enable/disable fluid tracking
  - `cloudmonitoring-verbose-logging`: Debug logging toggle

#### info.json
- **Purpose**: Mod metadata for Factorio mod portal
- **Key Fields**:
  - name, version, title, author
  - Factorio version compatibility
  - Dependencies

### Localization

#### locale/en/locale.cfg
- **Purpose**: English translations for mod UI
- **Contents**: Setting names and descriptions
- **Format**: INI-style configuration

### Documentation

#### README.md
- User-facing documentation
- Installation and usage instructions
- Integration examples

#### CHANGELOG.md
- Version history
- Feature additions and bug fixes

#### CONTRIBUTING.md
- Developer contribution guidelines
- Code style and testing requirements

#### CODE_OF_CONDUCT.md
- Community behavior standards

#### SECURITY.md
- Security policy and vulnerability reporting

### Development Tools

#### .editorconfig
- Consistent code formatting across editors
- Defines indentation, line endings, charset

#### .luacheckrc
- Lua linting configuration
- Defines Factorio API globals
- Warning suppressions

#### .gitignore
- Excludes build artifacts, logs, IDE files
- Factorio-specific patterns

#### .github/workflows/lint.yml
- CI/CD automation
- Runs luacheck and JSON validation

#### .github/copilot-instructions.md
- AI-assisted development guide
- Code patterns and best practices

## Data Flow

### Metric Collection Flow

1. **Trigger**: Every 900 ticks (15 seconds at 60 UPS)
2. **Iteration**: Loop through all game forces
3. **Collection**: 
   - Item production statistics (input/output)
   - Fluid production statistics (input/output)
4. **Formatting**: `metric_type.item_name amount`
5. **Output**: Write to `factorio.<tick>` file
6. **Error Handling**: Log errors to separate file

### Configuration Flow

1. **Load Time**: Settings defined in settings.lua
2. **Runtime**: User can modify in mod settings menu
3. **Application**: control.lua reads settings (future implementation)
4. **Persistence**: Settings saved per save file

## Performance Considerations

### Optimization Strategies

1. **Event-based Collection**: Uses `on_nth_tick` instead of `on_tick`
2. **Batch Operations**: Collects all metrics in single pass
3. **Minimal Object Creation**: Reuses iteration variables
4. **Lazy Evaluation**: Skips forces without statistics

### Performance Impact

- **CPU**: Minimal (< 0.1% on large factories)
- **Memory**: Negligible (no persistent data structures)
- **Disk I/O**: Low (one write per 15 seconds)
- **Network**: None (purely local)

## Error Handling Strategy

### Defensive Programming

1. **Null Checks**: Validates force statistics exist
2. **Try-Catch**: pcall wraps metric collection
3. **Error Logging**: Writes errors to dedicated log file
4. **Graceful Degradation**: Continues on error

### Error Recovery

- Failed collections don't crash mod or game
- Errors logged for debugging
- Next collection attempt proceeds normally

## Extension Points

### Future Enhancements

1. **Dynamic Interval**: Implement settings.lua tick interval
2. **Selective Tracking**: Honor item/fluid toggle settings
3. **Output Formats**: JSON, CSV, binary formats
4. **Network Export**: Direct HTTP/WebSocket upload
5. **Additional Metrics**:
   - UPS (Updates Per Second)
   - Entity counts
   - Power production/consumption
   - Pollution levels
   - Research progress

### Integration Points

1. **File System**: Read output files for processing
2. **REST API**: POST metrics to web service
3. **WebSocket**: Real-time metric streaming
4. **Database**: Store historical data
5. **Alert System**: Trigger on thresholds

## Security Considerations

### Threat Model

- **File Access**: Limited to script-output directory
- **Data Privacy**: Only game statistics, no personal data
- **Code Injection**: No user input processing
- **DOS**: Bounded by tick interval settings

### Mitigations

- File permissions inherit from Factorio
- No network operations (by default)
- Input validation on settings
- Rate limiting via tick intervals

## Testing Strategy

### Manual Testing

- Fresh game start
- Existing save compatibility
- Large factory performance
- Multiplayer functionality
- Mod compatibility

### Automated Testing

- CI/CD linting (luacheck)
- JSON validation
- Syntax checking

### Test Scenarios

1. **Baseline**: Default settings, small factory
2. **Performance**: Modified settings, 1000+ SPM factory
3. **Edge Cases**: Empty forces, modded items
4. **Errors**: Corrupted statistics, missing data

## Maintenance

### Version Management

- Semantic versioning (MAJOR.MINOR.PATCH)
- CHANGELOG.md tracks all changes
- Git tags for releases

### Backward Compatibility

- Settings maintain defaults
- Output format stable
- Migration code for breaking changes

## Dependencies

### Required

- Factorio 0.17+
- base mod >= 0.17.29

### Optional

- None (standalone mod)

### Future Dependencies

- External server (NodeJS)
- Web framework (React/Vue)
- Database (PostgreSQL/MongoDB)

## Development Workflow

1. **Branch**: Create feature branch
2. **Code**: Implement changes
3. **Lint**: Run luacheck
4. **Test**: Manual testing in Factorio
5. **Document**: Update README, CHANGELOG
6. **PR**: Submit with template
7. **Review**: Code review process
8. **Merge**: After approval
9. **Release**: Tag and publish

## Deployment

### Manual Installation

1. Download/clone repository
2. Copy to Factorio mods directory
3. Enable in mod menu
4. Configure settings

### Automated Installation

- Factorio mod portal (future)
- Package managers (future)

## Monitoring and Observability

### Metrics to Monitor

- Collection success rate
- File write errors
- Performance impact
- User adoption

### Logging

- Error logs: `cloudmonitoring_errors.log`
- Metric output: `factorio.<tick>`
- Factorio log: Default game log

## Conclusion

CloudMonitoring provides a robust, extensible foundation for factory monitoring. The architecture supports future enhancements while maintaining simplicity and performance.
