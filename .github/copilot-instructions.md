# GitHub Copilot Instructions for CloudMonitoring

## Project Overview
CloudMonitoring is a **server-side only** Factorio mod that enables real-time monitoring of factory production and consumption metrics from external systems. The mod exports game data to files that can be consumed by a web GUI or other monitoring systems.

**Critical Design Constraint**: This mod runs entirely on the server. Clients in multiplayer do not need to install it. Avoid adding any client-side features, UI elements, or settings.

## Code Style and Conventions

### Lua Style
- Use 2 spaces for indentation
- Use snake_case for function and variable names
- Add descriptive comments for complex logic
- Follow Factorio modding API conventions
- Keep functions focused and single-purpose

### File Organization
- `control.lua`: Runtime game event handlers and logic (server-side only)
- `data.lua`: Data stage modifications (prototypes, recipes, etc.)
- `info.json`: Mod metadata with optional dependencies for server-side operation
- **No settings.lua**: Server-side mods don't need client settings
- **No locale/**: No UI elements means no translations needed
- `graphics/`: Image assets for the mod (optional, for mod portal only)

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
1. Keep it server-side - no client UI or settings
2. Include appropriate tick interval in code (hardcoded or read from save data)
3. Format output consistently (metric_name.item_name value)
4. Document the metric format in README

### Server-Side Only Constraints
1. **No settings.lua**: All configuration must be in code or via remote interfaces
2. **No locale files**: No UI means no translations needed
3. **No client-side code**: Everything runs in control.lua on the server
4. **Optional dependencies**: Use `"? base"` in info.json to enable server-side only operation

### Performance Considerations
- Avoid iterating over all entities every tick
- Use `script.on_nth_tick()` for periodic operations
- Cache frequently accessed data
- Minimize file I/O operations
- Remember: only server performance matters, clients are unaffected

## Testing Guidelines
- Test in single-player (acts as server)
- **Critical**: Test multiplayer with clients that don't have the mod installed
- Verify clients can join without needing to download the mod
- Check performance impact on large factories (server-side only)
- Validate file output format

## Common Pitfalls
- Don't access `game` object during data stage (data.lua)
- Remember that `game.tick` is measured in ticks (60 ticks = 1 second)
- File paths in `game.write_file()` are relative to script-output directory
- Production statistics are cumulative, calculate deltas if needed
- **Don't add settings.lua or locale files** - this breaks server-side only operation

## Documentation
- Update README.md when adding features
- Update CHANGELOG.md for version changes
- Add code comments for non-obvious logic
- Keep info.json metadata current
