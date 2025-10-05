# GitHub Copilot Instructions for CloudMonitoring

## Project Overview
CloudMonitoring is a Factorio mod that enables real-time monitoring of factory production and consumption metrics from external systems. The mod exports game data to files that can be consumed by a web GUI or other monitoring systems.

## Code Style and Conventions

### Lua Style
- Use 2 spaces for indentation
- Use snake_case for function and variable names
- Add descriptive comments for complex logic
- Follow Factorio modding API conventions
- Keep functions focused and single-purpose

### File Organization
- `control.lua`: Runtime game event handlers and logic
- `data.lua`: Data stage modifications (prototypes, recipes, etc.)
- `settings.lua`: Mod settings and configuration options
- `locale/`: Translation files for internationalization
- `graphics/`: Image assets for the mod

## Key Factorio API Patterns

### Event Handling
```lua
script.on_event(defines.events.on_tick, function(event)
  -- Event handler logic
end)

script.on_nth_tick(900, function(event)
  -- Runs every 900 ticks (15 seconds)
end)
```

### Data Access
- Use `game.forces` to iterate over all forces in the game
- Production statistics: `force.item_production_statistics`, `force.fluid_production_statistics`
- Use `game.write_file()` to output data to files

### Error Handling
- Always validate data before accessing nested properties
- Use `pcall()` for operations that might fail
- Log errors with `game.print()` or file output for debugging

## Feature Guidance

### When Adding Metrics
1. Always add a setting to enable/disable the metric
2. Include appropriate tick interval configuration
3. Format output consistently (metric_name.item_name value)
4. Document the metric format in README

### When Adding Settings
1. Define in `settings.lua`
2. Use appropriate setting type (bool, int, double, string)
3. Provide sensible default values
4. Add locale entries for setting names and descriptions

### Performance Considerations
- Avoid iterating over all entities every tick
- Use `script.on_nth_tick()` for periodic operations
- Cache frequently accessed data
- Minimize file I/O operations

## Testing Guidelines
- Test with different game stages (early game, late game)
- Verify multiplayer compatibility
- Check performance impact on large factories
- Validate file output format

## Common Pitfalls
- Don't access `game` object during data stage (data.lua)
- Remember that `game.tick` is measured in ticks (60 ticks = 1 second)
- File paths in `game.write_file()` are relative to script-output directory
- Production statistics are cumulative, calculate deltas if needed

## Documentation
- Update README.md when adding features
- Update CHANGELOG.md for version changes
- Add code comments for non-obvious logic
- Keep info.json metadata current
