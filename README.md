# CloudMonitoring

A **server-side only** Factorio mod that enables real-time monitoring of your factory from external systems. Export production metrics, track resource consumption, and integrate with cloud-based monitoring solutions.

**Important**: This mod only needs to be installed on the server in multiplayer scenarios. Clients do not need to install it, ensuring optimal performance and no client-side overhead.

## Features

- **Server-Side Only**: No client installation required in multiplayer
- **Real-time Metrics Export**: Automatically exports production and consumption data every 15 seconds
- **Multiple Metric Types**: Tracks both item and fluid production/consumption statistics
- **File-based Output**: Writes metrics to timestamped files for easy integration
- **Multi-force Support**: Monitors all forces in the game simultaneously
- **Zero Client Impact**: No performance impact on players, all processing happens server-side
- **Low Performance Impact**: Optimized tick-based data collection on the server

## Installation

### Single Player or Server Owner

1. Download the latest release
2. Extract to your Factorio mods directory: `%appdata%/Factorio/mods` (Windows) or `~/.factorio/mods` (Linux/Mac)
3. Launch Factorio and enable the mod
4. Start or load a game

### Multiplayer Clients

**No installation needed!** This mod runs entirely on the server. Players connecting to a server with CloudMonitoring do not need to install anything.

## Usage

Once enabled, the mod automatically writes production metrics to files in your Factorio script-output directory:
- Windows: `%appdata%/Factorio/script-output/`
- Linux/Mac: `~/.factorio/script-output/`

### Output Format

Files are named `factorio.<tick>` and contain metrics in the following format:

```
item_production.<item_name> <amount>
item_consumption.<item_name> <amount>
fluid_production.<fluid_name> <amount>
fluid_consumption.<fluid_name> <amount>
```

### Example Output

```
item_production.iron-plate 1250
item_consumption.iron-plate 890
fluid_production.crude-oil 3500
fluid_consumption.crude-oil 2100
```

## Integration

This mod is designed to work with external monitoring systems:

1. **NodeJS Server**: A companion server can monitor the output directory and send data to cloud services
2. **Web GUI**: Build dashboards to visualize factory performance in real-time
3. **Alert Systems**: Set up notifications for production bottlenecks or shortages
4. **Data Analysis**: Collect historical data for optimization insights

## Configuration

The mod runs out of the box with sensible defaults:
- Collection interval: Every 900 ticks (15 seconds at 60 UPS)
- All item and fluid statistics are tracked
- Outputs are appended to tick-stamped files

## Performance

The mod is designed for minimal performance impact:
- Uses event-based tick handlers
- Only iterates through statistics, not entities
- File I/O is batched and infrequent

## Compatibility

- Factorio version: 0.17+
- Compatible with all mods
- Multiplayer compatible
- Works with modded items and fluids

## Roadmap

- [ ] Configurable collection intervals
- [ ] Selectable metric types
- [ ] Custom output formats (JSON, CSV)
- [ ] Network export capabilities
- [ ] Performance metrics (UPS, entity counts)
- [ ] Per-surface monitoring for Space Exploration compatibility

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

This project is licensed under the GNU General Public License v3.0 - see the LICENSE file for details.

## Author

**Zax Lofful**

## Acknowledgments

- Factorio development team for the excellent modding API
- The Factorio modding community for inspiration and support
